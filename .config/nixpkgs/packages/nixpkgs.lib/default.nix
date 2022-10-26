{ lib, pkgs, stdenv, fetchgit }:

stdenv.mkDerivation rec {

  pname = "nixpkgs.lib";
  version = "f9d58ee370835f4c658cd0a62e8def4bda8b1f32";

  src = fetchgit {
    url = "https://github.com/nix-community/nixpkgs.lib.git";
    sha256 = "sha256-KnumcE6UuNQPapsr32KjcRVDVuRGWB5PnAczHoo9nJc=";
    rev = version;
  };

  installPhase = ''
    runHook preInstall
    mkdir --parents $out
    cp --recursive --no-target-directory $src $out
    runHook postInstall
  '';

  patches = [
    (pkgs.writeTextFile {
      name = "remove-nonexistent-external-calls.patch";
      text = ''
        diff --git a/lib/default.nix b/lib/default.nix
        index 0c0e2d5..76b99fe 100644
        --- a/lib/default.nix
        +++ b/lib/default.nix
        @@ -24,8 +24,8 @@ let
             # packaging
             customisation = callLibs ./customisation.nix;
             derivations = callLibs ./derivations.nix;
        -    maintainers = import ../maintainers/maintainer-list.nix;
        -    teams = callLibs ../maintainers/team-list.nix;
        +    maintainers = { };
        +    teams = { };
             meta = callLibs ./meta.nix;
             sources = callLibs ./sources.nix;
             versions = callLibs ./versions.nix;
        diff --git a/lib/trivial.nix b/lib/trivial.nix
        index 5d4fad8..d679563 100644
        --- a/lib/trivial.nix
        +++ b/lib/trivial.nix
        @@ -164,7 +164,7 @@ rec {
           version = release + versionSuffix;

           /* Returns the current nixpkgs release number as string. */
        -  release = lib.strings.fileContents ../.version;
        +  release = "";

           /* The latest release that is supported, at the time of release branch-off,
              if applicable.
                '';
    })
  ];

  meta = with lib; {
    description = "nixpkgs lib for cheap instantiation ";
    homepage = "https://github.com/nix-community/nixpkgs.lib";
  };
}
