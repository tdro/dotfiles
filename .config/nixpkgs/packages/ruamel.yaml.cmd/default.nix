{ stdenv, python38 }:

with python38.pkgs;

let

  meta = with stdenv.lib; {
    license = licenses.mit;
    description = "Command line utility to manipulate YAML files";
    homepage = "https://sourceforge.net/p/ruamel-yaml-cmd/code/ci/default/tree";
  };

  ruamel.std.argparse = buildPythonPackage rec {
    pname = "ruamel.std.argparse";
    version = "0.8.3";
    src = fetchPypi {
      inherit pname version;
      sha256 = "0srv4g6jryyaz26csx315pbmfhm4rw8jhfsl7rq7krrglgqwjryi";
    };
    doCheck = false;
    inherit meta;
  };

  ruamel.std.convert = buildPythonPackage rec {
    pname = "ruamel.yaml.convert";
    version = "0.3.2";
    src = fetchPypi {
      inherit pname version;
      sha256 = "1i6919b5f5ygj7y7c4x0wi91n8y0mw4nf9f0bcfjk29i594xjph6";
    };
    propagatedBuildInputs = [ python-dateutil ruamel_yaml ];
    doCheck = false;
    inherit meta;
  };

  ruamel.yaml.cmd = buildPythonPackage rec {
    pname = "ruamel.yaml.cmd";
    version = "0.5.6";
    src = fetchPypi {
      inherit pname version;
      sha256 = "0zc2h6b721r8c05dm7y8zgrgbvifbgcm8jmqvns7ar4ajll3cvwv";
    };
    propagatedBuildInputs = [ configobj ruamel.std.argparse ruamel.std.convert ];
    patches = [ ./disable-backup-files.patch ];
    doCheck = false;
    dontWrapPythonPrograms = true;
    inherit meta;
  };

in buildPythonApplication rec {

  pname = ruamel.yaml.cmd.pname;
  version = ruamel.yaml.cmd.version;
  propagatedBuildInputs = [ ruamel.yaml.cmd ];
  pythonEnvironment = python38.withPackages (_: propagatedBuildInputs);

  installPhase = ''
    runHook preInstall
    mkdir -p $out/bin
    cp ${ruamel.yaml.cmd}/bin/yaml $out/bin
    sed -i 's|^#!.*$|#!${pythonEnvironment}/bin/python3.8|' $out/bin/yaml
    runHook postInstall
  '';

  dontUnpack = true;
  dontBuild = true;
  doCheck = false;
  inherit meta;
}
