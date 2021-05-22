{ lib, fetchgit, python36 }:

with python36.pkgs;

let

  bench-it = buildPythonPackage rec {
    pname = "bench-it";
    version = "1.0.1";
    src = fetchPypi {
      inherit pname version;
      sha256 = "0v6kfvgdnjlfmwlafmyjadgllfr8qc1hq83kz9q287gh5nvw851f";
    };
    postPatch = ''
      # Avoid building pypandoc
      sed -i 's|^import pypandoc.*||' setup.py
      sed -i 's|^description = pypandoc.*|description = ""|' setup.py
    '';
    doCheck = false;
  };

in buildPythonApplication rec {

  pname = "sqlfluff";
  url = "https://github.com/sqlfluff/sqlfluff";
  version = "0.4.1";

  src = fetchgit {
    inherit url;
    rev = version;
    sha256 = "0g53rhdg8b2p3xx9rmkc2fkqnz4fsrmkg98n5fi10s16wscn90kz";
  };

  propagatedBuildInputs = [
    appdirs
    bench-it
    cached-property
    click
    colorama
    configparser
    dataclasses
    diff_cover
    jinja2
    oyaml
    pathspec
    pluggy
    typing-extensions
  ];

  doCheck = false;

  meta = with lib; {
    homepage = url;
    license = licenses.mit;
    platforms = platforms.linux;
    description = "A SQL linter and auto-formatter for Humans";
  };
}
