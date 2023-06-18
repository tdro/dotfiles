let

  # nix-shell -E 'import (builtins.fetchurl "$url")'

  name = "nix-shell.ansible";

  pkgs = import (builtins.fetchTarball {
    url = "https://releases.nixos.org/nixos/21.11/nixos-21.11.336020.2128d0aa28e/nixexprs.tar.xz";
    sha256 = "0w8plbxms0di6gnh0k2yhj0pgxzxas7g5x0m01zjzixf16i2bapj";
  }) { };

  project = "${builtins.getEnv "HOME"}/Shares/Projects/infrastructure/ansible";

  python = pkgs.python39.withPackages (ps: with ps; [ mitogen ]);

in pkgs.mkShell {

  inherit name;

  buildInputs = [ python pkgs.ansible_2_10 ];

  shellHook = ''
    export ANSIBLE_STRATEGY_PLUGINS=${python}/lib/*/site-packages/ansible_mitogen/plugins
    export ANSIBLE_STRATEGY=mitogen_linear
    export PS1='\h (${name}) \W \$ '
    cd '${project}' || exit 1
    ssh -T git@github.com
  '';
}
