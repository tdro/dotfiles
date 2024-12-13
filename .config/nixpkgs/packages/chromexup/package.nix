{ lib, fetchgit, python3 }:

python3.pkgs.buildPythonApplication rec {

  pname = "chromexup";
  version = "5a4e8ac0eec36b5865a40dfdeba0943e8623f412";

  src = fetchgit {
    rev = version;
    url = "https://github.com/xsmile/chromexup.git";
    sha256 = "sha256-HdSFZh1BRfcRURZpCt7AK0ABqd2YT00p15ssWwlue7o=";
  };

  propagatedBuildInputs = [ python3.pkgs.requests ];

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
