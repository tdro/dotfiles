{ lib, stdenv, fetchgit }:

stdenv.mkDerivation rec {

  pname = "mkbootimg";
  url = "https://github.com/osm0sis/mkbootimg.git";
  version = "8dd5b5b5c68bcf8ecdb5859aa7036df276efcc79";

  src = fetchgit {
    inherit url;
    rev = version;
    sha256 = "0l1xg2ifaznpkhi74kyrjr2sqsihzp99bdn1c6y0qwfxn6rgbxn2";
  };

  installPhase = ''
    mkdir -p $out/bin
    cp mkbootimg $out/bin
    cp unpackbootimg $out/bin
  '';

  meta = with lib; {
    homepage = url;
    platforms = platforms.linux;
    license = licenses.unlicense;
    description = "mkbootimg + unpackbootimg, forked and updated";
  };
}
