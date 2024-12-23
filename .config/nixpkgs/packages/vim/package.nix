# https://raw.githubusercontent.com/NixOS/nixpkgs/959fc90712f99defaa7f3fbc32beeb76cdcecee6/pkgs/applications/editors/vim/full.nix
# https://github.com/NixOS/nixpkgs/blob/master/COPYING
# Licence: MIT | https://mit-license.org/

{
  writeTextFile,
  callPackage,
  config,
  fetchpatch,
  gettext,
  glib,
  gtk2-x11,
  gtk3-x11,
  lib,
  libICE,
  libSM,
  libX11,
  libXau,
  libXaw,
  libXext,
  libXmu,
  libXpm,
  libXt,
  libsodium,
  lua,
  makeWrapper,
  ncurses,
  perl,
  pkg-config,
  python3,
  ruby,
  stdenv,
  tcl,
  vimPlugins,
  wrapGAppsHook,
  writeText,
  wrapPythonDrv    ? false,
  guiSupport       ? "gtk3",
  luaSupport       ? config.vim.lua       or true,        # Lua interpreter
  pythonSupport    ? config.vim.python    or true,        # Python interpreter
  rubySupport      ? config.vim.ruby      or true,        # Ruby interpreter
  cscopeSupport    ? config.vim.cscope    or true,        # Enable cscope interface
  netbeansSupport  ? config.netbeans      or true,        # Enable NetBeans integration support.
  ximSupport       ? config.vim.xim       or true,        # less than 15KB, needed for deadkeys
  ftNixSupport     ? config.vim.ftNix     or true,        # Add nix indentation support from vim-nix (not needed for basic syntax highlighting)
  sodiumSupport    ? config.vim.sodium    or true,        # Enable sodium based encryption
  perlSupport      ? config.vim.perl      or false,       # Perl interpreter
  nlsSupport       ? config.vim.nls       or false,       # Enable NLS (gettext())
  tclSupport       ? config.vim.tcl       or false,       # Include Tcl interpreter
  multibyteSupport ? config.vim.multibyte or false,       # Enable multibyte editing support
  darwinSupport    ? config.vim.darwin    or false,       # Enable Darwin support
}:

