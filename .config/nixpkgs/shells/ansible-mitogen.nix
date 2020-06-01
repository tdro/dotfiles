with import <nixpkgs> {};

mkShell {

  name = "ansible";
  buildInputs = with python38.pkgs; [ pip ];
  shellHook = ''
    export virtualenvs=$HOME/.local/share/virtualenvs
    mkdir -p $virtualenvs
    python -m venv $virtualenvs/ansible-mitogen
    . $virtualenvs/ansible-mitogen/bin/activate
    python -m pip install mitogen
    export ANSIBLE_STRATEGY_PLUGINS=$virtualenvs/ansible-mitogen/lib/python3.8/site-packages/ansible_mitogen/plugins
    export ANSIBLE_STRATEGY=mitogen_linear
    export PS1='(ansible-mitogen) '
  '';
}
