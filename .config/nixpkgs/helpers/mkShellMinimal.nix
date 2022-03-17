### Source:  https://github.com/NixOS/nixpkgs/commit/459771518d44f60b59a19381d07b12297908215d
### Article: https://fzakaria.com/2021/08/02/a-minimal-nix-shell.html
### Usage:

# let
#
#   name = "nix-shell.minimal";
#   pkgs = import <nixpkgs> { };
#
#   mkShellMinimal = pkgs.callPackage (builtins.fetchurl {
#     url = "https://raw.githubusercontent.com/tdro/dotfiles/0aac4414559235f8cd8c454acce30c0471e0f6b1/.config/nixpkgs/helpers/mkShellMinimal.nix";
#     sha256 = "06vbyyhaam3nmzimzasz6la590ni9cbdql3jy29hhw9ln0xf09yy";
#   }) { };
#
# in mkShellMinimal {
#   buildInputs = [ pkgs.coreutils pkgs.hello pkgs.gnugrep pkgs.which ];
#   ENV = "ENV";
#   shellHook = ''
#     hello
#     printf "%s\n" "$ENV"
#     which mkdir
#     printf "\nPATH is $PATH\n\n"
#     grep --version
#     export PS1='\h (${name}) \W \$ '
#   '';
# }

{ lib }:

{ packages ? [ ], inputsFrom ? [ ], buildInputs ? [ ], nativeBuildInputs ? [ ]
, propagatedBuildInputs ? [ ], propagatedNativeBuildInputs ? [ ], ... }@attrs:
let
  mergeInputs = name:
    (attrs.${name} or [ ]) ++ (lib.subtractLists inputsFrom
      (lib.flatten (lib.catAttrs name inputsFrom)));

  rest = builtins.removeAttrs attrs [
    "packages"
    "inputsFrom"
    "buildInputs"
    "nativeBuildInputs"
    "propagatedBuildInputs"
    "propagatedNativeBuildInputs"
    "shellHook"
  ];

  pkgs = import (builtins.fetchTarball {
    url = "https://releases.nixos.org/nixos/21.05/nixos-21.05.1510.a165aeceda9/nixexprs.tar.xz";
    sha256 = "124s05b0xk97arw0vvq8b4wcvsw6024dfdzwcx9qjxf3a2zszmam";
  }) { };

  stdenv = pkgs.stdenvNoCC.override {
    cc = null;
    preHook = "";
    allowedRequisites = null;
    initialPath = pkgs.coreutils;
    extraNativeBuildInputs = [ ];
  };

in stdenv.mkDerivation ({
  name = "nix-shell";
  phases = [ "nobuildPhase" ];

  buildInputs = mergeInputs "buildInputs";
  nativeBuildInputs = packages ++ (mergeInputs "nativeBuildInputs");
  propagatedBuildInputs = mergeInputs "propagatedBuildInputs";
  propagatedNativeBuildInputs = mergeInputs "propagatedNativeBuildInputs";

  shellHook = ''
    PATH=${stdenv.initialPath}/bin
    for package in ${toString buildInputs}; do
      export PATH=$package/bin:$PATH
    done
  '' + lib.concatStringsSep "\n"
    (lib.catAttrs "shellHook" (lib.reverseList inputsFrom ++ [ attrs ]));

  nobuildPhase = ''
    echo
    echo "This derivation is not meant to be built, aborting";
    echo
    exit 1
  '';
} // rest)