let
  nixosRuntimepath = writeText "nixos-vimrc" ''
    set nocompatible
    syntax on

    function! NixosPluginPath()
      let seen = {}
      for p in reverse(split($NIX_PROFILES))
        for d in split(glob(p . '/share/vim-plugins/*'))
          let pluginname = substitute(d, ".*/", "", "")
          if !has_key(seen, pluginname)
            exec 'set runtimepath^='.d
            let after = d."/after"
            if isdirectory(after)
              exec 'set runtimepath^='.after
            endif
            let seen[pluginname] = 1
          endif
        endfor
      endfor
    endfunction

    execute NixosPluginPath()

    if filereadable("/etc/vimrc")
      source /etc/vimrc
    elseif filereadable("/etc/vim/vimrc")
      source /etc/vim/vimrc
    endif
  '';

  common = callPackage ({ lib, fetchgit }: rec {
    version = "9.1.0842";

    src = fetchgit {
      url= "https://github.com/vim/vim.git";
      rev = "v${version}";
      hash = "sha256-XLumABRUGMOMCX8wVB80cWCBqsY58bWHWOqtyR1Xyhg=";
    };

    enableParallelBuilding   = true;
    enableParallelInstalling = false;
    hardeningDisable         = [ "fortify" ];
    outputs                  = [ "out" "xxd" ];

    postPatch = ''substituteInPlace runtime/ftplugin/man.vim  --replace "/usr/bin/man " "man "'';

    postFixup = ''
      moveToOutput bin/xxd "$xxd"
      moveToOutput share/man/man1/xxd.1.gz "$xxd"
      for manFile in $out/share/man/*/man1/xxd.1*; do
        moveToOutput "share/man/$(basename "$(dirname "$(dirname "$manFile")")")/man1/xxd.1.gz" "$xxd"
      done
    '';

    meta = with lib; {
      description = "Most popular clone of the VI editor";
      homepage = "http://www.vim.org";
      license = licenses.vim;
      platforms = platforms.unix;
      mainProgram = "vim";
      outputsToInstall = [ "out" "xxd" ];
    };
  }

  ) { };

in stdenv.mkDerivation {

  pname = "vim-full";

  inherit (common) version outputs postPatch hardeningDisable enableParallelBuilding meta;

  src = common.src;

  patches = [
    (fetchpatch {
      name = "cflags-prune.diff";
      sha256 = "sha256-iotP1NZ57g2qSiEgokLdYMQZvwD0LPBMxdd16ovkEeo=";
      url = "https://raw.githubusercontent.com/NixOS/nixpkgs/51feecbe88742dd4496c96981d1a87a12c1022e7/pkgs/applications/editors/vim/cflags-prune.diff";
    })
    (writeTextFile {
      name = "terminal-gap.patch";
      text = ''
        diff --git a/src/terminal.c b/src/terminal.c
        index 6edc21a11..367253a3d 100644
        --- a/src/terminal.c
        +++ b/src/terminal.c
        @@ -1320,6 +1320,7 @@ position_cursor(win_T *wp, VTermPos *pos)
             wp->w_wrow = MIN(pos->row, MAX(0, wp->w_height - 1));
             wp->w_wcol = MIN(pos->col, MAX(0, wp->w_width - 1));
         #ifdef FEAT_PROP_POPUP
        +    if (!popup_is_popup(wp)) wp->w_wcol = MIN(pos->col + 2, MAX(0, wp->w_width - 1));
             if (popup_is_popup(wp))
             {
          wp->w_wrow += popup_top_extra(wp);
        @@ -3854,6 +3855,16 @@ term_line2screenline(
         {
             int off = screen_get_current_line_off();
         
        +    #ifdef FEAT_PROP_POPUP
        +    if (!popup_is_popup(wp)) {
        +      for (int i = 0; i < 2; ++i) {
        +        ScreenLines[off] = ' ';
        +        ++off;
        +      }
        +      max_col -= 2;
        +    }
        +    #endif
        +
             for (pos->col = 0; pos->col < max_col; )
             {
          VTermScreenCell cell;
      '';
    })
  ];

  configureFlags = [
    "--with-features=huge"
    "--disable-xsmp"          # XSMP session management
    "--disable-xsmp_interact" # XSMP interaction
    "--disable-workshop"      # Sun Visual Workshop support
    "--disable-sniff"         # Sniff interface
    "--disable-hangulinput"   # Hangul input support
    "--disable-fontset"       # X fontset output support
    "--disable-acl"           # ACL support
    "--disable-gpm"           # GPM (Linux mouse daemon)
    "--disable-mzschemeinterp"
    "--disable-gtk_check"
    "--disable-gtk2_check"
    "--disable-gnome_check"
    "--disable-motif_check"
    "--disable-athena_check"
    "--disable-nextaf_check"
    "--disable-carbon_check"
    "--disable-gtktest"
    "--enable-gui=gtk3"
    "--with-lua-prefix=${lua}"
    "--enable-luainterp"
  ] ++ lib.optionals lua.pkgs.isLuaJIT [ "--with-luajit" ]
    ++ lib.optionals pythonSupport     [ "--enable-python3interp=yes" "--with-python3-config-dir=${python3}/lib" "--disable-pythoninterp" ]
    ++ lib.optional  nlsSupport        "--enable-nls"
    ++ lib.optional  perlSupport       "--enable-perlinterp"
    ++ lib.optional  rubySupport       "--enable-rubyinterp"
    ++ lib.optional  tclSupport        "--enable-tclinterp"
    ++ lib.optional  multibyteSupport  "--enable-multibyte"
    ++ lib.optional  cscopeSupport     "--enable-cscope"
    ++ lib.optional  netbeansSupport   "--enable-netbeans"
    ++ lib.optional  ximSupport        "--enable-xim"
    ++ lib.optional  sodiumSupport     "--enable-sodium";

  nativeBuildInputs = [ pkg-config ]
    ++ lib.optional wrapPythonDrv makeWrapper
    ++ lib.optional nlsSupport gettext
    ++ lib.optional perlSupport perl
    ++ lib.optional (guiSupport == "gtk3") wrapGAppsHook;

  buildInputs = [
    ncurses
    glib
  ] ++ lib.optionals (guiSupport == "gtk2" || guiSupport == "gtk3") [
         libSM
         libICE
         libX11
         libXext
         libXpm
         libXt
         libXaw
         libXau
         libXmu
         gtk3-x11
       ] ++ lib.optional luaSupport lua ++ lib.optional pythonSupport python3
         ++ lib.optional tclSupport tcl ++ lib.optional rubySupport ruby
         ++ lib.optional sodiumSupport libsodium;

  # preBuild = ''
  #   sed --in-place "s|#STRIP = /bin/true|STRIP = true|g" src/Makefile
  # '';

  # dontStrip = true;   # TODO: Replace strip binary with true

  # LDFLAGS  = [ "-ggdb" "-Og" ];
  # CFLAGS   = [ "-ggdb" "-Og" ];
  # CXXFLAGS = [ "-ggdb" "-Og" ];

  preConfigure = lib.optionalString ftNixSupport ''
    cp ${vimPlugins.vim-nix.src}/ftplugin/nix.vim runtime/ftplugin/nix.vim
    cp ${vimPlugins.vim-nix.src}/indent/nix.vim runtime/indent/nix.vim
  '';

  preInstall = ''mkdir -p $out/share/applications $out/share/icons/{hicolor,locolor}/{16x16,32x32,48x48}/apps'';

  postInstall = ''
    ln -s $out/bin/vim $out/bin/vi
  '' + lib.optionalString stdenv.hostPlatform.isLinux ''
    ln -sfn '${nixosRuntimepath}' "$out"/share/vim/vimrc
  '';

  postFixup = common.postFixup + lib.optionalString wrapPythonDrv ''
    wrapProgram "$out/bin/vim" --prefix PATH : "${python3}/bin" \
      --set NIX_PYTHONPATH "${python3}/${python3.sitePackages}"
  '';
}
