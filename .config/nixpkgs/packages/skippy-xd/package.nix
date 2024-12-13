# https://raw.githubusercontent.com/NixOS/nixpkgs/097f9e6c1e24fb101f310f260624fa951a06ce62/pkgs/tools/X11/skippy-xd/default.nix
# https://github.com/NixOS/nixpkgs/blob/master/COPYING
# Licence: MIT | https://mit-license.org/

{ lib, stdenv, fetchgit, xorgproto, libX11, libXft, libXcomposite, libXdamage, libXext, libXinerama, libjpeg, giflib, pkg-config }:

stdenv.mkDerivation rec {

  pname = "skippy-xd";
  version = "0.6.0";

  src = fetchgit {
    url = "https://github.com/dreamcat4/skippy-xd.git";
    rev = "d0557c3144fc67568a49d7207efef89c1d5777a0";
    hash = "sha256-dnoPUPCvuR/HhqIz1WAsmWL/CkfTf11YEkbrkVWM4dc=";
  };

  nativeBuildInputs = [ pkg-config ];

  buildInputs = [
    giflib
    libX11
    libXcomposite
    libXdamage
    libXext
    libXft
    libXinerama
    libjpeg
    xorgproto
  ];

  makeFlags = [ "PREFIX=$(out)" ];

  preInstall = ''
    sed -e "s@/etc/xdg@$out&@" -i Makefile
  '';

  meta = with lib; {
    license = licenses.gpl2Plus;
    platforms = platforms.linux;
    description = "Expose-style compositing-based standalone window switcher";
  };
}
