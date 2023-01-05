{ lib, fetchgit, python38 }:

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
  format = "other";

  propagatedBuildInputs = [
    python38.pkgs.pyusb
    python38.pkgs.pyserial
    python38.pkgs.docopt
    python38.pkgs.pycryptodome
    python38.pkgs.qrcode
  ];

  pythonEnv = python38.withPackages (ps: with ps; propagatedBuildInputs);

  installPhase = ''
    runHook preInstall
    mkdir --parents $out/share/edl
    cp --recursive --no-target-directory ${src} $out/share/edl
    makeWrapper ${pythonEnv}/bin/python $out/bin/edl --add-flags $out/share/edl/edl.py
    makeWrapper ${pythonEnv}/bin/python $out/bin/edl-diag --add-flags $out/share/edl/diag.py
    makeWrapper ${pythonEnv}/bin/python $out/bin/edl-tcpclient --add-flags $out/share/edl/tcpclient.py
    makeWrapper ${pythonEnv}/bin/python $out/bin/edl-fhloaderparse --add-flags $out/share/edl/fhloaderparse.py
    runHook postInstall
  '';

  meta = with lib; {
    homepage = url;
    license = licenses.mit;
    platforms = platforms.linux;
    description = "QC Firehose / Sahara Client / QC Diag Tools :)";
  };
}
