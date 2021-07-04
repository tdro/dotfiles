let

  # nix-shell -E 'import (builtins.fetchurl "$url")'

  name = "nix-shell.cake";

  pkgs = import (builtins.fetchTarball {
    url = "https://releases.nixos.org/nixos/21.05/nixos-21.05.650.eaba7870ffc/nixexprs.tar.xz";
    sha256 = "08fpds1bkv9106c6s5w3p5r4v3dc24bhk9asm9vqbxxypjglqg9l"; }) { };

  alpine-3-12-amd64 = pkgs.dockerTools.pullImage rec {
    imageName = "alpine";
    imageDigest = "sha256:2a8831c57b2e2cb2cda0f3a7c260d3b6c51ad04daea0b3bfc5b55f489ebafd71";
    sha256 = "1px8xhk0a3b129cc98d3wm4s0g1z2mahnrxd648gkdbfsdj9dlxp";
    finalImageName = imageName;
    finalImageTag = "3.12";
  };

  cook = { name, src, contents ? [ ], path ? [ ], script ? "", prepare ? "", cleanup ? "", sha256 ? pkgs.lib.fakeSha256 }: pkgs.stdenvNoCC.mkDerivation {
    inherit name src contents;
    phases = [ "unpackPhase" "installPhase" ];
    buildInputs = [ pkgs.proot pkgs.rsync pkgs.tree pkgs.kmod ];
    bootstrap = pkgs.writeScript "bootstrap-${name}" ''
      ${script}
      rm "$0"
    '';
    installPhase = ''
      set -euo pipefail
      mkdir --parents rootfs $out/rootfs
      tar --extract --file=layer.tar -C rootfs

      ${prepare}

      cp $bootstrap rootfs/bootstrap
      proot --cwd=/ --root-id --rootfs=rootfs /usr/bin/env - /bin/sh -euc '. /etc/profile && /bootstrap'
      printf 'PATH=${pkgs.lib.strings.makeBinPath path}:$PATH' >> rootfs/etc/profile

      [ -n "$contents" ] && {
        printf "\n"
        for paths in $contents; do
          printf "Cooking... Adding %s \n" "$paths"
          rsync --copy-dirlinks --relative --archive --chown=0:0 "$paths/" "rootfs" || exit 1
        done
        printf "\n"
      } || printf '\n%s\n' 'No contents to cook.';

      ${cleanup}

      printf '\n%s\n\n' "$(du --all --max-depth 1 --human-readable rootfs | sort --human-numeric-sort)"
      cp -rT rootfs $out/rootfs
    '';
    outputHashAlgo = "sha256";
    outputHashMode = "recursive";
    outputHash = sha256;
  };

  bake = { name, image, size ? "1G", debug ? false, kernel ? pkgs.linux, options ? [ ], modules ? [ ], uuid ? "99999999-9999-9999-9999-999999999999", sha256 ? pkgs.lib.fakeSha256 }: let
    initrd = cook {
      inherit sha256;
      name = "initrd-${name}";
      src = alpine-3-12-amd64;
      script = ''
        rm -rf home opt media root run srv tmp var
        printf '#!/bin/sh -eu
        mount -t devtmpfs none /dev
        mount -t proc none /proc
        mount -t sysfs none /sys
        sh /lib/modules/initrd/init
        ${pkgs.lib.optionalString (debug) "sh +m"}
        mount -r "$(findfs UUID=${uuid})" /mnt
        mount -o move /dev /mnt/dev
        umount /proc /sys
        exec switch_root /mnt /sbin/init
        ' > init
        chmod +x init
        find . ! -name bootstrap ! -name initramfs.cpio | cpio -H newc -ov > initramfs.cpio
        gzip -9 initramfs.cpio
      '';
      prepare = ''
      modules='${pkgs.lib.strings.concatMapStringsSep " " (module: module) modules}'
      initrd_directory=rootfs/lib/modules/initrd
      [ -n "$modules" ] && {
      mkdir --parents "$initrd_directory"
      printf "\n"
      for module in $modules; do
        module_file=$(find ${kernel} -name "$module.ko*" -type f)
        module_basename=$(basename "$module_file")
        printf "Cooking initrd... Adding module %s \n" "$module"
        cp "$module_file" "$initrd_directory" || exit 1
        printf 'insmod /lib/modules/initrd/%s\n' "$module_basename" >> "$initrd_directory/init"
      done
      } || printf '\n%s\n' 'No modules to cook.'
      '';
    }; in pkgs.writeScript name ''
    set -euo pipefail
    PATH=${pkgs.lib.strings.makeBinPath [
        pkgs.coreutils
        pkgs.e2fsprogs
        pkgs.gawk
        pkgs.rsync
        pkgs.syslinux
        pkgs.tree
        pkgs.utillinux
      ]}
    IMAGE=${name}.img
    LOOP=/dev/loop0
    ROOTFS=rootfs
    rm "$IMAGE" || true
    fallocate --length ${size} $IMAGE && chmod o+rw "$IMAGE"
    printf 'o\nn\np\n1\n2048\n\na\nw\n' | fdisk "$IMAGE"
    dd bs=440 count=1 conv=notrunc if=${pkgs.syslinux}/share/syslinux/mbr.bin of="$IMAGE"
    mkdir --parents "$ROOTFS"
    umount --verbose "$ROOTFS" || true
    losetup --detach "$LOOP" || true
    losetup --offset "$((2048 * 512))" "$LOOP" "$IMAGE"
    mkfs.ext4 -U ${uuid} "$LOOP"
    mount --verbose "$LOOP" "$ROOTFS"
    rsync --archive --chown=0:0 "${image}/rootfs/" "$ROOTFS";
    mkdir --parents "$ROOTFS/boot"
    cp ${kernel}/bzImage "$ROOTFS/boot/vmlinux"
    cp ${initrd}/rootfs/initramfs.cpio.gz "$ROOTFS/boot/initrd"
    printf '
    DEFAULT linux
    LABEL linux
      LINUX  /boot/vmlinux
      INITRD /boot/initrd
      APPEND ${pkgs.lib.strings.concatMapStringsSep " " (option: option) options}
    ' > "$ROOTFS/boot/syslinux.cfg"
    extlinux --heads 64 --sectors 32 --install $ROOTFS/boot
    printf '\n%s\n\n' "$(du --max-depth 1 --human-readable $ROOTFS | sort --human-numeric-sort)"
    umount --verbose "$ROOTFS"
    rm -r "$ROOTFS"
    losetup --detach "$LOOP"
  '';

  alpine = cook {
    name = "alpine";
    src = alpine-3-12-amd64;
    sha256 = "1ss4rh1fgs99h0v6czqq5rnfk1cag1ldazarm9jr5a0ahc4bnk0v";
    contents = [ pkgs.glibc pkgs.gawk ];
    path = [ pkgs.gawk ];
    script = ''
      cat /etc/alpine-release
      sed -i 's/#ttyS0/ttyS0/' /etc/inittab
    '';
  };

  alpine-machine = bake {
    name = "alpine-machine";
    image = alpine;
    sha256 = "0k5migqcrf5hz99ka5p6pr9qv86bd69y7fbs9m5qpby9qh3xmskf";
    kernel = pkgs.linuxPackages_5_10.kernel;
    options = [ "console=tty1" "console=ttyS0" ];
    size = "128M";
    modules = [
      "virtio"
      "virtio_ring"
      "virtio_blk"
      "virtio_pci"
      "jbd2"
      "mbcache"
      "crc16"
      "crc32c_generic"
      "ext4"
    ];
  };

  # proot --cwd=/ --rootfs=${alpine}/rootfs --bind=/proc --bind=/dev /usr/bin/env - /bin/sh -c '. /etc/profile && sh'
  # doas ${alpine-machine}
  # sudo ${alpine-machine}
  # qemu-system-x86_64 -nographic -drive if=virtio,file=./${alpine-machine.name}.img,format=raw
  # qemu-system-x86_64 -curses -drive if=virtio,file=./${alpine-machine.name}.img,format=raw

in pkgs.mkShell {

  inherit name;

  buildInputs = [ pkgs.proot pkgs.qemu ];

  shellHook = ''
    export PS1='\h (${name}) \W \$ '
    proot --cwd=/ --rootfs=${alpine}/rootfs --bind=/proc --bind=/dev /usr/bin/env - /bin/sh -c '. /etc/profile && sh'
    exit
  '';
}
