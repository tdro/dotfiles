with import <nixpkgs> {};

let version= (import /home/thedro/Shares/Projects/ansible/infrastructure/nixos/versions.nix).version; in

mkShell {
  name = "ansible-nixos";
  buildInputs = with python38.pkgs; [ pip ];
  shellHook = ''
    export VAULT_ADDR='http://vault.test'
    export NIX_PATH=nixpkgs=https://github.com/NixOS/nixpkgs/archive/${version}.tar.gz
    export virtualenvs=$HOME/.local/share/virtualenvs
    mkdir -p $virtualenvs
    python -m venv $virtualenvs/ansible-mitogen
    . $virtualenvs/ansible-mitogen/bin/activate
    python -m pip install mitogen
    export ANSIBLE_STRATEGY_PLUGINS=$virtualenvs/ansible-mitogen/lib/python3.8/site-packages/ansible_mitogen/plugins
    export ANSIBLE_STRATEGY=mitogen_linear
    export PS1='\h (deploy-personal) \W \$ '
  '';
}
