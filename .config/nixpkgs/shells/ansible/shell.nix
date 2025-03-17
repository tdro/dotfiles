let

  # nix-shell -E 'import (builtins.fetchurl "$url")'

  name = "nix-shell.ansible";

  pkgs = import (builtins.fetchTarball {
    url = "https://releases.nixos.org/nixos/24.11/nixos-24.11.710905.a0f3e10d9435/nixexprs.tar.xz";
    sha256 = "01j4fa581yj276fyzsplizr82gckzwn3j6qlwk5phz4idz689v0y"; }) { };

  project = "${builtins.getEnv "HOME"}/Shares/Projects/infrastructure/ansible";

  python = pkgs.python3.withPackages (ps: with ps; [ mitogen ]);

  shell = pkgs.writeShellApplication {
    inherit name;
    text = ''
      /usr/bin/env --ignore-environment /bin/sh -c ${
        pkgs.writeScript name ''
          export HOME=/tmp/ansible
          export PS1='\h (${name}) \W \$ '
          export ANSIBLE_STRATEGY=mitogen_linear
          export ANSIBLE_STRATEGY_PLUGINS=${python}/lib/*/site-packages/ansible_mitogen/plugins
          export PATH=${
            pkgs.lib.strings.makeBinPath [
              python
              pkgs.ansible
              pkgs.busybox
              pkgs.openssh
            ]
          }
          mkdir --parents /tmp/ansible
          cd '${project}' || exit 1
          ssh -T git@github.com
          /bin/sh
        ''
      };
    '';
  };

in pkgs.mkShell {
  inherit name;
  shellHook = "${shell}/bin/${shell.name}; exit";
}
