let

  # nix-shell -E 'import (builtins.fetchurl "$url")'

  name = "nix-shell.falcon-kernel";

  pkgs = import (builtins.fetchTarball {
    url = "https://github.com/NixOS/nixpkgs/archive/360e2af4f87.tar.gz";
    sha256 = "1i3i9cpn6m3r07pgw4w3xinbqmxkm7pmnqjlz96x424ngbc21sg2"; }) {};

  project = "${builtins.getEnv "HOME"}/Desktop/moto-falcon/lineageos-kernel/lineageos-motorala-msm8226";

  toolchain = pkgs.stdenv.mkDerivation rec {
    name = "gcc-linaro-4.9.4";
    src = builtins.fetchTarball {
      url = "https://releases.linaro.org/components/toolchain/binaries/4.9-2017.01/arm-linux-gnueabihf/gcc-linaro-4.9.4-2017.01-x86_64_arm-linux-gnueabihf.tar.xz";
      sha256 = "11zznrx0hkq34bn7x7kxn5q9icrf22vqgmd1ifxmdskm2g14x3l8";
    };
    dontBuild = true;
    buildInputs = builtins.attrValues { inherit (pkgs) python2 zlib ncurses5 expat lzma; };
    nativeBuildInputs = builtins.attrValues { inherit (pkgs) autoPatchelfHook; };
    installPhase = ''
      runHook preInstall
      mkdir $out
      cp -rT ${src} $out
      runHook postInstall
    '';
  };

in pkgs.mkShell {

  inherit name;

  buildInputs = builtins.attrValues { inherit (pkgs) gnumake ncurses; };

  shellHook = ''
    export CROSS_COMPILE=${toolchain}/bin/arm-linux-gnueabihf-
    export ARCH=arm
    export PS1='\h (${name}) \W \$ '
    cd '${project}' || exit 1
  '';
}
