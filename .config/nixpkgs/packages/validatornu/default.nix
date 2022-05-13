{ lib, stdenv, fetchzip, jdk, makeWrapper, ... }:

stdenv.mkDerivation rec {
  pname = "validatornu";
  version = "20.6.30";

  src = fetchzip {
    url = "https://github.com/validator/validator/releases/download/${version}/vnu.jar_${version}.zip";
    sha256 = "1jls0zpkczsqyzibgjxz11cjy8i62sdfi9cmmn3r7qcl1b4iw1p0";
  };

  nativeBuildInputs = [ makeWrapper ];

  installPhase = ''
    runHook preInstall
    mkdir --parents $out/bin $out/share/{java,licenses,doc}/$pname
    cp vnu.jar $out/share/java/$pname/vnu.jar
    cp LICENSE $out/share/licenses/$pname/LICENSE
    cp README.md $out/share/doc/$pname/README.md
    cp index.html $out/share/doc/$pname/index.html
    makeWrapper ${jdk}/bin/java $out/bin/${pname} \
      --add-flags "-jar $out/share/java/validatornu/vnu.jar"
    runHook postInstall
  '';

  meta = with lib; {
    license = licenses.mit;
    platforms = platforms.linux;
    homepage = "https://github.com/validator/validator#the-nu-html-checker-vnu--";
    description = "Nu Html Checker – Helps you catch problems in your HTML/CSS/SVG";
  };
}
