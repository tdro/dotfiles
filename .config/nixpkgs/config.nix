let

  stable = import (builtins.fetchTarball {
    url = "https://github.com/NixOS/nixpkgs/archive/360e2af4f87.tar.gz";
    sha256 = "1i3i9cpn6m3r07pgw4w3xinbqmxkm7pmnqjlz96x424ngbc21sg2"; }) {};

  unstable = import (builtins.fetchTarball {
    url = "https://github.com/NixOS/nixpkgs/archive/7dc2d9f819c.tar.gz";
    sha256 = "19zgr6mrfx7z4w822n3wbw3r3javrjszs7jsiz4r2fbq2l3h68gx"; }) {};

in

{
  allowUnfree = true;

  packageOverrides = pkgs: with stable; {

    Terminal = pkgs.buildEnv {
      name = "terminal";
      paths = [
        (callPackage ./packages/chromexup/default.nix {})
        (callPackage ./packages/systemd2nix/default.nix {})
        (callPackage ./packages/vale-styles/default.nix {})
        (pass.withExtensions (ext: with ext; [ pass-audit pass-import pass-otp ]))
        unstable.fzf
        unstable.hugo
        aerc
        alsaUtils
        ansible_2_9
        bat
        bfg-repo-cleaner
        bleachbit
        davmail
        desktop-file-utils
        diceware
        dive
        docker-compose
        dtrx
        electrum
        emacs
        encfs
        entr
        exercism
        ffmpeg
        fortune
        gettext
        gifsicle
        groff
        highlight
        ideviceinstaller
        imagemagick
        img2pdf
        keychain
        kjv
        libqalculate
        lynx
        mdcat
        mimeo
        moc
        neofetch
        newsboat
        nnn
        ocrmypdf
        pandoc
        picotts
        pngnq
        pngquant
        poppler_utils
        powertop
        pulsemixer
        ranger
        rclone
        ripgrep
        rxvt-unicode
        sbcl
        silver-searcher
        sshfs
        surfraw
        tcl
        trash-cli
        vale
        vault
        vimHugeX
        w3m
        wavemon
        weechat
        xdg-user-dirs
        youtube-dl
        zbar
      ];
      pathsToLink = [ "/etc" "/share" "/bin" ];
    };

    Graphical = pkgs.buildEnv {
      name = "graphical";
      paths = [
        (callPackage ./packages/boomer/default.nix {})
        (callPackage ./packages/dmenu/default.nix {})
        (callPackage ./packages/gnaural/default.nix {})
        (callPackage ./packages/ntrviewer/default.nix {})
        unstable.ungoogled-chromium
        aegisub
        anki
        audacity
        blender
        copyq
        diffpdf
        escrotum
        evince
        feh
        firefox
        flameshot
        freerdp
        gImageReader
        gcolor2
        gimp
        gnome3.simple-scan
        gnome3.zenity
        google-chrome
        gparted
        i3lock-fancy
        keepassxc
        krop
        libnotify
        libreoffice
        mate.engrampa
        meld
        mplayer
        mupdf
        mypaint
        palemoon
        pavucontrol
        peek
        planner
        qownnotes
        qrencode
        recoll
        redshift
        rofi
        scrcpy
        screenkey
        scribus
        sigil
        skippy-xd
        spaceFM
        sqlitebrowser
        sublime3-dev
        syncthing
        tabula
        thunderbird
        tigervnc
        treesheets
        treesheets
        unclutter
        vimb
        virt-manager
        vscodium
        wmctrl
        xournalpp
        xsane
        zathura
        zim
      ];
      pathsToLink = [ "/share" "/bin" ];
    };

    Xorg = pkgs.buildEnv {
      name = "xorg";
      paths = [
        xorg.xauth
        xorg.xev
        xorg.xf86inputevdev
        xorg.xf86inputlibinput
        xorg.xf86inputsynaptics
        xorg.xf86videoamdgpu
        xorg.xf86videoati
        xorg.xf86videointel
        xorg.xf86videonouveau
        xorg.xinit
        xorg.xinput
        xorg.xmodmap
        xorg.xorgserver
        xorg.xrandr
        xorg.xrdb
        xorg.xset
        xorg.xsetroot
        glxinfo
        x11vnc
        xbindkeys
        xdotool
        xsel
        xzoom
      ];
    };

    Awesome = pkgs.buildEnv {
      name = "awesome";
      paths = [ awesome lxappearance deepin.deepin-gtk-theme ];
      pathsToLink = [ "/share" "/bin" ];
    };

    Xfce = pkgs.buildEnv {
      name = "xfce";
      paths = [
        plank
        deadbeef
        zuki-themes
        polkit_gnome
        xfce.exo
        xfce.gvfs
        xfce.garcon
        xfce.tumbler
        xfce.xfwm4
        xfce.xfwm4-themes
        xfce.thunar
        xfce.thunar-archive-plugin
        xfce.thunar-volman
        xfce.xfconf
        xfce.xfdesktop
        xfce.libxfce4ui
        xfce.libxfce4util
        xfce.xfce4-session
        xfce.xfce4-settings
      ];
    };

    Fonts = pkgs.buildEnv {
      name = "fonts";
      paths = [
        (callPackage ./packages/nerdfonts-dejavu-sans-mono/default.nix {})
        etBook
        ibm-plex
        corefonts
        cm_unicode
        cooper-hewitt
        font-awesome_4
        yanone-kaffeesatz
        noto-fonts
        noto-fonts-cjk
        noto-fonts-emoji
        fira
        fira-code
        fira-mono
        fira-code-symbols
        source-code-pro
        source-serif-pro
      ];
    };

    Audio = pkgs.buildEnv {
      name = "audio";
      paths = [ ardour cadence qjackctl jack2 ];
    };

    LaTeX = pkgs.buildEnv {
      name = "latex";
      paths = [ gummi texworks texlive.combined.scheme-full ];
    };

    Android = pkgs.buildEnv {
      name = "android";
      paths = [
        (callPackage ./packages/edl/default.nix {})
        (callPackage ./packages/mkbootfs/default.nix {})
        (callPackage ./packages/mkbootimg/default.nix {})
        abootimg
      ];
    };

    JavaScript = pkgs.buildEnv {
      name = "javascript";
      paths = [
        nodejs-13_x
        unstable.deno
        nodePackages.prettier
        nodePackages.eslint
        nodePackages.node2nix
        nodePackages.bower2nix
      ];
      pathsToLink = [ "/bin" ];
    };

    Python = pkgs.buildEnv {
      name = "python";
      paths = [
        (python38.withPackages
          (ps: with ps; [ mypy bandit pylint pip2nix pyflakes ]))
      ];
    };

    PHP = pkgs.buildEnv {
      name = "php";
      paths = [
        php74
        php74Packages.psysh
        php74Packages.psalm
        php74Packages.phpcbf
        php74Packages.phpstan
        php74Packages.composer
      ];
    };

    Lua = pkgs.buildEnv {
      name = "lua";
      paths = [
        (callPackage ./packages/luaformatter/default.nix {})
        lua5_3
        lua53Packages.luacheck
      ];
    };

    Elixir = pkgs.buildEnv {
      name = "elixir";
      paths = [ elixir_1_10 ];
    };

    Html = pkgs.buildEnv {
      name = "html";
      paths = [
        html-tidy
        html-xml-utils
        libxml2
        xmlstarlet
      ];
    };

    Shell = pkgs.buildEnv {
      name = "shell";
      paths = [ bats shellcheck dash ];
    };

    Haskell = pkgs.buildEnv {
      name = "haskell";
      paths = [ ghc ghcid hlint ];
    };

    Perl = pkgs.buildEnv {
      name = "perl";
      paths = [ rakudo perl530 perl530Packages.PerlCritic perl530Packages.PerlTidy ];
    };

    Nix = pkgs.buildEnv {
      name = "nix";
      paths = [ nixfmt nixpkgs-fmt nixpkgs-lint nix-linter ];
    };

    C = pkgs.buildEnv {
      name = "c";
      paths = [ gnumake meson ninja gcc ];
    };

    Golang = pkgs.buildEnv {
      name = "golang";
      paths = [ go unstable.gore ];
    };

    Rust = pkgs.buildEnv {
      name = "rust";
      paths = [ evcxr rustup ];
    };

    CSS = pkgs.buildEnv {
      name = "css";
      paths = [
        (callPackage ./packages/csstidy/default.nix {})
        csslint
      ];
    };
  };
}
