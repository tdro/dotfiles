{ lib, fetchgit, python38 }:

with python38.pkgs;

buildPythonApplication rec {

  pname = "chromexup";
  version = "8eae4e04a3d6fa4838bb8e782b84cdb2edc8540f";

  src = fetchgit {
    rev = version;
    url = "https://github.com/xsmile/chromexup.git";
    sha256 = "0kiqh5zc2rs73amrmj0hrpxccd2qpd3f9zwj7q9i6k7ii5mzw357";
  };

  propagatedBuildInputs = [ requests ];

  postInstall = ''
    cp config.ini.example $out
    cp -rT scripts/systemd $out
  '';

  meta = with lib; {
    license = licenses.mit;
    inherit (src.meta) homepage;
    platforms = platforms.linux;
    description = "External extension updater for Chromium based browsers";
  };
}
