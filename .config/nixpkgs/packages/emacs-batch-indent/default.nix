{ lib, stdenv, fetchgit }:

stdenv.mkDerivation rec {

  name = "emacs-batch-indent";
  version = "145e8771b9709a82e3df82cdc06c6d9505de905d";
  url = "https://github.com/cwfoo/emacs-batch-indent";

  src = fetchgit {
    inherit url;
    rev = version;
    sha256 = "sha256-Qqg/ZLbfTZnH2aO7ZW2XiiVBqEvK2+LMo2Kz6HSnOCE=";
  };

  phases = [ "unpackPhase" "installPhase" ];

  installPhase = ''
    runHook preInstall
    mkdir --parents $out/bin
    cp emacs-batch-indent $out/bin
    runHook postInstall
  '';

  meta = with lib; {
    homepage = url;
    license = licenses.gpl3;
    platforms = platforms.linux;
    description = "Indent Common Lisp, Emacs Lisp, and Scheme from the command line using Emacs.";
  };
}
