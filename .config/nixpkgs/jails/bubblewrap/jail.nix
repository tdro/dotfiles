let

  # nix-shell -E 'import (builtins.fetchurl "$url")'
  # https://github.com/containers/bubblewrap/blob/main/demos/bubblewrap-shell.sh
  # https://manpages.debian.org/testing/bubblewrap/bwrap.1.en.html

  name = "nix-shell.bubblewrap";

  pkgs = import (builtins.fetchTarball {
    url = "https://releases.nixos.org/nixos/22.11/nixos-22.11.466.596a8e828c5/nixexprs.tar.xz";
    sha256 = "1367bad5zz0mfm4czb6p0s0ni38f0x1ffh02z76rx4nranipqbgg";
  }) { };

  bubblewrap = arguments@{ ... }: pkgs.writeShellApplication {
    inherit name;
    text = ''
      PATH=${pkgs.lib.strings.makeBinPath [ pkgs.bubblewrap ]}
      bwrap \
    '' + pkgs.lib.strings.concatStringsSep " \\\n"
    (pkgs.lib.attrsets.mapAttrsToList (argument: value: "--${argument} ${value} ")
      arguments) + "/bin/sh\n";
    };

  jail = bubblewrap {
   clearenv = "";
   setenv = "PATH ${pkgs.lib.strings.makeBinPath [ pkgs.busybox ]}";
   ro-bind = "/nix /nix" + " --ro-bind /bin /bin";
  };

in pkgs.mkShell {
  inherit name;
  shellHook = ''
    printf '%s\n' "${jail}/bin/${jail.name}"
    exec "${jail}/bin/${jail.name}"
  '';
}
