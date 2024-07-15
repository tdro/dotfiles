let

  # nix-shell -E 'import (builtins.fetchurl "$url")'

  name = "nix-shell.ansible";

  pkgs = import (builtins.fetchTarball {
    url = "https://releases.nixos.org/nixos/21.11/nixos-21.11.336020.2128d0aa28e/nixexprs.tar.xz";
    sha256 = "0w8plbxms0di6gnh0k2yhj0pgxzxas7g5x0m01zjzixf16i2bapj";
  }) { };

  project = "${builtins.getEnv "HOME"}/Shares/Projects/infrastructure/ansible";

  python = pkgs.python39.withPackages (ps: with ps; [ mitogen ]);

  shell = pkgs.writeShellApplication {
    inherit name;
    text = ''
      /usr/bin/env --ignore-environment /bin/sh -c ${
        pkgs.writeScript name ''
          export HOME=/tmp
          export PS1='\h (${name}) \W \$ '
          export PATH=${pkgs.lib.strings.makeBinPath [
            python
            pkgs.busybox
            pkgs.openssh
            pkgs.ansible_2_10
          ]}
          export ANSIBLE_STRATEGY_PLUGINS=${python}/lib/*/site-packages/ansible_mitogen/plugins
          export ANSIBLE_STRATEGY=mitogen_linear
          cd '${project}' || exit 1
          ssh -T git@github.com
          /bin/sh
        ''
      };
    '';
  };

in pkgs.mkShell {
  inherit name;
  shellHook = "exec ${shell}/bin/${shell.name}";
}
