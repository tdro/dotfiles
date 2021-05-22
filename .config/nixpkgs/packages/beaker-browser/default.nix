{ lib, fetchurl, appimageTools }:

let version = "1.1.0"; in

appimageTools.wrapType2  {
  name = "beaker-browser";

  src = fetchurl {
    url = "https://github.com/beakerbrowser/beaker/releases/download/${version}/Beaker.Browser-${version}.AppImage";
    sha256 = "07hcyr6vyim8vrvw120v5jjfvy5jkcaqc3wgqgyf6prbqdx71dkp";
  };

  meta = with lib; {
    homepage = "https://beakerbrowser.com";
    license = licenses.mit;
    description = "An experimental peer-to-peer Web browser";
  };
}
