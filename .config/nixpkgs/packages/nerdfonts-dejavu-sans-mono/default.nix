{ lib, stdenv, fetchurl, unzip }:

stdenv.mkDerivation rec {

  pname = "nerdfonts-dejavu-sans-mono";
  version = "2.1.0";
  buildInputs = [ unzip ];

  src = fetchurl {
    url = "https://github.com/ryanoasis/nerd-fonts/releases/download/v${version}/DejaVuSansMono.zip";
    sha256 = "03qfrkzmhnn8dwgx4qhiigbz4dxs3957hydlr0j8vxl89j8c9g1z";
  };

  phases = [ "unpackPhase" "installPhase" ];
  unpackPhase = '' unzip ${src} '';

  installPhase = ''
    runHook preInstall
    mkdir --parents $out/share/fonts/nerdfonts-dejavu-sans-mono
    cp --recursive * $out/share/fonts/nerdfonts-dejavu-sans-mono
    runHook postInstall
  '';

  meta = with lib; {
    license = licenses.mit;
    platforms = platforms.all;
    homepage = "https://github.com/ryanoasis/nerd-fonts";
  };
}
