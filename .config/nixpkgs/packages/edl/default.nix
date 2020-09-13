{ stdenv, fetchgit, python38 }:

python38.pkgs.buildPythonApplication rec {

  pname = "edl";
  url = "https://github.com/bkerler/edl.git";
  version = "6ca9feb8ac7b260a0395d4f51e9e91fc0feda058";

  src = fetchgit {
    inherit url;
    rev = version;
    sha256 = "1lpgamg6wkwpj3mxcn8nrxxw90svx5xy3kahk8rdf09ph6wlii4x";
  };

  doCheck = false;
  dontBuild = true;

  propagatedBuildInputs = with python38.pkgs; [
    pyusb
    pyserial
    docopt
    pycryptodome
    qrcode
  ];

  pythonEnv = python38.withPackages (ps: with ps; propagatedBuildInputs);

  installPhase = ''
    mkdir -p $out/share/edl
    cp -rT ${src} $out/share/edl
    makeWrapper ${pythonEnv}/bin/python $out/bin/edl --add-flags $out/share/edl/edl.py
    makeWrapper ${pythonEnv}/bin/python $out/bin/edl-diag --add-flags $out/share/edl/diag.py
    makeWrapper ${pythonEnv}/bin/python $out/bin/edl-tcpclient --add-flags $out/share/edl/tcpclient.py
    makeWrapper ${pythonEnv}/bin/python $out/bin/edl-fhloaderparse --add-flags $out/share/edl/fhloaderparse.py
  '';

  meta = with stdenv.lib; {
    homepage = url;
    license = licenses.mit;
    platforms = platforms.linux;
    description = "QC Firehose / Sahara Client / QC Diag Tools :)";
  };
}
