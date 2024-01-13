{ lib, stdenv, fetchurl, fetchpatch, pkg-config, libticalcs2, libticables2
, libtifiles2, libticonv, gnome2, gtk2, SDL, glib }:

stdenv.mkDerivation rec {
  name = "tiemu";
  version = "3.03";
  src = fetchurl {
    url = "http://download.sourceforge.net/project/gtktiemu/tiemu-linux/TIEmu%20${version}/tiemu-${version}-nogdb.tar.gz";
    sha256 = "14m5p1ani7pz23z77h2hibl38sz0i5dpywdhkbr8v2i788487llj";
  };

  hardeningDisable = [ "format" ];
  preConfigure = ''configureFlags="--without-kde --disable-gdb"'';

  buildInputs = [
    pkg-config
    libticables2
    libticalcs2
    libtifiles2
    glib
    libticonv
    gtk2
    gnome2.libglade
    SDL
  ];

  patches = [
    (fetchpatch {
      name = "01-build-fix.patch";
      sha256 = "0p4qns6w1hfs3ci6pqpidd2ikjgvpvyd7bnsfj9cx06chwc9sysl";
      url = "https://aur.archlinux.org/cgit/aur.git/plain/01-build-fix.patch?h=tiemu";
    })
    (fetchpatch {
      name = "sysdeps.patch";
      sha256 = "1j6gns3vhykizxyb09670a65lafa1xd8wjyl45kvmysv250089z5";
      url = "https://aur.archlinux.org/cgit/aur.git/plain/sysdeps.patch?h=tiemu";
    })
  ];

  meta = with lib; {
    license = licenses.gpl2;
    platforms = platforms.linux;
    homepage = "http://lpg.ticalc.org/prj_tiemu/";
  };
}
