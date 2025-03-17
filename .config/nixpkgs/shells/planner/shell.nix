let

  name = "nix-shell.planner";

  pkgs = (import (builtins.fetchTarball {
    url = "https://releases.nixos.org/nixos/21.11/nixos-21.11.336020.2128d0aa28e/nixexprs.tar.xz";
    sha256 = "0w8plbxms0di6gnh0k2yhj0pgxzxas7g5x0m01zjzixf16i2bapj";
  }) { });

  package = pkgs.callPackage ({ lib, stdenvNoCC, fetchgit, pkgconfig, intltool
    , automake111x, autoconf, libtool, gnome2, libxslt, python2, gcc48 }:
    stdenvNoCC.mkDerivation rec {
      pname = "planner";
      version = "de43d655f9f8103993129cde9de3d0e080d0546c";
      src = fetchgit {
        url = "https://gitlab.gnome.org/World/planner.git";
        sha256 = "1zpcswdpcjhllk7phy3z1zyxcgqr4pp0vf5fgpg5f3gqpk4xvwyg";
        rev = version;
      };
      nativeBuildInputs = [
        autoconf
        automake111x
        gnome2.gnome-common
        gnome2.gtk-doc
        gnome2.scrollkeeper
        intltool
        libtool
        pkgconfig
      ];
      buildInputs = [
        gcc48
        gnome2.GConf
        gnome2.gtk
        gnome2.libglade
        gnome2.libgnomecanvas
        gnome2.libgnomeui
        libxslt
        python2.pkgs.pygtk
      ];
      enableParallelBuilding = true;
      preConfigure = "./autogen.sh";
      makeFlags = [ "CFLAGS=-DGLIB_DISABLE_DEPRECATION_WARNINGS" ];
      configureFlags = [ "--enable-python" "--enable-python-plugin" ];
      meta = with lib; {
        description = "Project management application for GNOME";
        homepage = "https://wiki.gnome.org/Apps/Planner";
        license = licenses.gpl2Plus;
        platforms = platforms.all;
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
