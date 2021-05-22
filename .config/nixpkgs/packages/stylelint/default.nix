{ lib, stdenv, fetchgit, yarn, mkYarnPackage }:

mkYarnPackage rec {

  pname = "stylelint";
  url = "https://github.com/stylelint/stylelint.git";
  version = "b01ed25dfa3e8231a976eef76bd5e81fb535b1e9";
  sha256 = "18v71nxxbfwqz5by9nq9921bdar3ww0z5z7h0y6rgnpi6iy5ck4x";
  rev = version;
  src = fetchgit { inherit url rev sha256; };
  packageJSON = "${src}/package.json";
  yarnLock = "${yarn-lock}/yarn.lock";
  defaultYarnFlags = [ "--offline" "--frozen-lockfile" "--ignore-engines" "--ignore-scripts" ];

  yarn-lock = stdenv.mkDerivation {
    inherit src;
    name = "${pname}-yarn.lock";
    buildInputs = [ yarn ];
    installPhase = ''
      runHook preInstall
      export HOME=.
      mkdir -p $out
      yarn import --ignore-engines --ignore-scripts
      cp yarn.lock $out
      runHook postInstall
    '';
    dontBuild = true;
    outputHashAlgo = "sha256";
    outputHashMode = "recursive";
    outputHash = "0cz16mnhagm300sfgmc031mzhbbwagbz3agji4hwrinw7bg3195f";
  };

  meta = with lib; {
    homepage = url;
    license = licenses.mit;
    description = "A mighty, modern linter that helps you avoid errors and enforce conventions in your styles.";
  };
}
