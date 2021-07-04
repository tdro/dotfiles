let

  name = "";

  pkgs = import <nixpkgs> { };

in pkgs.mkShell {

  inherit name;

  buildInputs = [ ];

  shellHook = ''
    export PS1='\h (${name}) \W \$ '
  '';
}
