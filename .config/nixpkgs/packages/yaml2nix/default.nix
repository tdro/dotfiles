{ lib, rustPlatform, fetchgit }:

rustPlatform.buildRustPackage rec {
  pname = "yaml2nix";
  version = "b220acf4299376ee1b4131ca4c4248ebf0337d79";

  src = fetchgit {
    rev = version;
    url = "https://github.com/euank/yaml2nix.git";
    sha256 = "1i7s18chpqckq16ljy9sh81zvambqkh4hvcyap6xi4yzp2h82198";
  };

  cargoSha256 = "0bnkznzmyi7iyv4rlkfj8ikkx1ajfhvwd3rrmhrlbx6hbv554fkh";

  meta = with lib; {
    homepage = url;
    license = licenses.gpl3;
    description = "A command line tool to convert yaml into a nix expression.";
  };
}
