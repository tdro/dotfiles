{ stdenv, fetchurl, makeWrapper, lib, php }:

stdenv.mkDerivation rec {

  pname = "phar-composer";
  version = "1.4.0";

  src = fetchurl {
    url = "https://github.com/clue/${pname}/releases/download/v${version}/${pname}-${version}.phar";
    sha256 = "sha256-GUKo/l8b0UkQpGHsyagjgtAkZbfmjdhWOXkZT5vLB8A=";
  };

  dontUnpack = true;
  nativeBuildInputs = [ makeWrapper ];

  installPhase = ''
    runHook preInstall
    mkdir --parents $out/bin
    install -D $src $out/libexec/${pname}/${pname}.phar
    makeWrapper ${php}/bin/php $out/bin/${pname} --add-flags "$out/libexec/${pname}/${pname}.phar"
    runHook postInstall
  '';

  meta = {
    license = lib.licenses.mit;
    homepage = "https://github.com/clue/phar-composer#readme";
    description = "Simple phar creation for every PHP project managed via Composer.";
  };
}
