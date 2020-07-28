{ stdenv, fetchurl, unzip }:

stdenv.mkDerivation rec {

  pname = "nerdfonts-dejavu-sans-mono";
  version = "2.1.0";

  buildInputs = [ unzip ];

  src = fetchurl {
    url = "https://github.com/ryanoasis/nerd-fonts/releases/download/v${version}/DejaVuSansMono.zip";
    sha256 = "03qfrkzmhnn8dwgx4qhiigbz4dxs3957hydlr0j8vxl89j8c9g1z";
  };

  phases = [ "unpackPhase" "installPhase" ];

  unpackPhase = '' unzip ${src} '';

  installPhase = ''
    mkdir -p $out/share/fonts/nerdfonts-dejavu-sans-mono
    cp -r * $out/share/fonts/nerdfonts-dejavu-sans-mono
  '';

  meta = with stdenv.lib; {
    description = ''
      Nerd Fonts is a project that attempts to patch as many developer targeted
      and/or used fonts as possible. The patch is to specifically add a high
      number of additional glyphs from popular 'iconic fonts' such as Font
      Awesome, Devicons, Octicons, and others.
    '';
    homepage = "https://github.com/ryanoasis/nerd-fonts";
    license = licenses.mit;
    platforms = platforms.all;
  };
}
