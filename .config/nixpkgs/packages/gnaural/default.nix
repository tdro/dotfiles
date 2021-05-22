{ lib, stdenv, fetchurl, portaudio, libsndfile, pkg-config, gtk2, gcc48 }:

stdenv.mkDerivation rec {

  pname = "gnaural";
  version = "20110606";

  src = fetchurl {
    url = "https://iweb.dl.sourceforge.net/project/gnaural/Gnaural/gnaural_${version}.tar.xz";
    sha256 = "1gq519c0imsh57zklyi0f8h64l3ai48lh672c834470z8c6kvbfi";
  };

  patches = [
    (fetchurl {
      name = "gnaural.patch";
      url = "https://aur.archlinux.org/cgit/aur.git/plain/gnaural.patch?h=gnaural";
      sha256 = "15bplxcvjml8cz7pi2fwb444fpp7ypsh279642v8s9hgl3i3jvsz";
    })
  ];

  buildInputs = [ gcc48 portaudio pkg-config gtk2 libsndfile ];

  meta = with lib; {
    license = licenses.gpl2;
    platforms = platforms.linux;
    homepage = "http://gnaural.sourceforge.net/";
    description = "Auditory binaural-beat generator";
  };
}
