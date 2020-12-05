{ stdenv, fetchFromGitHub, libX11, libXScrnSaver, libXext, meson, pkg-config
, ninja }:

stdenv.mkDerivation rec {
  pname = "xprintidle";
  version = "0.2.4";

  src = fetchFromGitHub {
    owner = "g0hl1n";
    repo = pname;
    rev = version;
    sha256 = "10na3ymzfhpq800wsyd23m57ngz69nn5i10c7p9iya8hzi7cf20a";
  };

  nativeBuildInputs = [ meson pkg-config ninja ];

  buildInputs = [ libX11 libXScrnSaver libXext ];

  meta = {
    inherit version;
    description = "A command-line tool to print idle time from libXss";
    homepage = "https://github.com/g0hl1n/xprintidle";
    license = stdenv.lib.licenses.gpl2;
    maintainers = [ stdenv.lib.maintainers.raskin ];
    platforms = stdenv.lib.platforms.linux;
  };
}
