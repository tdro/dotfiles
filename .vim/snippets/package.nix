{ lib, stdenv, fetchgit }:

stdenv.mkDerivation rec {
  pname = "";
  version = "";

  src = fetchgit {
    rev = version;
    url = "";
    sha256 = "";
  };

  dontBuild = true;

  installPhase = ''
    runHook preInstall
    mkdir "$out"
    runHook postInstall
  '';

  meta = {
    homepage = "";
    description = "";
    license = lib.licenses.mit;
    platforms = lib.platforms.linux;
  };
}
