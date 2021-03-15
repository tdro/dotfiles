with import <nixpkgs> { };

let

  version = "20.09";
  project = "${builtins.getEnv "HOME"}/Shares/Projects/infrastructure";
  channel = (import "${project}/nixos/versions.nix")."${version}".channel;

in mkShell {
  name = "nixops-${version}";
  shellHook = ''
    export VAULT_ADDR='http://vault.test'
    export NIX_PATH=${channel}/nixexprs.tar.xz
    export _NIX_CHANNEL=${channel}
    export PS1='\h (nixos ${version} ''${_NIX_CHANNEL##*.}) \W \$ '
    cd "${project}"
    ssh -T git@github.com
  '';
}
