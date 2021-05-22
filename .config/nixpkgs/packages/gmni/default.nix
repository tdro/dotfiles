{ lib, stdenv, fetchgit, pkg-config, openssl }:

stdenv.mkDerivation rec {
  pname = "gmni";
  version = "f5d540bc5d0112895376aebe6bf54adb32545d6e";
  url = "https://git.sr.ht/~sircmpwn/gmni";

  src = fetchgit {
    inherit url;
    rev = version;
    sha256 = "0x4bg7mffq7vj9f3dj3s0m7q6f18nrysl68x6dlzk74hj6wsslbc";
  };

  buildInputs = [ pkg-config openssl ];

  meta = with lib; {
    homepage = url;
    license = licenses.gpl3;
    description = "A Gemini client";
  };
}
