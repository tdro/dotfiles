{ stdenv, fetchFromGitHub, libjpeg, ffmpeg, SDL }:

stdenv.mkDerivation rec {
  pname = "ntrviewer";
  version = "f1a8300d25a9e4253b2193c9ef12d08bd5334133";

  src = fetchFromGitHub {
    sha256 = "09csb3ra9yfskwzbjaqpnyy8nl7752k7jy7l9dw45jpgliav1fa2";
    rev = version;
    repo = pname;
    owner = "44670";
  };

  buildInputs = [ libjpeg ffmpeg SDL ];

  patches = [ ./ntrviewer.patch ];

  installPhase = ''
    mkdir -p $out/bin
    cp dist/Debug/GNU-Linux/ntrviewer $out/bin
  '';

  meta = with stdenv.lib; {
    inherit (src.meta) homepage;
    description = "PC Viewer for 3DS NTR CFW's streaming feature.";
    license = licenses.gpl3;
    platforms = platforms.linux;
  };
}
