let

  name = "nix-shell.pure";
  pkgs = import <nixpkgs> { };

  shell = pkgs.writeShellApplication {
    inherit name;
    text = ''
      /usr/bin/env --ignore-environment /bin/sh -c ${
        pkgs.writeScript name ''
          export PS1='\h (${name}) \W \$ '
          export PATH=${pkgs.lib.strings.makeBinPath [ pkgs.busybox ]}
          /bin/sh
        ''
      };
    '';
  };

in pkgs.mkShell {
  inherit name;
  shellHook = "exec ${shell}/bin/${shell.name}";
}
