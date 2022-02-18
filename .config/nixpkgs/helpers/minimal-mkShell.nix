### Derived from https://fzakaria.com/2021/08/02/a-minimal-nix-shell.html
### Usage Example:

# let
#   minimal = import (builtins.fetchurl {
#     url = "https://raw.githubusercontent.com/tdro/dotfiles/83b77bf625613a01c47d82e2b08974bfdf219c51/.config/nixpkgs/helpers/minimal-mkShell.nix";
#     sha256 = "17w4slnz3p28y5h744wz0zw15122230jafy40yz4fsbvzg3hb6fh";
#   });
# in minimal.mkShell {
#   name = "minimal-shell";
#   buildInputs = [ ];
#   shellHook = "";
# }

rec {
  pkgs = import (builtins.fetchTarball {
    url = "https://releases.nixos.org/nixos/21.05/nixos-21.05.1510.a165aeceda9/nixexprs.tar.xz";
    sha256 = "124s05b0xk97arw0vvq8b4wcvsw6024dfdzwcx9qjxf3a2zszmam";
  }) { };

  stdenv = pkgs.stdenvNoCC.override {
    cc = null;
    preHook = "";
    allowedRequisites = null;
    initialPath = [ pkgs.busybox ];
    extraNativeBuildInputs = [ ];
  };

  mkShell = pkgs.mkShell.override { inherit stdenv; };
}
