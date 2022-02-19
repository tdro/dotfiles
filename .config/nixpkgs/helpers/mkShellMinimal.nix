### Source:  https://github.com/NixOS/nixpkgs/commit/459771518d44f60b59a19381d07b12297908215d
### Article: https://fzakaria.com/2021/08/02/a-minimal-nix-shell.html

{ writeTextFile, writeScript, system }:

{ shellHook ? "", packages ? [ ], ... }@attrs:
derivation ({
  inherit system;

  name = "minimal-nix-shell";

  "stdenv" = writeTextFile rec {
    name = "setup";
    executable = true;
    destination = "/${name}";
    text = ''
      set -e
      PATH=
      for p in ${toString packages}; do
        export PATH=$p/bin:$PATH
      done
      ${shellHook}
    '';
  };

  builder = writeScript "builder.sh" ''
    #!/bin/sh
    echo
    echo "This derivation is not meant to be built, unless you want to capture the dependency closure.";
    echo
    export > $out
  '';
} // attrs)
