{ lib, fetchurl, appimageTools }:

appimageTools.wrapType2 rec {
  name = "pdf2htmlex";
  version = "0.18.8.rc1";

  src = fetchurl {
    url = "https://github.com/pdf2htmlEX/pdf2htmlEX/releases/download/v${version}/pdf2htmlEX-${version}-master-20200630-Ubuntu-focal-x86_64.AppImage";
    sha256 = "sha256-Ed4lg6Orzl8UH9f6+x/qLGexWIblRta3Z1xgABLmq4w=";
  };

  meta = with lib; {
    license = licenses.gpl3;
    platforms = platforms.linux;
    description = "Convert PDF to HTML without losing text or format. ";
  };
}
