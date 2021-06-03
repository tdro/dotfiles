{ lib, stdenvNoCC, fetchgit, pkgconfig, intltool, automake111x, autoconf
, libtool, gnome2, libxslt, python2, gcc48 }:

stdenvNoCC.mkDerivation rec {

  pname = "planner";
  version = "de43d655f9f8103993129cde9de3d0e080d0546c";

  src = fetchgit {
    url = "https://gitlab.gnome.org/World/planner.git";
    sha256 = "1zpcswdpcjhllk7phy3z1zyxcgqr4pp0vf5fgpg5f3gqpk4xvwyg";
    rev = version;
  };

  nativeBuildInputs = with gnome2; [
    autoconf
    automake111x
    gnome-common
    gtk-doc
    intltool
    libtool
    pkgconfig
    scrollkeeper
  ];

  buildInputs = with gnome2; [
    GConf
    gcc48
    gtk
    libglade
    libgnomecanvas
    libgnomeui
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
}
