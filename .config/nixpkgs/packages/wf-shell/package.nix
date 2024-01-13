{ stdenv, lib, fetchgit, meson, ninja, pkg-config, wayland, alsa-lib, gtkmm3
, gtk-layer-shell, pulseaudio, wayfire, wf-config, libdbusmenu-gtk3 }:

stdenv.mkDerivation rec {
  pname = "wf-shell";
  version = "9a9af00dc02780357466e27c5e77e316469e7a37";

  src = fetchgit {
    url = "https://github.com/WayfireWM/wf-shell";
    sha256 = "sha256-DoGW9rCEQFDO/SJ/ZWv2SPzC/acLFnPPncs683ugEvY=";
  };

  mesonFlags = [ "--sysconfdir" "/etc" ];
  nativeBuildInputs = [ meson ninja pkg-config wayland ];

  buildInputs = [
    alsa-lib
    gtk-layer-shell
    gtkmm3
    libdbusmenu-gtk3
    pulseaudio
    wayfire
    wf-config
  ];

  meta = with lib; {
    homepage = "https://github.com/WayfireWM/wf-shell";
    description = "GTK3-based panel for Wayfire";
    license = licenses.mit;
    platforms = platforms.unix;
  };
}
