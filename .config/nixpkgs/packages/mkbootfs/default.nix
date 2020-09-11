{ stdenv, fetchgit }:

stdenv.mkDerivation rec {

  pname = "mkbootfs";
  url = "https://github.com/osm0sis/mkbootfs.git";
  version = "be612778c72ce848141eda99563960da5ff61389";

  src = fetchgit {
    inherit url;
    rev = version;
    sha256 = "09m9wblk9vnp10x9agqz1iaxp56xnpgvpncm949lcy5pbjlnvsnf";
  };

  installPhase = ''
    mkdir -p $out/bin
    cp mkbootfs $out/bin
  '';

  meta = with stdenv.lib; {
    homepage = url;
    platforms = platforms.linux;
    license = licenses.unlicense;
    description = "mkbootfs, forked and updated";
  };
}
