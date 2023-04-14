let

  name = "nix-shell.scribus";

  pkgs = (import (builtins.fetchTarball {
    url = "https://releases.nixos.org/nixos/21.11/nixos-21.11.336020.2128d0aa28e/nixexprs.tar.xz";
    sha256 = "0w8plbxms0di6gnh0k2yhj0pgxzxas7g5x0m01zjzixf16i2bapj";
  }) { });

  package = pkgs.callPackage ({ lib, stdenv, fetchurl, pkg-config, freetype, lcms, libtiff
    , libxml2, gnome2, qt4, python2, cups, fontconfig, libjpeg, zlib, libpng
    , xorg, cairo, podofo, hunspell, boost, cmake, imagemagick, ghostscript }:

    let
      icon = fetchurl {
        url = "https://gist.githubusercontent.com/ejpcmac/a74b762026c9bc4000be624c3d085517/raw/18edc497c5cb6fdeef1c8aede37a0ee68413f9d3/scribus-icon-centered.svg";
        sha256 = "0hq3i7c2l50445an9glhhg47kj26y16svfajc6naqn307ph9vzc3";
      };
      pythonEnv = python2.withPackages (ps: [ ps.tkinter ps.pillow ]);
    in stdenv.mkDerivation rec {
      pname = "scribus";
      version = "1.4.8";

      src = fetchurl {
        url = "mirror://sourceforge/${pname}/${pname}/${pname}-${version}.tar.xz";
        sha256 = "0bq433myw6h1siqlsakxv6ghb002rp3mfz5k12bg68s0k6skn992";
      };

      nativeBuildInputs = [ pkg-config cmake ];
      buildInputs = with xorg; [
        boost
        cairo
        cups
        fontconfig
        freetype
        gnome2.libart_lgpl
        hunspell
        imagemagick
        lcms
        libX11
        libXau
        libXaw
        libXdmcp
        libXext
        libXi
        libXinerama
        libXtst
        libjpeg
        libpng
        libpthreadstubs
        libtiff
        libxml2
        podofo
        pythonEnv
        qt4
        zlib
      ];

      postPatch = ''
        substituteInPlace scribus/util_ghostscript.cpp \
          --replace 'QString gsName("gs");' \
                    'QString gsName("${ghostscript}/bin/gs");'
      '';

      postInstall = ''
        for i in 16 24 48 64 96 128 256 512; do
          mkdir -p $out/share/icons/hicolor/''${i}x''${i}/apps
          convert -background none -resize ''${i}x''${i} ${icon} $out/share/icons/hicolor/''${i}x''${i}/apps/scribus.png
        done
      '';

      meta = {
        platforms = lib.platforms.linux;
        description = "Desktop Publishing (DTP) and Layout program for Linux";
        homepage = "https://www.scribus.net";
        license = lib.licenses.gpl2;
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
  shellHook = "exec ${shell}/bin/${shell.name}";
}
