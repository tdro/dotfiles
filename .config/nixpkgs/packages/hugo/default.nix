{ lib, buildGoModule, fetchgit, installShellFiles }:

buildGoModule rec {
  pname = "hugo";
  version = "0.108.0";

  src = fetchgit {
    rev = "v${version}";
    url = "https://github.com/gohugoio/hugo.git";
    sha256 = "sha256-MbpBGqu7IwQCf9DjSfIDi25ZGJYTI6xxSk9wPWxychw=";
  };

  doCheck = false;
  proxyVendor = true;
  vendorSha256 = "sha256-ECA7xy7h3nkslW6bjjZWy3IxvF3Y1TTlGq8Os6R9UvA=";

  tags = [ "extended" ];
  subPackages = [ "." ];
  nativeBuildInputs = [ installShellFiles ];

  meta = {
    license = lib.licenses.asl20;
    homepage = "https://gohugo.io";
    description = "A fast and modern static website engine";
  };
}
