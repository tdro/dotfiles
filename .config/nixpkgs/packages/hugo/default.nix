{ lib, buildGoModule, fetchgit, installShellFiles }:

buildGoModule rec {
  pname = "hugo";
  version = "0.94.2";

  src = fetchgit {
    rev = "v${version}";
    url = "https://github.com/gohugoio/hugo.git";
    sha256 = "1pdahyw0addlyl1nq6igbnrvwbkqriy7w1nwhkiz0apj2gi70l3w";
  };

  doCheck = false;
  proxyVendor = true;
  vendorSha256 = "1jnmnm43w109jv3rhfchnqsq0k0lv59frddjns0axpac7vd5zjpb";

  tags = [ "extended" ];
  subPackages = [ "." ];
  nativeBuildInputs = [ installShellFiles ];

  postInstall = ''
    $out/bin/hugo gen man
    installManPage man/*
  '';

  meta = {
    license = lib.licenses.asl20;
    homepage = "https://gohugo.io";
    description = "A fast and modern static website engine";
    maintainers = with lib.maintainers; [ schneefux Br1ght0ne Frostman ];
  };
}
