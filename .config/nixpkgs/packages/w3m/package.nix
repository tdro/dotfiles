# https://raw.githubusercontent.com/NixOS/nixpkgs/e0464e47880a69896f0fb1810f00e0de469f770a/pkgs/applications/networking/browsers/w3m/default.nix
# https://github.com/NixOS/nixpkgs/blob/master/COPYING
# Licence: MIT | https://mit-license.org/

{
  boehmgc,
  buildPackages,
  fetchgit,
  fetchpatch,
  gettext,
  gpm-ncurses,
  graphicsSupport ? !stdenv.isDarwin,
  imlib2,
  lib,
  libX11,
  man,
  mouseSupport ? !stdenv.isDarwin,
  ncurses,
  openssl,
  perl,
  pkg-config,
  sslSupport ? true,
  stdenv,
  testers,
  w3m,
  writeTextFile,
  x11Support ? graphicsSupport,
  zlib,
}:

let
  mktable = buildPackages.stdenv.mkDerivation {
    name = "w3m-mktable";
    inherit (w3m) src;
    nativeBuildInputs = [ pkg-config boehmgc ];
    makeFlags = [ "mktable" ];
    installPhase = ''
      install -D mktable $out/bin/mktable
    '';
  };
in stdenv.mkDerivation rec {
  pname = "w3m";
  version = "0.5.3+git20230121";

  src = fetchgit {
    url = "https://github.com/tats/w3m.git";
    rev = "v${version}";
    sha256 = "sha256-upb5lWqhC1jRegzTncIz5e21v4Pw912FyVn217HucFs=";
  };

  NIX_LDFLAGS = lib.optionalString stdenv.isSunOS "-lsocket -lnsl";
  makeFlags = [ "AR=${stdenv.cc.bintools.targetPrefix}ar" ];

  PERL = "${perl}/bin/perl";
  MAN  = "${man}/bin/man";

  patches = [
    (fetchpatch {
      name = "RAND_egd.libressl.patch";
      url = "https://raw.githubusercontent.com/NixOS/nixpkgs/e0464e47880a69896f0fb1810f00e0de469f770a/pkgs/applications/networking/browsers/w3m/RAND_egd.libressl.patch";
      sha256 = "sha256-WnzwaLjscIbL+zpTBHhm5oHTiuLVSLsVQC3vaUdCuIA=";
    })
    (fetchpatch {
      name = "https.patch";
      url = "https://aur.archlinux.org/cgit/aur.git/plain/https.patch?h=w3m-mouse&id=5b5f0fbb59f674575e87dd368fed834641c35f03";
      sha256 = "08skvaha1hjyapsh8zw5dgfy433mw2hk7qy9yy9avn8rjqj7kjxk";
    })
    (writeTextFile {
      name = "remove-viewing-status-message.patch";
      text = ''
diff --git a/display.c b/display.c
index f3df215..a9194fe 100644
--- a/display.c
+++ b/display.c
@@ -334,13 +334,13 @@ make_lastline_message(Buffer *buf)
     }
     else
 	/* FIXME: gettextize? */
-	Strcat_charp(msg, "Viewing");
+	Strcat_charp(msg, "");
 #ifdef USE_SSL
     if (buf->ssl_certificate)
-	Strcat_charp(msg, "[SSL]");
+	Strcat_charp(msg, "");
 #endif
-    Strcat_charp(msg, " <");
-    Strcat_charp(msg, buf->buffername);
+    Strcat_charp(msg, "");
+    Strcat_charp(msg, "");
 
     if (s) {
 	int l = COLS - 3 - sl;
@@ -356,11 +356,11 @@ make_lastline_message(Buffer *buf)
 #endif
 	    Strtruncate(msg, l);
 	}
-	Strcat_charp(msg, "> ");
-	Strcat(msg, s);
+	Strcat_charp(msg, "");
+	Strcat(msg, "");
     }
     else {
-	Strcat_charp(msg, ">");
+	Strcat_charp(msg, "");
     }
     return msg;
 }
      '';
    })
  ];

  postPatch = lib.optionalString (stdenv.hostPlatform != stdenv.buildPlatform) ''
    ln -s ${mktable}/bin/mktable mktable
    sed -ie 's!mktable.*:.*!mktable:!' Makefile.in
  '';

  nativeBuildInputs = [ pkg-config gettext ];

  buildInputs = [ ncurses boehmgc zlib ] ++ lib.optional sslSupport openssl
    ++ lib.optional mouseSupport gpm-ncurses
    ++ lib.optional graphicsSupport imlib2 ++ lib.optional x11Support libX11;

  postInstall = lib.optionalString graphicsSupport ''
    ln -s $out/libexec/w3m/w3mimgdisplay $out/bin
  '';

  configureFlags = [ "--with-ssl=${openssl.dev}" "--with-gc=${boehmgc.dev}" ]
    ++ lib.optionals (stdenv.buildPlatform != stdenv.hostPlatform)
    [ "ac_cv_func_setpgrp_void=yes" ] ++ lib.optional graphicsSupport
    "--enable-image=${lib.optionalString x11Support "x11,"}fb"
    ++ lib.optional (graphicsSupport && !x11Support) "--without-x";

  preConfigure = ''
    substituteInPlace ./configure --replace "/lib /usr/lib /usr/local/lib /usr/ucblib /usr/ccslib /usr/ccs/lib /lib64 /usr/lib64" /no-such-path
    substituteInPlace ./configure --replace /usr /no-such-path
  '';

  hardeningDisable = [ "format" ];
  enableParallelBuilding = false;
  LIBS = lib.optionalString x11Support "-lX11";

  passthru.tests.version = testers.testVersion {
    inherit version;
    package = w3m;
    command = "w3m -version";
  };

  meta = with lib; {
    homepage = "https://w3m.sourceforge.net/";
    changelog = "https://github.com/tats/w3m/blob/v${version}/ChangeLog";
    description = "A text-mode web browser";
    platforms = platforms.unix;
    license = licenses.mit;
    mainProgram = "w3m";
  };
}
