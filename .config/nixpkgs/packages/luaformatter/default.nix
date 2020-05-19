{ stdenv, fetchFromGitHub, cmake }:

stdenv.mkDerivation rec {
  pname = "LuaFormatter";
  version = "1.3.3";

  src = fetchFromGitHub {
    sha256 = "1dfqsh6v8brnwzg3lgi7228lw08qqfy4ghbjyvwn7mr82fy1xcnd";
    rev = version;
    repo = pname;
    owner = "Koihik";
    fetchSubmodules = true;
  };

  buildInputs = [ cmake ];

  meta = with stdenv.lib; {
    inherit (src.meta) homepage;
    description = "Code formatter for Lua";
    license = licenses.asl20;
    platforms = platforms.linux;
  };
}
