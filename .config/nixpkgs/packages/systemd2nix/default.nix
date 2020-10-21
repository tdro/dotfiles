{ stdenv, fetchgit, python38 }:

python38.pkgs.buildPythonApplication rec {

  pname = "systemd2nix";
  url = "https://github.com/DavHau/systemd2nix";
  version = "bc9787b79187ae6ef7cd0da33a771693c99e04e1";

  src = fetchgit {
    inherit url;
    rev = version;
    sha256 = "03hc7v8cl8vzj1gpnxjwjkkbkh3c8g68ifvci2a5ggs0w83vrbrf";
  };

  doCheck = false;
  dontBuild = true;

  installPhase = ''
    mkdir -p $out/bin $out/share/${pname}
    cp ${src}/${pname}.py $out/share/${pname}
    makeWrapper ${python38}/bin/python $out/bin/${pname} --add-flags $out/share/${pname}/${pname}.py
  '';

  meta = with stdenv.lib; {
    homepage = url;
    license = licenses.mit;
    platforms = platforms.linux;
    description = "Convert systemd service files to Nix syntax";
  };
}
