{ lib, python3 }:

python3.pkgs.buildPythonPackage rec {
  pname = "ini2toml";
  version = "0.15";

  src = python3.pkgs.fetchPypi {
    inherit pname version;
    sha256 = "sha256-1hkTmxuakqkqVs0vJKT7Mb8QobdcKWjY/o8O069dZM4=";
  };

  doCheck = false;

  propagatedBuildInputs = [ python3.pkgs.packaging python3.pkgs.setuptools python3.pkgs.tomli-w ];

  meta = with lib; {
    homepage = url;
    license = licenses.mpl20;
    platforms = platforms.linux;
    description = "Automatically conversion of `.ini/.cfg` files to TOML equivalents";
  };
}
