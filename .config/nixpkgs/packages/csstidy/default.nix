{ lib, stdenv, fetchgit, sconsPackages, gcc }:

stdenv.mkDerivation rec {

  pname = "csstidy";
  version = "8a5e5d4885bb5eda1d6035a7e5c9cfb163714048";

  src = fetchgit {
    rev = version;
    url = "https://github.com/dmitryleskov/csstidy-cpp.git";
    sha256 = "1bf4b7cywrdb5kbnh98f5r2l2wxy5ny9snfw7czr44mykzwdjayr";
  };

  buildInputs = [ sconsPackages.scons_3_0_1 ];

  preBuild = ''
    sed --in-place "/env = Environment()/a env.Replace(CXX='${gcc}/bin/g++')" SConstruct
  '';

  installPhase = ''
    runHook preInstall
    mkdir --parents $out/bin
    cp release/csstidy/csstidy $out/bin
    runHook postInstall
  '';

  meta = with lib; {
    license = licenses.lgpl21;
    inherit (src.meta) homepage;
    platforms = platforms.linux;
    description = "Fork of CSSTidy: A program that optimises, formats and fixes CSS code";
  };
}
