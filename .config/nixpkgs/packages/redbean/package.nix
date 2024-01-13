{ lib, stdenv, fetchurl }:

stdenv.mkDerivation rec {

  pname = "redbean";
  version = "2.0.1";

  src = fetchurl {
    url = "https://redbean.dev/redbean-${version}.com";
    sha256 = "sha256-W5GpecQdDwawkrkmENxSqCz40PkyrLh34FtiUwD7Kzk=";
  };

  dontFixup = true;
  dontUnpack = true;

  installPhase = ''
    runHook preInstall
    mkdir --parents $out/bin
    cp ${src} $out/bin/${pname}.com
    chmod +x $out/bin/${pname}.com
    runHook postInstall
  '';

  meta = with lib; {
    license = licenses.isc;
    platforms = platforms.all;
    homepage = "https://github.com/jart/cosmopolitan";
  };
}
