### Source:  https://github.com/NixOS/nixpkgs/commit/459771518d44f60b59a19381d07b12297908215d
### Article: https://fzakaria.com/2021/08/02/a-minimal-nix-shell.html
### Usage:

# let
#
#   pkgs = import <nixpkgs> { };
#   mkShellMinimal = pkgs.callPackage (builtins.fetchurl {
#     url = "https://raw.githubusercontent.com/tdro/dotfiles/ae8c382ca82135ad2910cb3ef18c4e6f31ff0fde/.config/nixpkgs/helpers/mkShellMinimal.nix";
#     sha256 = "123ax7v6fbj1cq0kvr8jiphg99k04zw6b4r5dnn94fj1gmd2hxay";
#   }) { };
#
# in mkShellMinimal {
#   name = "minimal-shell";
#   packages = [ pkgs.hello ];
#   shellHook = ''
#     printf 'hello world'
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
