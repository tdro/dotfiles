### Source:  https://github.com/NixOS/nixpkgs/commit/459771518d44f60b59a19381d07b12297908215d
### Article: https://fzakaria.com/2021/08/02/a-minimal-nix-shell.html
### Usage:

# let
#
#   name = "nix-shell.minimal";
#   pkgs = import <nixpkgs> { };
#
#   mkShellMinimal = pkgs.callPackage (builtins.fetchurl {
#     url = "https://raw.githubusercontent.com/tdro/dotfiles/b710281b132056105709c03dda1899a6afc68a93/.config/nixpkgs/helpers/mkShellMinimal.nix";
#     sha256 = "0smaflcj4r9q0ix45hx904sfmrhdkav6pvv2m7xapc68ykw0ry1i";
#   }) { };
#
# in mkShellMinimal {
#   packages = [ pkgs.hello pkgs.gnugrep ];
#   shellHook = ''
#     hello
#     printf "$PATH\n"
#     grep --version
#     export PS1='\h (${name}) \W \$ '
#   '';
# }

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
      for package in ${toString packages}; do
        export PATH=$package/bin:$PATH
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
