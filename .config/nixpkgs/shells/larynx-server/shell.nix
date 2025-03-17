let

  name = "nix-shell.larynx-server";

  nixpkgs = import <nixpkgs> { };

  pkgs = import (builtins.fetchTarball {
    url = "https://releases.nixos.org/nixos/22.11/nixos-22.11.466.596a8e828c5/nixexprs.tar.xz";
    sha256 = "1367bad5zz0mfm4czb6p0s0ni38f0x1ffh02z76rx4nranipqbgg";
  }) { };

  larynx = pkgs.stdenvNoCC.mkDerivation rec {
    name = "larynx";
    version =  "1.1.0";
    sourceRoot = ".";

    src = pkgs.dockerTools.exportImage {
      fromImage = pkgs.dockerTools.pullImage rec {
        imageName = "rhasspy/larynx";
        imageDigest = "sha256:ada5b443e2446b38ba61d764ec37c0ed78d46e659a011243967e7cc8e52311e3";
        sha256 = "sha256-TbaHNNMRGp4SWYC06WSmNr3igpiJagDKoD3TEnttYt8=";
        finalImageName = imageName;
        finalImageTag = version;
      };
      diskSize = "3072";
    };

    phases = [ "unpackPhase" "installPhase" ];

    installPhase = ''
      mkdir --parents $out/bin/larynx/app
      cp --recursive home/larynx/app/.venv $out/bin/larynx/app
      cp --recursive home/larynx/app/larynx $out/bin/larynx/app
    '';
  };

  fhs = pkgs.buildFHSUserEnv {
    name = "larynx-server";
    runScript = "${pkgs.writeScriptBin name ''
      export PYTHONPATH=/bin/larynx/app
      /bin/larynx/app/.venv/bin/python3 -m larynx.server
    ''}/bin/${name}";
    targetPkgs = pkgs: [
     larynx
     pkgs.python39
    ];
    profile = "export FHS=1";
  };

in pkgs.mkShell {
  inherit fhs;
  inherit name;
  shellHook = "${fhs}/bin/${fhs.name}; exit";
}
