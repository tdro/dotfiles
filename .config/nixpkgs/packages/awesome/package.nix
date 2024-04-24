{ lib, stdenv, fetchgit, lua, cairo, librsvg, cmake, imagemagick, pkg-config
, gdk-pixbuf, xorg, libstartup_notification, libxdg_basedir, libpthreadstubs
, xcb-util-cursor, makeWrapper, pango, gobject-introspection, which, dbus
, nettools, git, doxygen, xmlto, docbook_xml_dtd_45, docbook_xsl
, findXMLCatalogs, libxkbcommon, xcbutilxrm, hicolor-icon-theme, asciidoctor
, gtk3, makeFontsConf, ghostscript }:

let luaEnv = lua.withPackages (ps: [ ps.lgi ps.ldoc ]);

in stdenv.mkDerivation rec {
  pname = "awesome";
  version = "d2dc428e567e378a3f534c4d748543413fc30172";

  src = fetchgit {
    rev = version;
    url = "https://github.com/awesomeWM/awesome.git";
    sha256 = "sha256-gViEIuDn9ygzVof8e5e7cqDVPNeKDzlXK8V8oYzUUgA=";
  };

  nativeBuildInputs = [
    asciidoctor
    cmake
    docbook_xml_dtd_45
    docbook_xsl
    doxygen
    findXMLCatalogs
    imagemagick
    makeWrapper
    pkg-config
    xmlto
  ];

  outputs = [ "out" "doc" ];

  FONTCONFIG_FILE = makeFontsConf {
    fontDirectories = [ "${ghostscript}/share/ghostscript/fonts" ];
  };

  propagatedUserEnvPkgs = [ hicolor-icon-theme ];

  buildInputs = [
    cairo
    dbus
    gdk-pixbuf
    git
    gobject-introspection
    gtk3
    libpthreadstubs
    librsvg
    libstartup_notification
    libxdg_basedir
    libxkbcommon
    lua
    luaEnv
    nettools
    pango
    xcb-util-cursor
    xcbutilxrm
    xorg.libXau
    xorg.libXdmcp
    xorg.libxcb
    xorg.libxshmfence
    xorg.xcbutil
    xorg.xcbutilimage
    xorg.xcbutilkeysyms
    xorg.xcbutilrenderutil
    xorg.xcbutilwm
  ];

  cmakeFlags = [ "-DOVERRIDE_VERSION=${version}" ]
    ++ lib.optional lua.pkgs.isLuaJIT
    "-DLUA_LIBRARY=${lua}/lib/libluajit-5.1.so";

  GI_TYPELIB_PATH = "${pango.out}/lib/girepository-1.0";
  LUA_CPATH = "${luaEnv}/lib/lua/${lua.luaversion}/?.so";
  LUA_PATH = "${luaEnv}/share/lua/${lua.luaversion}/?.lua;;";

  postInstall = ''
    mv "$out/bin/awesome" "$out/bin/.awesome-wrapped"
    makeWrapper "$out/bin/.awesome-wrapped" "$out/bin/awesome" \
      --set GDK_PIXBUF_MODULE_FILE "$GDK_PIXBUF_MODULE_FILE" \
      --add-flags '--search ${luaEnv}/lib/lua/${lua.luaversion}' \
      --add-flags '--search ${luaEnv}/share/lua/${lua.luaversion}' \
      --prefix GI_TYPELIB_PATH : "$GI_TYPELIB_PATH"

    wrapProgram $out/bin/awesome-client \
      --prefix PATH : "${which}/bin"
  '';

  passthru = { inherit lua; };

  meta = with lib; {
    license = licenses.gpl2Plus;
    platforms = platforms.linux;
    homepage = "https://awesomewm.org/";
    description = "Highly configurable, dynamic window manager for X";
  };
}
