{ stdenv, lib, fetchgit, autoreconfHook, pkg-config, libxkbcommon, pango
, which, git, cairo, libxcb, xcbutil, xcbutilwm, xcbutilxrm, xcb-util-cursor
, libstartup_notification, bison, flex, librsvg, check }:

stdenv.mkDerivation rec {
  pname = "rofi-unwrapped";
  version = "1.7.0";

  src = fetchgit {
    rev = version;
    fetchSubmodules = true;
    url = "https://github.com/davatorium/rofi.git";
    sha256 = "03wdy56b3g8p2czb0qydrddyyhj3x037pirnhyqr5qbfczb9a63v";
  };

  preConfigure = ''
    patchShebangs "script"
    # root not present in build /etc/passwd
    sed -i 's/~root/~nobody/g' test/helper-expand.c
  '';

  nativeBuildInputs = [ autoreconfHook pkg-config ];
  buildInputs = [
    libxkbcommon
    pango
    cairo
    git
    bison
    flex
    librsvg
    check
    libstartup_notification
    libxcb
    xcbutil
    xcbutilwm
    xcbutilxrm
    xcb-util-cursor
    which
  ];

  doCheck = false;

  meta = with lib; {
    license = licenses.mit;
    platforms = with platforms; linux;
    homepage = "https://github.com/davatorium/rofi";
    description = "Window switcher, run dialog and dmenu replacement";
  };
}
