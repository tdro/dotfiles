{ lib, stdenv, fetchgit, cmake, extra-cmake-modules, qt5, libsForQt5 }:

stdenv.mkDerivation rec {
  name = "qprompt";
  version = "v1.1.2";

  src = fetchgit {
    rev = version;
    url = "https://github.com/Cuperino/QPrompt.git";
    sha256 = "sha256-EeLJC77X9lcjvbr+TkIpMHO0YFdI91tiVUplde3wEzA=";
  };

  buildInputs = [
    cmake
    extra-cmake-modules
    qt5.wrapQtAppsHook
    qt5.qtquickcontrols2.dev
    qt5.qtx11extras.dev
    libsForQt5.ki18n.dev
    libsForQt5.kcoreaddons.dev
    libsForQt5.kiconthemes.dev
    libsForQt5.kirigami2.dev
  ];

  meta = {
    license = with lib.licenses; [ gpl3 cc-by-sa-40 ];
    homepage = "https://github.com/Cuperino/QPrompt#qprompt";
    description = "Personal teleprompter software for all video creators.";
  };
}
