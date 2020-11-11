{ stdenv, fetchFromGitHub, fetchpatch, libjpeg, ffmpeg, SDL }:

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

  patches = [
    (fetchpatch {
      name = "ntrviewer.patch";
      url = "https://aur.archlinux.org/cgit/aur.git/plain/ntrviewer.patch?h=ntrviewer-git";
      sha256 = "0lw1zmm4fdjb09iqsw593pdv4p36q77zq5lb2qh0xqcaf2ll84z5";
    })
  ];

  installPhase = ''
    runHook preInstall
    mkdir -p $out/bin
    mkdir -p $out/share/man/man1
    cp dist/Debug/GNU-Linux/ntrviewer $out/bin
    cp ntrviewer.1 $out/share/man/man1
    runHook postInstall
  '';

  meta = with stdenv.lib; {
    license = licenses.gpl3;
    inherit (src.meta) homepage;
    platforms = platforms.linux;
    description = "PC Viewer for 3DS NTR CFW's streaming feature.";
  };
}
