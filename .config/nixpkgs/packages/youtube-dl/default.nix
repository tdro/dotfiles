{ python38Packages, lib, fetchurl, zip, ffmpeg, rtmpdump, phantomjs2
, atomicparsley, pandoc, generateManPage ? true, ffmpegSupport ? true
, rtmpSupport ? true, phantomjsSupport ? false, hlsEncryptedSupport ? true
, installShellFiles, makeWrapper }:

python38Packages.buildPythonPackage rec {

  pname = "youtube-dl";
  version = "2021.05.16";

  src = fetchurl {
    url = "https://yt-dl.org/downloads/${version}/${pname}-${version}.tar.gz";
    sha256 = "1z8sdzvkxhscnzy7cnjag308glif0k8jylr11biqwzypm1f2l0fl";
  };

  nativeBuildInputs = [ installShellFiles makeWrapper ];
  buildInputs = [ zip ] ++ lib.optional generateManPage pandoc;
  propagatedBuildInputs =
    lib.optional hlsEncryptedSupport python38Packages.pycryptodome;

  makeWrapperArgs = let
    packagesToBinPath = [ atomicparsley ] ++ lib.optional ffmpegSupport ffmpeg
      ++ lib.optional rtmpSupport rtmpdump
      ++ lib.optional phantomjsSupport phantomjs2;
  in [ ''--prefix PATH : "${lib.makeBinPath packagesToBinPath}"'' ];

  setupPyBuildFlags = [ "build_lazy_extractors" ];

  postInstall = ''
    installShellCompletion youtube-dl.zsh
  '';

  doCheck = false;

  meta = with lib; {
    homepage = "https://ytdl-org.github.io/youtube-dl/";
    description =
      "Command-line tool to download videos from YouTube.com and other sites";
    longDescription = ''
      youtube-dl is a small, Python-based command-line program
      to download videos from YouTube.com and a few more sites.
      youtube-dl is released to the public domain, which means
      you can modify it, redistribute it or use it however you like.
    '';
    license = licenses.publicDomain;
    platforms = with platforms; linux ++ darwin;
    maintainers = with maintainers; [
      bluescreen303
      phreedom
      AndersonTorres
      fpletz
      enzime
      ma27
    ];
  };
}
