{ stdenv, pass, fetchFromGitHub, python38, makeWrapper, fetchpatch }:

with python38.pkgs;

let

  pythonEnv = pythonPackages.python.withPackages (_: [
    defusedxml
    setuptools
    pyaml
    pykeepass
    filemagic
    cryptography
    secretstorage
  ]);

in stdenv.mkDerivation rec {
  pname = "pass-import";
  version = "a8f56cc6a85362ed20f46c1360c87fdd213b890c";

  src = fetchFromGitHub {
    owner = "roddhjav";
    repo = "pass-import";
    rev = version;
    sha256 = "0hg40fqnss9n31ns8lc8v1h9hjdw4qjg68xs0hm6c9njabahl1pq";
  };

  dontBuild = true;
  buildInputs = [ pythonEnv ];
  nativeBuildInputs = [ makeWrapper ];

  patches = [
    # https://github.com/roddhjav/pass-import/pull/91
    (fetchpatch {
      url = "https://github.com/roddhjav/pass-import/commit/6ccaf639e92df45bd400503757ae4aa2c5c030d7.patch";
      sha256 = "0lw9vqvbqcy96s7v7nz0i1bdx93x7qr13azymqypcdhjwmq9i63h";
    })
  ];

  postPatch = ''
    sed -i -e 's|$0|${pass}/bin/pass|' import.bash
  '';

  installFlags = [ "PREFIX=$(out)" "BASHCOMPDIR=$(out)/etc/bash_completion.d" ];

  postFixup = ''
    install -D pass_import.py $out/${pythonPackages.python.sitePackages}/pass_import.py
    wrapProgram $out/lib/password-store/extensions/import.bash \
      --prefix PATH : "${pythonEnv}/bin" \
      --prefix PYTHONPATH : "$out/${pythonPackages.python.sitePackages}" \
      --run "export PREFIX"
  '';

  meta = with stdenv.lib; {
    description = "Pass extension for importing data from existing password managers";
    homepage = "https://github.com/roddhjav/pass-import";
    license = licenses.gpl3Plus;
    maintainers = with maintainers; [ lovek323 the-kenny fpletz tadfisher ];
    platforms = platforms.unix;
  };
}
