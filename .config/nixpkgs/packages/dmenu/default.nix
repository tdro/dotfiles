{ lib, stdenv, fetchgit, libX11, libXinerama, libXft, zlib }:

stdenv.mkDerivation rec {
  name = "dmenu";
  version = "9b0be7712e2aae65b459f758a080c56983056021";

  src = fetchgit {
    rev = version;
    url = "https://www.thedroneely.com/git/thedroneely/dmenu/";
    sha256 = "0sbwwxbm5bcn0m4s1y2gl90wc224kf6755d1xdr23bz5ihy3jzg2";
  };

  buildInputs = [ libX11 libXinerama zlib libXft ];

  postPatch = ''
    sed -ri -e 's!\<(dmenu|dmenu_path|stest)\>!'"$out/bin"'/&!g' dmenu_run
    sed -ri -e 's!\<stest\>!'"$out/bin"'/&!g' dmenu_path
  '';

  preConfigure = ''
    sed -i "s@PREFIX = /usr/local@PREFIX = $out@g" config.mk
  '';

  makeFlags = [ "CC:=$(CC)" ];

  meta = {
    license = lib.licenses.mit;
    platforms = lib.platforms.all;
    homepage = "https://tools.suckless.org/dmenu";
    maintainers = with lib.maintainers; [ pSub globin ];
    description = "A generic, highly customizable, and efficient menu for the X Window System";
  };
}
