with import <nixpkgs> { };

let project = "${builtins.getEnv "HOME"}/Shares/Projects/infrastructure/ansible";

in mkShell rec {
  name = "ansible-mitogen";
  buildInputs = [ python38.pkgs.pip ansible_2_9 ];
  shellHook = ''
    export virtualenvs=$HOME/.local/share/virtualenvs
    mkdir -p $virtualenvs
    python -m venv $virtualenvs/ansible-mitogen
    . $virtualenvs/ansible-mitogen/bin/activate
    python -m pip install mitogen==0.2.9
    export ANSIBLE_STRATEGY_PLUGINS=$virtualenvs/ansible-mitogen/lib/python3.8/site-packages/ansible_mitogen/plugins
    export ANSIBLE_STRATEGY=mitogen_linear
    export PS1='\h (${name}) \W \$ '
    cd '${project}' || exit 1
    ssh -T git@github.com
  '';
}
