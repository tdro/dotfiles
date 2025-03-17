let

  # nix-shell -E 'import (builtins.fetchurl "$url")'
  # https://nsjail.dev/

  name = "nix-shell.nsjail";

  pkgs = import (builtins.fetchTarball {
    url = "https://releases.nixos.org/nixos/22.11/nixos-22.11.466.596a8e828c5/nixexprs.tar.xz";
    sha256 = "1367bad5zz0mfm4czb6p0s0ni38f0x1ffh02z76rx4nranipqbgg";
  }) { };

  nsjail = {
    rootfs ? "rootfs",
    options ? [ ],
    path ? [ pkgs.busybox ],
    entrypoint ? "/bin/sh"
  }:
  pkgs.writeShellApplication {
    inherit name;
    text =  ''
    set -euxo pipefail
    PATH=${pkgs.lib.strings.makeBinPath [ pkgs.nsjail pkgs.coreutils ]}
    mkdir --parents '${rootfs}'
    nsjail \
      --chroot "$(pwd)"/'${rootfs}' \
      ${pkgs.lib.strings.concatMapStringsSep " " (value: value) options} \
      -- /usr/bin/env --ignore-environment ${
        pkgs.writeScript "entrypoint-${name}" ''
          set -eu
          export PATH=${pkgs.lib.strings.makeBinPath path}
          ${entrypoint}
        ''
      };
  '';
  };

  jail = nsjail {
    options = [
      "--bindmount_ro /nix"
      "--bindmount_ro /usr"
      "--bindmount_ro /bin"
    ];
  };

in pkgs.mkShell {
  inherit name;
  shellHook = ''
    printf '%s\n' "${jail}/bin/${jail.name}"
    ${jail}/bin/${jail.name}; exit
  '';
}
