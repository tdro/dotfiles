with import <nixpkgs> { };

let
  project = "${builtins.getEnv "HOME"}/Shares/Projects/infrastructure";
  version = (import "${project}/nixos/versions.nix")."20.03".version;
  channel = (import "${project}/nixos/versions.nix")."20.03".channel;

in mkShell {
  name = "ansible-nixops-${version}";
  buildInputs = [ python38.pkgs.pip ];
  shellHook = ''
    export VAULT_ADDR='http://vault.test'
    export NIX_PATH=${channel}/nixexprs.tar.xz
    export _NIX_CHANNEL=${channel}
    export virtualenvs=$HOME/.local/share/virtualenvs
    mkdir -p $virtualenvs
    python -m venv $virtualenvs/ansible-mitogen
    . $virtualenvs/ansible-mitogen/bin/activate
    pip install mitogen==0.2.9
    export ANSIBLE_STRATEGY_PLUGINS=$virtualenvs/ansible-mitogen/lib/python3.8/site-packages/ansible_mitogen/plugins
    export ANSIBLE_STRATEGY=mitogen_linear
    export PS1='\h (nixos ${version} ''${_NIX_CHANNEL##*.}) \W \$ '
    cd "${project}"
    ssh -T git@github.com
  '';
}
