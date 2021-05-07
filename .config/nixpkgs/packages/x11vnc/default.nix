{ lib, stdenv, fetchgit, openssl, zlib, libjpeg, xorg
, libvncserver, autoreconfHook, pkg-config }:

stdenv.mkDerivation rec {
  pname = "x11vnc";
  version = "f07df92816ef10b7382a542125955df7f4156a5c";

  src = fetchgit {
    url = "https://github.com/LibVNC/x11vnc";
    rev = version;
    sha256 = "1vgkgcqz6fxjgdzqpnw05lg30hdczrfgyzj39z1ips9vcjpb6v8s";
  };

  nativeBuildInputs = [ autoreconfHook pkg-config ];

  buildInputs = [
    xorg.libXfixes
    xorg.xorgproto
    openssl
    xorg.libXdamage
    zlib
    xorg.libX11
    libjpeg
    xorg.libXtst
    xorg.libXinerama
    xorg.libXrandr
    xorg.libXext
    xorg.libXi
    xorg.libXrender
    libvncserver
  ];

  preConfigure = ''
    configureFlags="--mandir=$out/share/man"
  '';

  meta = with lib; {
    description = "A VNC server connected to a real X11 screen";
    homepage = "https://github.com/LibVNC/x11vnc/";
    platforms = platforms.linux;
    license = licenses.gpl2;
    maintainers = with maintainers; [ OPNA2608 ];
  };
}
