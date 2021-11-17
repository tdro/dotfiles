{ lib, pkgs, python39 }:

let

  meta = with lib; {
    license = licenses.mit;
    description = "Command line utility to manipulate YAML files";
    homepage = "https://sourceforge.net/p/ruamel-yaml-cmd/code/ci/default/tree";
  };

  ruamel.std.argparse = python39.pkgs.buildPythonPackage rec {
    pname = "ruamel.std.argparse";
    version = "0.8.3";
    src = python39.pkgs.fetchPypi {
      inherit pname version;
      sha256 = "0srv4g6jryyaz26csx315pbmfhm4rw8jhfsl7rq7krrglgqwjryi";
    };
    doCheck = false;
    inherit meta;
  };

  ruamel.std.convert = python39.pkgs.buildPythonPackage rec {
    pname = "ruamel.yaml.convert";
    version = "0.3.2";
    src = python39.pkgs.fetchPypi {
      inherit pname version;
      sha256 = "1i6919b5f5ygj7y7c4x0wi91n8y0mw4nf9f0bcfjk29i594xjph6";
    };
    propagatedBuildInputs = [ python39.pkgs.python-dateutil python39.pkgs.ruamel_yaml ];
    doCheck = false;
    inherit meta;
  };

  ruamel.yaml.cmd = python39.pkgs.buildPythonPackage rec {
    pname = "ruamel.yaml.cmd";
    version = "0.5.6";
    src = python39.pkgs.fetchPypi {
      inherit pname version;
      sha256 = "0zc2h6b721r8c05dm7y8zgrgbvifbgcm8jmqvns7ar4ajll3cvwv";
    };
    propagatedBuildInputs = [ python39.pkgs.configobj ruamel.std.argparse ruamel.std.convert ];
    patches = [
      (pkgs.writeTextFile {
        name = "disable-backup-files.patch";
        text = ''
          --- a/yaml_cmd.py	2020-12-14 22:13:19.000000000 -0500
          +++ b/yaml_cmd.py	2020-12-14 22:13:34.067115865 -0500
          @@ -513,8 +513,6 @@
               def round_trip_save(self, file_name):
                   inp = open(file_name).read()
                   backup_file_name = file_name + '.orig'
          -        if not os.path.exists(backup_file_name):
          -            os.rename(file_name, backup_file_name)
                   return self.round_trip_single(inp, out_file=file_name)

               def round_trip_input(self, inp):
        '';
      })
    ];
    doCheck = false;
    dontWrapPythonPrograms = true;
    inherit meta;
  };

in python39.pkgs.buildPythonApplication rec {

  pname = ruamel.yaml.cmd.pname;
  version = ruamel.yaml.cmd.version;
  propagatedBuildInputs = [ ruamel.yaml.cmd ];
  pythonEnvironment = python39.withPackages (_: propagatedBuildInputs);

  installPhase = ''
    runHook preInstall
    mkdir -p $out/bin
    cp ${ruamel.yaml.cmd}/bin/yaml $out/bin
    sed -i 's|^#!.*$|#!${pythonEnvironment}/bin/python3.9|' $out/bin/yaml
    runHook postInstall
  '';

  dontUnpack = true;
  dontBuild = true;
  doCheck = false;
  inherit meta;
}
