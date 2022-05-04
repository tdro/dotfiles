{ version ? "21.05" }:

let

  # nix-shell -E 'import (builtins.fetchurl "$url")'

  inherit version;
  pkgs = import <nixpkgs> { };
  name = "nix-shell.nixops.${version}.";
  project = "${builtins.getEnv "HOME"}/Shares/Projects/infrastructure";
  channel = (import "${project}/nixos/versions.nix")."${version}".channel;

in pkgs.mkShell {

  inherit name;

  shellHook = ''
    export NIXOPS_STATE=nixos/deployments.nixops
    export VAULT_TOKEN=$(cat $HOME/.local/share/vault/token)
    export VAULT_ADDR='http://vault.test'
    export NIX_PATH=${channel}/nixexprs.tar.xz
    export _NIX_CHANNEL=${channel}
    export PS1='\h (${name}''${_NIX_CHANNEL##*.}) \W \$ '
    cd '${project}' || exit 1
    ssh -T git@github.com
  '';
}
