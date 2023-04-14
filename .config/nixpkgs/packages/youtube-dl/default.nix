{ lib, python39, ffmpeg, rtmpdump, phantomjs2, atomicparsley
, ffmpegSupport ? true, rtmpSupport ? true, phantomjsSupport ? false
, hlsEncryptedSupport ? true, withAlias ? true }:

with python39.pkgs;

buildPythonPackage rec {
  pname = "yt-dlp";
  version = "2021.10.22";

  src = fetchPypi {
    inherit pname;
    version = builtins.replaceStrings [ ".0" ] [ "." ] version;
    sha256 = "sha256-okuWZr0iNBSeTajE8Wu45fdGwpQo0S7gT8HBG1JHowc=";
  };

  propagatedBuildInputs = [ websockets mutagen ] ++ lib.optional hlsEncryptedSupport pycryptodomex;

  makeWrapperArgs = let packagesToBinPath = [ atomicparsley ]
    ++ lib.optional ffmpegSupport ffmpeg
    ++ lib.optional rtmpSupport rtmpdump
    ++ lib.optional phantomjsSupport phantomjs2;
  in [ ''--prefix PATH : "${lib.makeBinPath packagesToBinPath}"'' ];

  doCheck = false;
  setupPyBuildFlags = [ "build_lazy_extractors" ];
  postInstall = lib.optionalString withAlias ''ln -s "$out/bin/yt-dlp" "$out/bin/youtube-dl"'';

  meta = with lib; {
    license = licenses.unlicense;
    homepage = "https://github.com/yt-dlp/yt-dlp/";
    changelog = "https://github.com/yt-dlp/yt-dlp/raw/${version}/Changelog.md";
    description = "Command-line tool to download videos from YouTube.com and other sites (youtube-dl fork)";
  };
}
