let

  stable = import (builtins.fetchTarball {
    url = "https://github.com/NixOS/nixpkgs/archive/c6b23ba64ae.tar.gz";
    sha256 = "13hg91g46qg2bbpdzpnmzcrsayfbkcp0gx36n8lsb2v980vahvi3"; }) {};

  unstable = import (builtins.fetchTarball {
    url = "https://github.com/NixOS/nixpkgs/archive/a36bf6faf96.tar.gz";
    sha256 = "12n0mzkvs81ygspdjia03fv3v88cbbwznrpn375farcrsjzl86mc"; }) {};

in

{
  allowUnfree = true;

  packageOverrides = pkgs: with stable; {

    # Machines

    Heron = pkgs.buildEnv {
      name = "heron";
      paths = [
        Terminal Graphical Xorg Awesome Fonts Audio LaTeX
        Android JavaScript Python PHP Lua Elixir Html Shell Haskell
        Perl Nix C Golang Rust CSS SQL YAML
      ];
    };

    Talon = pkgs.buildEnv {
      name = "talon";
      paths = [ Heron ];
    };

    Ferret = pkgs.buildEnv {
      name = "ferret";
      paths = [ Terminal Graphical Fonts Xorg Awesome Audio ];
    };

    Tiger = pkgs.buildEnv {
      name = "tiger";
      paths = [ Terminal Graphical Fonts Xorg Awesome JavaScript Python ];
    };

    Hound = pkgs.buildEnv {
      name = "hound";
      paths = [ Terminal Graphical Fonts Xorg Xfce JavaScript Python ];
    };

    # Package Sets

    Terminal = pkgs.buildEnv {
      name = "terminal";
      paths = [
        (callPackage ./packages/amfora/default.nix {})
        (callPackage ./packages/chromexup/default.nix {})
        (callPackage ./packages/gmni/default.nix {})
        (callPackage ./packages/systemd2nix/default.nix {})
        (callPackage ./packages/vale-styles/default.nix {})
        (callPackage ./packages/youtube-dl/default.nix {})
        (pass.withExtensions (ext: with ext; [ pass-audit pass-import pass-otp ]))
        unstable.emacs
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
        encfs
        entr
        exercism
        ffmpeg
        flashrom
        fortune
        gettext
        gifsicle
        groff
        highlight
        ideviceinstaller
        imagemagick
        img2pdf
        jpegoptim
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
        tmux
        trash-cli
        units
        vale
        vault
        vimHugeX
        w3m
        wavemon
        weechat
        xdg-user-dirs
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
        unstable.tilp2
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
        sxiv
        syncthing
        tabula
        thunderbird
        tigervnc
        transmission-gtk
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
        (callPackage ./packages/xprintidle/default.nix {})
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
      paths = [
        (callPackage ./packages/deepin-gtk-theme/default.nix {})
        awesome
        lxappearance
      ];
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
        nodejs-14_x
        unstable.deno
        nodePackages.bower2nix
        nodePackages.eslint
        nodePackages.jsonlint
        nodePackages.node2nix
        nodePackages.prettier
      ];
      pathsToLink = [ "/bin" ];
    };

    Python = pkgs.buildEnv {
      name = "python";
      paths = [
        (python38.withPackages (ps: with ps; [ mypy bandit pylint pyflakes ]))
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
      paths = [ gnumake meson ninja gcc clang-tools astyle ];
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

    SQL = pkgs.buildEnv {
      name = "sql";
      paths = [
        sqlint
      ];
    };

    YAML = pkgs.buildEnv {
      name = "yaml";
      paths = [
        (callPackage ./packages/ruamel.yaml.cmd/default.nix {})
        python38Packages.yamllint
      ];
    };
  };
}
