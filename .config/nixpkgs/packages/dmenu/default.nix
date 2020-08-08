{ stdenv, fetchurl, libX11, libXinerama, libXft, zlib, fetchpatch }:

stdenv.mkDerivation rec {
  name = "dmenu-4.9";

  src = fetchurl {
    url = "https://dl.suckless.org/tools/${name}.tar.gz";
    sha256 = "0ia9nqr83bv6x247q30bal0v42chcj9qcjgv59xs6xj46m7iz5xk";
  };

  buildInputs = [ libX11 libXinerama zlib libXft ];

  patches = [
    (fetchpatch {
      name = "dmenu-xresources-4.9.patch";
      url = "https://tools.suckless.org/dmenu/patches/xresources/dmenu-xresources-4.9.diff";
      sha256 = "0clczp17zwkxy1qhy0inqjplxpq4mgaf4vvfvn063hk733r4i7rn";
    })
    (fetchpatch {
      name = "xim.patch";
      url = "https://raw.githubusercontent.com/NixOS/nixpkgs/1f16d0496ce86d4c903e2e4ed6cbe4e952a7196f/pkgs/applications/misc/dmenu/xim.patch";
      sha256 = "006np7hlhr11wmj9652fcvacrw1fnv4w8hdlm80pyn0vn1wjdkw6";
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

  meta = with stdenv.lib; {
    license = licenses.mit;
    platforms = platforms.all;
    homepage = "https://tools.suckless.org/dmenu";
    maintainers = with maintainers; [ pSub globin ];
    description = "A generic, highly customizable, and efficient menu for the X Window System";
  };
}
