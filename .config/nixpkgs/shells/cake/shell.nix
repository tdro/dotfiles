let

  # nix-shell -E 'import (builtins.fetchurl "$url")'
  # NIX_CONFIG="sandbox = false"   nix-shell --option builders '' shell.nix
  # NIX_CONFIG="sandbox = relaxed" nix-shell --option builders '' shell.nix

  name = "nix-shell.cake";

  pkgs = import (builtins.fetchTarball {
    url = "https://releases.nixos.org/nixos/23.11/nixos-23.11.6510.a5e4bbcb4780/nixexprs.tar.xz";
    sha256 = "0f73pbh4j89wgk7rn9xp0q8ybw15zkhw0prjz5r37aaryjs8hnbd";
  }) { };

  alpine = pkgs.fetchurl {
    url = "https://dl-cdn.alpinelinux.org/alpine/v3.19/releases/x86_64/alpine-minirootfs-3.19.1-x86_64.tar.gz";
    sha256 = "sha256-GFEjzrbn0I8kSf/1VD2yBv+3nezYFGCNOZrUR+CPop4=";
  };

  cook = { name, src, contents ? [ ], path ? [ ], script ? "", prepare ? "", cleanup ? "" }: pkgs.stdenvNoCC.mkDerivation {
    __noChroot = true;
    inherit name src contents;
    phases = [ "installPhase" ];
    buildInputs = [ pkgs.proot pkgs.rsync pkgs.tree pkgs.kmod ];
    bootstrap = pkgs.writeScript "bootstrap-${name}" ''
      ${script}
      rm "$0"
    '';
    PROOT_NO_SECCOMP = "1";
    installPhase = ''
      set -euo pipefail
      mkdir --parents rootfs $out/rootfs
      tar --extract --file=${src} -C rootfs

      ${prepare}

      cp $bootstrap rootfs/bootstrap
      proot --cwd=/ --root-id --rootfs=rootfs /usr/bin/env - /bin/sh -euc 'BASH_VERSION= . /etc/profile && /bootstrap'
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
      cp --recursive --no-target-directory rootfs $out/rootfs
    '';
  };

  bake = { name, image, size ? "1G", debug ? false, kernel ? pkgs.linux, options ? [ ], modules ? [ ], uuid ? "99999999-9999-9999-9999-999999999999" }: let
    initrd = cook {
      name = "initrd-${name}";
      src = alpine;
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

  system = cook {
    name = "alpine";
    src = alpine;
    contents = [ pkgs.glibc pkgs.gawk ];
    path = [ pkgs.gawk ];
    script = ''
      cat /etc/alpine-release
      sed -i 's/#ttyS0/ttyS0/' /etc/inittab
      printf 'migh7Lib\nmigh7Lib\n' | adduser alpine
    '';
  };

  machine = cook {
    name = "alpine";
    src = alpine;
    contents = [ pkgs.glibc pkgs.gawk ];
    path = [ pkgs.gawk ];
    script = ''
      apk update
      apk upgrade
      apk add openrc
      cat /etc/alpine-release
      sed -i 's/#ttyS0/ttyS0/' /etc/inittab
      printf 'migh7Lib\nmigh7Lib\n' | adduser alpine
    '';
  };

  virtual-machine = bake {
    name = "alpine-machine";
    image = machine;
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

  container = { rootfs, binds ? [ ], options ? [] }:
    pkgs.writeScript name ''
    set -euxo pipefail
    PATH=${pkgs.lib.strings.makeBinPath [ pkgs.proot ]}
    proot \
      --cwd=/ \
      --rootfs='${rootfs}' \
      ${pkgs.lib.strings.concatMapStringsSep " " (option: "--bind=${option}") binds} \
      ${pkgs.lib.strings.concatMapStringsSep " " (value: value) options} \
      /usr/bin/env - /bin/sh -c '. /etc/profile && sh'
  '';

in pkgs.mkShell {

  inherit name;

  buildInputs = [ pkgs.proot pkgs.qemu ];

  shellHook = ''
    export PS1='\h (${name}) \W \$ '

    # sudo ${virtual-machine}
    # doas ${virtual-machine}
    # qemu-system-x86_64 -nographic -drive if=virtio,file=./${virtual-machine.name}.img,format=raw
    # qemu-system-x86_64 -curses    -drive if=virtio,file=./${virtual-machine.name}.img,format=raw

    ${container {
      rootfs = "${system}/rootfs";
      binds = [ "/proc" "/dev" ];
      options = [ "--verbose=0" ];
    }}
    exit
  '';
}
