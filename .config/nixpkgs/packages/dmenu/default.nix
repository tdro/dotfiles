{ lib, stdenv, fetchurl, fetchpatch, libX11, libXinerama, libXft, zlib }:

stdenv.mkDerivation rec {
  name = "dmenu-5.0";

  src = fetchurl {
    url = "https://dl.suckless.org/tools/${name}.tar.gz";
    sha256 = "1lvfxzg3chsgcqbc2vr0zic7vimijgmbvnspayx73kyvqi1f267y";
  };

  buildInputs = [ libX11 libXinerama zlib libXft ];

  patches = [
    (fetchpatch {
      name = "dmenu-xresources-4.9.patch";
      url = "https://tools.suckless.org/dmenu/patches/xresources/dmenu-xresources-4.9.diff";
      sha256 = "0clczp17zwkxy1qhy0inqjplxpq4mgaf4vvfvn063hk733r4i7rn";
    })
    (fetchpatch {
      name = "dmenu-fuzzymatch-4.9.patch";
      url = "https://tools.suckless.org/dmenu/patches/fuzzymatch/dmenu-fuzzymatch-4.9.diff";
      sha256 = "000fkg4dcr2vrpd442f2v6ycmmxdml781ziblzx5rxvvyclsryfd";
    })
  ];

  postPatch = ''
    sed -ri -e 's!\<(dmenu|dmenu_path|stest)\>!'"$out/bin"'/&!g' dmenu_run
    sed -ri -e 's!\<stest\>!'"$out/bin"'/&!g' dmenu_path
  '';

  preConfigure = ''
    sed -i "s@PREFIX = /usr/local@PREFIX = $out@g" config.mk
  '';

  makeFlags = [ "CC:=$(CC)" ];

  meta = with lib; {
    description = "A generic, highly customizable, and efficient menu for the X Window System";
    homepage = "https://tools.suckless.org/dmenu";
    license = licenses.mit;
    maintainers = with maintainers; [ pSub globin ];
    platforms = platforms.all;
  };
}
