let

  # nix-shell -E 'import (builtins.fetchurl "$url")'

  name = "nix-shell.nixops.${version}.";
  pkgs = import <nixpkgs> { };
  version = "20.09";
  project = "${builtins.getEnv "HOME"}/Shares/Projects/infrastructure";
  channel = (import "${project}/nixos/versions.nix")."${version}".channel;

in pkgs.mkShell {

  inherit name;

  shellHook = ''
    export VAULT_ADDR='http://vault.test'
    export NIX_PATH=${channel}/nixexprs.tar.xz
    export _NIX_CHANNEL=${channel}
    export PS1='\h (${name}''${_NIX_CHANNEL##*.}) \W \$ '
    cd '${project}' || exit 1
    ssh -T git@github.com
  '';
}
