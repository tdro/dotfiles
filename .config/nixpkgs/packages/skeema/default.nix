{ lib, fetchgit, buildGoModule }:

buildGoModule rec {
  pname = "skeema";
  version = "v1.5.0";
  url = "https://github.com/skeema/skeema";

  src = fetchgit {
    inherit url;
    rev = version;
    sha256 = "0mrspmgiww0jlpml24r5f4ail8153f2liva88w9760fd5aky3ix3";
  };

  vendorSha256 = null;

  doCheck = false;

  meta = with lib; {
    homepage = url;
    license = licenses.asl20;
    description = "Schema management CLI for MySQL";
  };
}
