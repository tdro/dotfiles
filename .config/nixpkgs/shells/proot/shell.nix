let

  # nix-shell -E 'import (builtins.fetchurl "$url")'
  # https://manpages.ubuntu.com/manpages/trusty/man1/proot.1.html

  name = "nix-shell.proot";

  pkgs = import (builtins.fetchTarball {
    url = "https://releases.nixos.org/nixos/22.11/nixos-22.11.466.596a8e828c5/nixexprs.tar.xz";
    sha256 = "1367bad5zz0mfm4czb6p0s0ni38f0x1ffh02z76rx4nranipqbgg";
  }) { };

  proot = {
    rootfs ? "rootfs",
    binds ? [ ],
    options ? [ ],
    path ? [ pkgs.busybox ],
    entrypoint ? "/bin/sh"
  }:
  pkgs.writeShellApplication {
    inherit name;
    text =  ''
    set -euxo pipefail
    PATH=${pkgs.lib.strings.makeBinPath [ pkgs.proot pkgs.coreutils ]}
    mkdir --parents '${rootfs}'
    proot \
      --rootfs='${rootfs}' \
      ${pkgs.lib.strings.concatMapStringsSep " " (option: "--bind=${option}") binds} \
      ${pkgs.lib.strings.concatMapStringsSep " " (value: value) options} \
      /usr/bin/env --ignore-environment ${
        pkgs.writeScript "entrypoint-${name}" ''
          set -eu
          export HISTFILE=/dev/null
          export PATH=${pkgs.lib.strings.makeBinPath path}
          ${entrypoint}
        ''
      };
  '';
  };

  jail = proot {
    binds = [ "/nix" "/usr" "/bin" ];
    options = [ "--cwd=/" "--verbose=0" ];
  };

in pkgs.mkShell {
  inherit name;
  shellHook = ''
    printf '%s\n' "${jail}/bin/${jail.name}"
    exec "${jail}/bin/${jail.name}"
  '';
}
