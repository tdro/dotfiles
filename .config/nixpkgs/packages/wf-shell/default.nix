{ stdenv, lib, fetchgit, meson, ninja, pkg-config, wayland, alsa-lib, gtkmm3
, gtk-layer-shell, pulseaudio, wayfire, wf-config }:

stdenv.mkDerivation rec {
  pname = "wf-shell";
  version = "deffdbae2df1f4f3280e5416965b977062059b41";

  src = fetchgit {
    url = "https://github.com/WayfireWM/wf-shell";
    sha256 = "sha256-eCga6ZdxqJYKc9yAI77fZUXOSaee8ijCE0XiJRJtDAg=";
  };

  nativeBuildInputs = [ meson ninja pkg-config wayland ];

  buildInputs = [
    alsa-lib
    gtkmm3
    gtk-layer-shell
    pulseaudio
    wayfire
    wf-config
  ];

  mesonFlags = [ "--sysconfdir" "/etc" ];

  meta = with lib; {
    homepage = "https://github.com/WayfireWM/wf-shell";
    description = "GTK3-based panel for Wayfire";
    license = licenses.mit;
    platforms = platforms.unix;
  };
}
