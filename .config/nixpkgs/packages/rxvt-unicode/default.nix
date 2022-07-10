{ lib, stdenv, fetchurl, fetchpatch, makeDesktopItem, libX11, libXt, libXft
, libXrender, ncurses, fontconfig, freetype, pkg-config, gdk-pixbuf, perl }:

let
  pname = "rxvt-unicode";
  version = "9.26";
  description = "A clone of the well-known terminal emulator rxvt";

in stdenv.mkDerivation {

  inherit pname version;
  name = "${pname}-unwrapped-${version}";

  src = fetchurl {
    url = "http://dist.schmorp.de/rxvt-unicode/Attic/rxvt-unicode-${version}.tar.bz2";
    sha256 = "12y9p32q0v7n7rhjla0j2g9d5rj2dmwk20c9yhlssaaxlawiccb4";
  };

  buildInputs = [
    fontconfig
    freetype
    gdk-pixbuf
    libX11
    libXft
    libXrender
    libXt
    ncurses
    perl
    pkg-config
  ];

  outputs = [ "out" "terminfo" ];

  patches = [
    (fetchpatch {
      name = "enable-wide-glyphs.patch";
      url = "https://raw.githubusercontent.com/owl4ce/nelumbonaceae/e6be9823ec9ab7c14a23f5a25dfb33ce705d9950/x11-terms/rxvt-unicode/files/enable-wide-glyphs.patch";
      sha256 = "0vfpidysc1kxr3zark2y1b8fxx7k2lck79ccb7b97mgz04mxchvd";
    })
    (fetchpatch {
      name = "improve-font-rendering.patch";
      url = "https://raw.githubusercontent.com/owl4ce/nelumbonaceae/e6be9823ec9ab7c14a23f5a25dfb33ce705d9950/x11-terms/rxvt-unicode/files/improve-font-rendering.patch";
      sha256 = "0xkwvn204n679v4mgpw2dl4c30pdl622l6b2iw6sr0gijga8zqcd";
    })
    (fetchpatch {
      name = "256-color-resources.patch";
      url = "https://raw.githubusercontent.com/NixOS/nixpkgs/2bb3a9da24ca60d9f5bed69f679a1ec50dbdf997/pkgs/applications/terminal-emulators/rxvt-unicode/patches/256-color-resources.patch";
      sha256 = "sha256-lz0naMdlu7+e2/+zP6KvGTI6exIS4qx+Tqr0OpUkXGI=";
    })
    (fetchpatch {
      name = "fixed-layout-size.patch";
      url = "https://raw.githubusercontent.com/owl4ce/nelumbonaceae/b593a0eb7bb45a0b471c2ee2aa02b0e66776b9c0/x11-terms/rxvt-unicode/files/fixed-layout-size.patch";
      sha256 = "148vpln61zs3qv4sipcc5c7fiyc4d4q6k10r7bpr0k0q4pzshljh";
    })
  ];

  configureFlags = [
    "--enable-perl"
    "--enable-unicode3"
    "--enable-256-color"
    "--enable-wide-glyphs"
    "--with-terminfo=$terminfo/share/terminfo"
  ];

  CFLAGS = [ "-I${freetype.dev}/include/freetype2" ];
  LDFLAGS = [ "-lfontconfig" "-lXrender" "-lpthread" ];

  preConfigure = ''
    mkdir -p $terminfo/share/terminfo
    export TERMINFO=$terminfo/share/terminfo
    mkdir -p $out/$(dirname ${perl.libPrefix})
    ln -s $out/lib/urxvt $out/${perl.libPrefix}
  '';

  postInstall = ''
    mkdir -p $out/nix-support
    echo "$terminfo" >> $out/nix-support/propagated-user-env-packages
  '';

  meta = {
    inherit description;
    license = lib.licenses.gpl3;
    platforms = lib.platforms.unix;
    maintainers = with lib.maintainers; [ rnhmjoj ];
    downloadPage = "http://dist.schmorp.de/rxvt-unicode/Attic/";
    homepage = "http://software.schmorp.de/pkg/rxvt-unicode.html";
  };
}
