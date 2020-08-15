{ stdenv, fetchgit }:

stdenv.mkDerivation rec {

  pname = "vale-styles";
  version = "master";

  write-good = fetchgit {
    url = "https://github.com/errata-ai/write-good";
    rev = "2d116619b7662d9d59201e8808254e715fc83cc8";
    sha256 = "0nzs6wp7xsbcm481rwrijvpm5ks9z4hwcc2ydz16dfjxh1bywjq3";
  };

  microsoft = fetchgit {
    url = "https://github.com/errata-ai/Microsoft";
    rev = "f0628659ecbc4bbbe0a7f89a01d5045d8f1b563f";
    sha256 = "1nqv67pr6a5nfksl8ppc2ybips3ksnpgk18bsf0038vm72y7sbvp";
  };

  google = fetchgit {
    url = "https://github.com/errata-ai/Google";
    rev = "17d372e40df8a797f4745da1efe8a73640483718";
    sha256 = "090773ppb1ngl5xpl2nvrrsgjmlk8zcs2cfj4m77my28v5yfh1gn";
  };

  phases = [ "installPhase" ];

  installPhase = ''
    mkdir -p $out/share/vale-styles
    cp -r ${google}/Google $out/share/vale-styles/google
    cp -r ${microsoft}/Microsoft $out/share/vale-styles/microsoft
    cp -r ${write-good}/write-good $out/share/vale-styles/write-good
  '';

  meta = with stdenv.lib; {
    description =
      "Styles for a syntax-aware linter for prose built with speed and extensibility in mind.";
  };
}
