{ lib, stdenv, fetchgit, SDL2, pkg-config }:

stdenv.mkDerivation rec {
  pname = "sowon";
  version = "85dbbd06e7f20fe0a727fcb34e5206c23894ff83";
  url = "https://github.com/tsoding/sowon.git";

  src = fetchgit {
    inherit url;
    rev = version;
    sha256 = "06gc1qsn5j902861qfbrixpjdmxyngrhvp312zz82k9gqjsacwyi";
  };

  buildInputs = [ SDL2 ];
  nativeBuildInputs = [ pkg-config ];

  installPhase = ''
    runHook preInstall
    mkdir --parents $out/bin
    cp ${pname} $out/bin
    runHook postInstall
  '';

  meta = with lib; {
    homepage = url;
    inherit version;
    license = licenses.mit;
    description = "Starting Soon Timer for Tsoding Streams";
  };
}
