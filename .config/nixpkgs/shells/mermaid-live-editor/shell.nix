let

  name = "nix-shell.mermaid-live-editor";
  version = "bf6c54c00e84d8c7d541920607db72f50d775ba5";

  pkgs = import (builtins.fetchTarball {
    url = "https://releases.nixos.org/nixos/22.11/nixos-22.11.466.596a8e828c5/nixexprs.tar.xz";
    sha256 = "1367bad5zz0mfm4czb6p0s0ni38f0x1ffh02z76rx4nranipqbgg";
  }) { };

  package = pkgs.callPackage ({ lib, stdenv, fetchgit, mkYarnModules }:

    stdenv.mkDerivation rec {
      inherit version;
      pname = "mermaid-live-editor-node-modules";

      src = fetchgit {
        rev = version;
        url = "https://github.com/mermaid-js/mermaid-live-editor.git";
        sha256 = "sha256-SadZzBruGKh4LCR9vr87vl/HBEgVN8Qczi9+thGmNCE=";
      };

      node_modules = mkYarnModules {
        inherit pname version;
        yarnLock = "${src}/yarn.lock";
        packageJSON = "${src}/package.json";
      };

      installPhase = ''
        runHook preInstall
        mkdir $out
        cp --recursive --no-target-directory ${node_modules} $out
        cd $out/node_modules
        chmod +w .
        ln --symbolic mermaid-live-editor/node_modules/svelte-preprocess .
        runHook postInstall
      '';

      meta = with lib; {
        homepage = url;
        license = licenses.mit;
        description = "Edit, preview and share mermaid charts/diagrams. New implementation of the live editor.";
      };
    }) { };

  shell = pkgs.writeShellApplication {
    inherit name;
    text = ''
      /usr/bin/env --ignore-environment /bin/sh -c ${
        pkgs.writeScript name ''
          export PS1='\h (${name}) \W \$ '
          export PATH=${
            pkgs.lib.strings.makeBinPath [
              package
              pkgs.busybox
              pkgs.git
              pkgs.yarn
            ]
          }
          git clone https://github.com/mermaid-js/mermaid-live-editor.git
          cd mermaid-live-editor
          git checkout '${version}'
          ln -sf '${package}/node_modules'
          stat .svelte-kit || yarn build
          yarn preview
        ''
      };
    '';
  };

in pkgs.mkShell {
  inherit name;
  shellHook = "exec ${shell}/bin/${shell.name}";
}
