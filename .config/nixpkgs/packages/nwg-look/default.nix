{ lib, buildGoModule, fetchgit, pkg-config, go, gtk3, xcur2png, glib, cairo }:

buildGoModule rec {
  pname = "nwg-look";
  version = "0.1.4";

  src = fetchgit {
    url = "https://github.com/nwg-piotr/nwg-look";
    rev = "v${version}";
    sha256 = "sha256-ib+5dTCbZwmlD9DBw93nh9dlb/OBu2poE0CeM0ZCKXQ=";
  };

  nativeBuildInputs = [ pkg-config go ];
  buildInputs = [ gtk3 xcur2png glib cairo ];
  vendorSha256 = "sha256-XEgPeJ8zlaadl+yuAOlbzsBECs/c8cjBja+sZkTsg60=";

  postPatch = ''
    substituteInPlace ./main.go --replace \
    /usr/share/${pname}/main.glade $out/share/${pname}/main.glade
  '';

  postInstall = ''
    install -D --mode=444 ./stuff/main.glade $out/share/${pname}/main.glade
    install -D --mode=444 ./stuff/${pname}.desktop $out/share/applications/${pname}.desktop
    install -D --mode=444 ./stuff/${pname}.svg $out/share/pixmaps/${pname}.svg
  '';

  meta = with lib; {
    description = "GTK3 settings editor adapted to work in the sway / wlroots environment";
    homepage = "https://github.com/nwg-piotr/nwg-look";
    license = licenses.mit;
  };
}
