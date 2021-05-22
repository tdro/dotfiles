{ lib, stdenv, fetchFromGitHub, makeWrapper, nim, libX11, libXrandr, libGL }:

let

  x11-nim = fetchFromGitHub {
    repo = "x11";
    owner = "nim-lang";
    rev = "b7bae7dffa4e3f12370d5a18209359422ae8bedd";
    sha256 = "1j3kyp0vf2jl20c67gcm759jnfskdf0wc4ajrdbvfxias285c5sb";
  };

  opengl-nim = fetchFromGitHub {
    repo = "opengl";
    owner = "nim-lang";
    rev = "a6fb649e5bd94d8420d4a11287092a4dc3e922b4";
    sha256 = "0w62lfrdms2vb24kd4jnypwmqvdk5x9my1dinnqdq82yl4nz6d0s";
  };

in stdenv.mkDerivation rec {

  pname = "boomer";
  version = "d16c65ce3eae31f4c77de1585b340d8d624c1252";
  src = fetchFromGitHub {
    owner = "tsoding";
    repo = "boomer";
    rev = version;
    sha256 = "1kqfg2i5p1zrvl9jx0ig7f0ckxnaxi9svr0bs52aavwydldnnl8d";
  };

  buildInputs = [ nim libX11 libXrandr libGL makeWrapper ];

  buildPhase = ''
    runHook preBuild
    HOME=$TMPDIR
    nim -p:${x11-nim}/ -p:${opengl-nim}/src c -d:release src/boomer.nim
    runHook postBuild
  '';

  installPhase = ''
    runHook preInstall
    install -Dt $out/bin src/boomer
    runHook postInstall
  '';

  fixupPhase = ''
    runHook preFixup
    patchelf --set-rpath ${
      lib.makeLibraryPath [ stdenv.cc.cc libX11 libXrandr libGL ]
    } $out/bin/boomer
    wrapProgram "$out/bin/boomer" --set LIBGL_ALWAYS_SOFTWARE 1
    runHook postFixup
  '';

  meta = with lib; {
    license = licenses.mit;
    platforms = platforms.linux;
    homepage = "https://github.com/tsoding/boomer";
  };
}
