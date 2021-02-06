{ stdenv, fetchgit, buildGoModule }:

buildGoModule rec {
  pname = "amfora";
  version = "v1.6.0";
  url = "https://github.com/makeworld-the-better-one/amfora";

  src = fetchgit {
    inherit url;
    rev = version;
    sha256 = "1f5r12hmdgj26p4ss5pcpfcvqlcn19fr9xvvvk2izckcr48p4fy7";
  };

  vendorSha256 = "0mkk7xxfxxp1w9890mkmag11mzxhy2zmh8v1macpyp1zmzgs21f8";

  meta = with stdenv.lib; {
    homepage = url;
    license = licenses.gpl3;
    description = "A fancy terminal browser for the Gemini protocol.";
  };
}
