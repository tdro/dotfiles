let

  # nix-shell -E 'import (builtins.fetchurl "$url")'
  # https://www.man7.org/linux/man-pages/man1/Firejail.1.html

  name = "nix-shell.firejail";

  pkgs = import (builtins.fetchTarball {
    url = "https://releases.nixos.org/nixos/22.11/nixos-22.11.466.596a8e828c5/nixexprs.tar.xz";
    sha256 = "1367bad5zz0mfm4czb6p0s0ni38f0x1ffh02z76rx4nranipqbgg";
  }) { };

  firejail = {
    rootfs ? "rootfs",
    options ? [ ],
    path ? [ pkgs.busybox ],
    entrypoint ? "/bin/sh"
  }:
  pkgs.writeShellApplication {
    inherit name;
    text =  ''
    set -euxo pipefail
    PATH=${pkgs.lib.strings.makeBinPath [ pkgs.firejail pkgs.coreutils ]}
    mkdir --parents '${rootfs}'
    firejail \
      --chroot '${rootfs}' \
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

  jail = firejail {
    options = [ ];
  };

in pkgs.mkShell {
  inherit name;
  shellHook = ''
    printf '%s\n' "${jail}/bin/${jail.name}"
    ${jail}/bin/${jail.name}; exit
  '';
}
