### Pure version of mkShellMinimal that clears all environment variables.
### Derived Source:  https://github.com/NixOS/nixpkgs/commit/459771518d44f60b59a19381d07b12297908215d
### Article: https://fzakaria.com/2021/08/02/a-minimal-nix-shell.html

{ writeTextFile, writeScript, system }:

{ shellHook ? "", packages ? [ ], ... }@attrs:
derivation ({
  inherit system;

  name = "pure-nix-shell";

  "stdenv" = writeTextFile rec {
    name = "setup";
    executable = true;
    destination = "/${name}";
    text = ''
      set -e
      for package in ${toString packages}; do
        export NEW_PATH=$package/bin:$NEW_PATH
      done
      exec /usr/bin/env --ignore-environment /bin/sh -c "
       export PATH=$NEW_PATH
      ${shellHook}
      /bin/sh
      "
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
