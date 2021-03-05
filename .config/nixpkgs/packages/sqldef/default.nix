{ stdenv, fetchgit, buildGoModule }:

buildGoModule rec {
  pname = "sqldef";
  version = "v0.8.9";
  url = "https://github.com/k0kubun/sqldef";

  src = fetchgit {
    inherit url;
    rev = version;
    sha256 = "1hvx05qwy2g4r1zc1k2f9xv4z815p5jh1a6g41fdlxskjl3kyyf5";
  };

  vendorSha256 = "066184zmwdhd8dbkbmwds8aimiawfcvb8px8z1q48c949gvywlx7";

  doCheck = false;

  meta = with stdenv.lib; {
    homepage = url;
    license = licenses.mit;
    description = "Idempotent MySQL/PostgreSQL schema management by SQL";
  };
}
