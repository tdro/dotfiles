let

  name = "nix-shell.tilp2";

  pkgs = (import (builtins.fetchTarball {
    url = "https://releases.nixos.org/nixos/21.11/nixos-21.11.336020.2128d0aa28e/nixexprs.tar.xz";
    sha256 = "0w8plbxms0di6gnh0k2yhj0pgxzxas7g5x0m01zjzixf16i2bapj";
  }) { });

  package = pkgs.callPackage ({ stdenv, lib, fetchurl, fetchpatch
    , autoreconfHook, pkg-config, intltool, glib, gnome2, gtk2, gfm
    , libticables2, libticalcs2, libticonv, libtifiles2 }:

    stdenv.mkDerivation rec {
      pname = "tilp2";
      version = "1.18";
      src = fetchurl {
        url = "mirror://sourceforge/tilp/${pname}-${version}.tar.bz2";
        sha256 = "0isf73bjwk06baz2gm3vpdh600gqck9ca4aqxzb089dmxriv6fkv";
      };

      patches = fetchpatch {
        name = "remove-broken-kde-support.patch";
        url = "https://aur.archlinux.org/cgit/aur.git/plain/remove-broken-kde-support.patch?h=tilp";
        sha256 = "1fn6vh7r45spkwpmkvffkbn7zrcsdrs5mjmspd5rwi3jc12cy3ny";
      };

      nativeBuildInputs = [ autoreconfHook pkg-config intltool ];

      buildInputs = [
        glib
        gtk2
        gnome2.libglade
        gfm
        libticables2
        libticalcs2
        libticonv
        libtifiles2
      ];

      meta = with lib; {
        changelog = "http://lpg.ticalc.org/prj_tilp/news.html";
        description = "Transfer data between Texas Instruments graphing calculators and a computer";
        homepage = "http://lpg.ticalc.org/prj_tilp/";
        license = licenses.gpl2Plus;
        platforms = with platforms; linux ++ darwin;
      };
    }) { };

  shell = pkgs.writeShellApplication {
    inherit name;
    text = ''
      /usr/bin/env --ignore-environment /bin/sh -c ${
        pkgs.writeScript name ''
          export PS1='\h (${name}) \W \$ '
          export PATH=${pkgs.lib.strings.makeBinPath [ package pkgs.busybox ]}
          /bin/sh
        ''
      };
    '';
  };

in pkgs.mkShell {
  inherit name package;
  shellHook = "${shell}/bin/${shell.name}; exit";
}
