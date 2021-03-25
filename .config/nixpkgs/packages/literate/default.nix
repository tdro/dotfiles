{ stdenv, fetchgit, dmd, dub }:

stdenv.mkDerivation rec {
  name = "Literate";
  version = "7004dffec0cff3068828514eca72172274fd3f7d";

  src = fetchgit {
    rev = version;
    url = "https://github.com/zyedidia/Literate.git";
    sha256 = "0x4xgrdskybaa7ssv81grmwyc1k167v3nwj320jvp5l59xxlbcvs";
  };

  buildInputs = [ dmd dub ];

  installPhase = "install -D bin/lit $out/bin/lit";

  meta = with stdenv.lib; {
    description = "A literate programming tool for any language";
    homepage = "http://literate.zbyedidia.webfactional.com/";
    license = licenses.mit;
    platforms = platforms.unix;
  };
}
