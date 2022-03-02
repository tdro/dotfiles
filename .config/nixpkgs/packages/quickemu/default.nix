{ lib, fetchgit, fetchpatch, stdenv, makeWrapper, qemu, gnugrep, lsb-release, jq
, procps, python3, cdrtools, usbutils, util-linux, spicy, swtpm, wget
, xdg-user-dirs, xrandr, zsync, OVMF, quickemu, testVersion }:

let

  runtimePaths = [
    qemu
    gnugrep
    jq
    lsb-release
    procps
    python3
    cdrtools
    usbutils
    util-linux
    spicy
    swtpm
    wget
    xdg-user-dirs
    xrandr
    zsync
  ];

in stdenv.mkDerivation rec {
  pname = "quickemu";
  version = "3940f7b4521ee840c6811dde120734df97dc0e07";

  src = fetchgit {
    rev = version;
    fetchSubmodules = false;
    url = "https://github.com/quickemu-project/quickemu.git";
    sha256 = "1jrkh6hlqf556sv3243rb1i89kar20gy2kzkgrjaw5x6gmvmcbs0";
  };

  patches = [
    (fetchpatch {
      name = "efi_vars_ensure_writable.patch";
      url = "https://raw.githubusercontent.com/NixOS/nixpkgs/1ea561212a9269f61de8564bcf2db1f7f72d4b0e/pkgs/development/quickemu/efi_vars_ensure_writable.patch";
      sha256 = "1cz0dxlhyr7gak91yfz3b5vcd95cz0xgj9ri7hjvdpx8ng0nf5ga";
    })
    # (fetchpatch {
    #   name = "input_overrides.patch";
    #   url = "https://raw.githubusercontent.com/NixOS/nixpkgs/1ea561212a9269f61de8564bcf2db1f7f72d4b0e/pkgs/development/quickemu/input_overrides.patch";
    #   sha256 = "0bs9q5c4ffv3r1mqf9c4affphclyf40f9c66hnnlz1prvyrqyfsw";
    # })
  ];

  nativeBuildInputs = [ makeWrapper ];

  installPhase = ''
    runHook preInstall

    install -Dm755 -t "$out/bin" quickemu quickget macrecovery

    for f in quickget macrecovery quickemu; do
      wrapProgram $out/bin/$f \
        --prefix PATH : "${lib.makeBinPath runtimePaths}" \
        --set ENV_EFI_CODE "${OVMF.fd}/FV/OVMF_CODE.fd" \
        --set ENV_EFI_VARS "${OVMF.fd}/FV/OVMF_VARS.fd"
    done

    runHook postInstall
  '';

  passthru.tests = testVersion { package = quickemu; };

  meta = with lib; {
    license = licenses.mit;
    maintainers = with maintainers; [ fedx-sudo ];
    homepage = "https://github.com/quickemu-project/quickemu";
    description = "Quickly create and run optimised Windows, macOS and Linux desktop virtual machines";
  };
}
