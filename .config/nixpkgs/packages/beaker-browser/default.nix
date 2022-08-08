{ lib, fetchurl, appimageTools }:

appimageTools.wrapType2 rec {
  name = "beaker-browser";
  version = "1.1.0";

  src = fetchurl {
    url = "https://github.com/beakerbrowser/beaker/releases/download/${version}/Beaker.Browser-${version}.AppImage";
    sha256 = "07hcyr6vyim8vrvw120v5jjfvy5jkcaqc3wgqgyf6prbqdx71dkp";
  };

  meta = with lib; {
    license = licenses.mit;
    homepage = "https://beakerbrowser.com";
    description = "An experimental peer-to-peer Web browser";
  };
}
