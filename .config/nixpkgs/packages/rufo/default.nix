{ buildRubyGem, fetchgit, lib, ruby, git }:

buildRubyGem rec {

  inherit ruby;
  gemName = "rufo";
  name = "${gemName}-${version}";
  version = "b3f3aedf759d792761ad52e6bddb9ed51ffc6731";

  src = fetchgit {
    rev = version;
    url = "https://github.com/ruby-formatter/rufo.git";
    sha256 = "1z87ivd8xpm3ggbcv3sjr4c0ws6733yfh8l6xg5f0km6ax7s8h1j";
  };

  buildInputs = [ git ruby ];

  preBuild = ''
    rm spec/fixtures/file_finder/only_gemfiles/a.gemspec
  '';

  preFixup = ''
    cp exe/rufo $out/bin/rufo
    cp -rT lib $out/lib
  '';

  meta = with lib; {
    inherit version;
    license = licenses.mit;
    description = "The Ruby Formatter";
    homepage = "https://github.com/ruby-formatter/rufo";
  };
}
