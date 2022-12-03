let

  pkgs = import <nixpkgs> { };

  stable = import (builtins.fetchTarball {
    url = "https://releases.nixos.org/nixos/21.11/nixos-21.11.336020.2128d0aa28e/nixexprs.tar.xz";
    sha256 = "0w8plbxms0di6gnh0k2yhj0pgxzxas7g5x0m01zjzixf16i2bapj"; }) {};

  unstable = import (builtins.fetchTarball {
    url = "https://releases.nixos.org/nixos/unstable/nixos-22.11pre386147.e0a42267f73/nixexprs.tar.xz";
    sha256 = "0y6q1j17lmhxh1pqi2jj6xr21pnmachra48336nnbcpnxizswjgg"; }) { };

in

{
  allowBroken = true;
  allowUnfree = true;
  allowUnsupportedSystem = true;
  allowInsecurePredicate = pkgs: true;

  packageOverrides = pkgs: with stable; {

    # Machines

    Woodpecker = pkgs.buildEnv {
      name = "woodpecker";
      paths = [
        Terminal Graphical Xorg Awesome Fonts Audio LaTeX Dictionary Android JavaScript
        Python PHP Lua Elixir HTML Shell Haskell Perl Nix C Golang Rust CSS SQL YAML
        Ruby Nim Themes Emulators Clojure
      ];
    };

    Talon = pkgs.buildEnv {
      name = "talon"; paths = [ Woodpecker ];
    };

    Heron = pkgs.buildEnv {
      name = "heron"; paths = [ Woodpecker ];
    };

    Ferret = pkgs.buildEnv {
      name = "ferret";
      paths = [ Terminal Graphical Fonts Xorg Awesome Audio Themes ];
    };

    Tiger = pkgs.buildEnv {
      name = "tiger";
      paths = [ Nix Terminal Graphical Fonts Xorg Awesome JavaScript Python Themes ];
    };

    Hound = pkgs.buildEnv {
      name = "hound";
      paths = [ Terminal Graphical Fonts Xorg Xfce JavaScript Python Themes ];
    };

    Ant = pkgs.buildEnv {
      name = "ant";
      paths = [ Xorg-Aarch64 Xfce-Aarch64 Terminal-Aarch64 Graphical-Aarch64 Themes Fonts ];
    };

    # Package Sets

    Terminal = pkgs.buildEnv {
      name = "terminal";
      paths = [
        (callPackage ./packages/chromexup/default.nix {})
        (callPackage ./packages/hugo/default.nix {})
        (callPackage ./packages/pdf2htmlex/default.nix {})
        (callPackage ./packages/rxvt-unicode/default.nix {})
        (callPackage ./packages/systemd2nix/default.nix {})
        (callPackage ./packages/validatornu/default.nix {})
        (callPackage ./packages/youtube-dl/default.nix {})
        (unstable.pass.withExtensions (ext: with ext; [ pass-import pass-audit pass-otp ]))
        unstable.quickemu
        aerc
        alsaUtils
        amfora
        ansi2html
        ansible
        atool
        bat
        bind
        bleachbit
        calcurse
        cava
        csvkit
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
        expect
        ffmpeg
        flashrom
        fortune
        fzf
        gettext
        gifsicle
        git
        groff
        hexyl
        hexedit
        highlight
        ideviceinstaller
        imagemagick
        img2pdf
        jpegoptim
        jq
        keychain
        kjv
        libqalculate
        lynx
        mdcat
        mimeo
        moc
        monolith
        neofetch
        netcat-openbsd
        newsboat
        nnn
        ocrmypdf
        pandoc
        pdsh
        picotts
        pipes
        pngnq
        pngquant
        poppler_utils
        pssh
        ranger
        rclone
        ripgrep
        sbcl
        silver-searcher
        sshfs
        subversion
        surfraw
        tcl
        tesseract
        tmux
        trash-cli
        units
        vale
        vault
        vcal
        ventoy-bin
        vimHugeX
        vnstat
        w3m
        wavemon
        weechat
        woof
        xdg-user-dirs
        zbar
      ];
      pathsToLink = [ "/etc" "/share" "/bin" ];
    };

    Graphical = pkgs.buildEnv {
      name = "graphical";
      paths = [
        (callPackage ./packages/beaker-browser/default.nix {})
        (callPackage ./packages/boomer/default.nix {})
        (callPackage ./packages/dmenu/default.nix {})
        (callPackage ./packages/gnaural/default.nix {})
        (callPackage ./packages/ntrviewer/default.nix {})
        (callPackage ./packages/planner/default.nix {})
        (callPackage ./packages/scribus/default.nix {})
        (callPackage ./packages/sowon/default.nix {})
        (callPackage ./packages/tilp2/default.nix {})
        (mplayer.override { v4lSupport = true; })
        unstable.blender
        unstable.claws-mail
        unstable.firefox
        unstable.google-chrome
        unstable.nyxt
        unstable.palemoon
        unstable.ungoogled-chromium
        unstable.vimb
        aegisub
        anki
        code-server
        corrscope
        dconf
        diffpdf
        escrotum
        evince
        exiftool
        feh
        flameshot
        freerdp
        fsearch
        gImageReader
        gcolor2
        gimp
        gparted
        gromit-mpx
        i3lock-fancy
        kcharselect
        keepassxc
        kiwix
        krop
        libnotify
        libreoffice
        liferea
        mate.engrampa
        meld
        mupdf
        mypaint
        pavucontrol
        peek
        qownnotes
        qrencode
        recoll
        redshift
        rofi
        scrcpy
        screenkey
        sent
        sigil
        skippy-xd
        spaceFM
        stalonetray
        sublime3
        sxiv
        syncthing
        tabula
        tigervnc
        transmission-gtk
        treesheets
        virt-manager
        vlc
        vscodium
        xournalpp
        xsane
        yad
        zathura
        zeal
      ];
    };

    Emulators = pkgs.buildEnv {
      name = "emulators";
      paths = [
        (callPackage ./packages/tiemu/default.nix {})
        desmume
        mgba
      ];
    };

    Xorg = pkgs.buildEnv {
      name = "xorg";
      paths = [
        (callPackage ./packages/x11vnc/default.nix {})
        (callPackage ./packages/xprintidle/default.nix {})
        autocutsel
        glxinfo
        unclutter-xfixes
        weston
        wmctrl
        xbindkeys
        xdotool
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
        xsel
        xzoom
      ];
    };

    Awesome = pkgs.buildEnv {
      name = "awesome";
      paths = [ awesome ];
    };

    Xfce = pkgs.buildEnv {
      name = "xfce";
      paths = [
        bamf
        deadbeef
        dunst
        plank
        polkit_gnome
        xfce.exo
        xfce.garcon
        xfce.libxfce4ui
        xfce.libxfce4util
        xfce.thunar
        xfce.thunar-archive-plugin
        xfce.thunar-volman
        xfce.xfce4-session
        xfce.xfce4-settings
        xfce.xfconf
        xfce.xfdesktop
        xfce.xfwm4
        xfce.xfwm4-themes
        zuki-themes
      ];
    };

    Fonts = pkgs.buildEnv {
      name = "fonts";
      paths = [
        (callPackage ./packages/nerdfonts-dejavu-sans-mono/default.nix {})
        cm_unicode
        cooper-hewitt
        corefonts
        etBook
        fira
        fira-code
        fira-code-symbols
        fira-mono
        font-awesome_4
        ibm-plex
        noto-fonts
        noto-fonts-cjk
        noto-fonts-emoji
        source-code-pro
        source-serif-pro
        yanone-kaffeesatz
      ];
    };

    Themes = pkgs.buildEnv {
      name = "themes";
      paths = [
        gtk-engine-murrine
        librsvg
        lxappearance
        papirus-icon-theme
        qt4
        vanilla-dmz
      ];
    };

    Dictionary = pkgs.buildEnv {
      name = "dictionary";
      paths = [
        aspell
        aspellDicts.en
        aspellDicts.en-computers
        aspellDicts.en-science
        hunspell
        hunspellDicts.en_US-large
        hyphen
        mythes
      ];
    };

    Audio = pkgs.buildEnv {
      name = "audio";
      paths = [
        (callPackage ./packages/qprompt/default.nix { })
        ardour
        audacity
        pulseeffects-pw
        pulsemixer
        qjackctl
      ];
    };

    Design = pkgs.buildEnv {
      name = "design";
      paths = [ freecadStable kicad ];
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

    LaTeX = pkgs.buildEnv {
      name = "latex";
      paths = [ gummi texlive.combined.scheme-full texworks ];
    };

    JavaScript = pkgs.buildEnv {
      name = "javascript";
      paths = [
        unstable.deno
        nodejs
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
        (python39.withPackages (ps: with ps; [
          bandit
          black
          flake8
          mypy
          pyflakes
          pygments
          pylint
        ]))
      ];
    };

    PHP = pkgs.buildEnv {
      name = "php";
      paths = [
        (php.buildEnv {
          extensions = ({ enabled, all }: enabled ++ (with all; [ xdebug ]));
          extraConfig = ''
            xdebug.mode=develop,debug
            xdebug.start_with_request=yes
          '';
        })
        phpPackages.psysh
        phpPackages.psalm
        phpPackages.phpcbf
        phpPackages.phpstan
        phpPackages.composer
      ];
    };

    Lua = pkgs.buildEnv {
      name = "lua";
      paths = [
        (callPackage ./packages/redbean/default.nix {})
        lua
        luaPackages.luacheck
        luaformatter
      ];
    };

    Elixir = pkgs.buildEnv {
      name = "elixir";
      paths = [ elixir ];
    };

    HTML = pkgs.buildEnv {
      name = "html";
      paths = [
        html-tidy
        html-xml-utils
        libxml2
        libxslt
        xmlstarlet
      ];
    };

    Shell = pkgs.buildEnv {
      name = "shell";
      paths = [ dash fish bats shellcheck shfmt ];
    };

    Haskell = pkgs.buildEnv {
      name = "haskell";
      paths = [ ghc ghcid haskellPackages.hlint haskellPackages.brittany ];
    };

    Clojure = pkgs.buildEnv {
      name = "clojure";
      paths = [ clojure leiningen ];
    };

    Perl = pkgs.buildEnv {
      name = "perl";
      paths = [ rakudo (perl.withPackages (ps: with ps; [ PerlCritic PerlTidy TextLorem ])) ];
    };

    Nix = pkgs.buildEnv {
      name = "nix";
      paths = [ nix-index nix-linter nixfmt nixpkgs-fmt nixpkgs-lint ];
    };

    Ruby = pkgs.buildEnv {
      name = "ruby";
      paths = [ (callPackage ./packages/rufo/default.nix {}) rubocop ruby ];
    };

    C = pkgs.buildEnv {
      name = "c";
      paths = [ astyle clang-tools gcc gdb gnumake meson ninja ];
    };

    Golang = pkgs.buildEnv {
      name = "golang";
      paths = [ go gore ];
    };

    Rust = pkgs.buildEnv {
      name = "rust";
      paths = [ evcxr rustup ];
    };

    Nim = pkgs.buildEnv {
      name = "nim";
      paths = [ nim ];
    };

    CSS = pkgs.buildEnv {
      name = "css";
      paths = [
        (callPackage ./packages/csstidy/default.nix {})
        (callPackage ./packages/stylelint/default.nix {})
        csslint
        sassc
      ];
    };

    SQL = pkgs.buildEnv {
      name = "sql";
      paths = [
        (callPackage ./packages/skeema/default.nix {})
        (callPackage ./packages/sqldef/default.nix {})
        pgformatter
        sqlfluff
        sqlint
        sqlite
        sqlitebrowser
      ];
    };

    YAML = pkgs.buildEnv {
      name = "yaml";
      paths = [
        (callPackage ./packages/ruamel.yaml.cmd/default.nix {})
        (callPackage ./packages/yaml2nix/default.nix {})
        python39Packages.yamllint
        yj
      ];
    };

    Xorg-Aarch64 = pkgs.buildEnv {
      name = "xorg-aarch64";
      paths = [
        (callPackage ./packages/x11vnc/default.nix {})
        (callPackage ./packages/xprintidle/default.nix {})
        glxinfo
        unclutter-xfixes
        wmctrl
        xbindkeys
        xdotool
        xorg.xauth
        xorg.xev
        xorg.xf86inputevdev
        xorg.xf86inputlibinput
        xorg.xf86videofbdev
        xorg.xinit
        xorg.xinput
        xorg.xmodmap
        xorg.xorgserver
        xorg.xrandr
        xorg.xrdb
        xorg.xset
        xorg.xsetroot
        xsel
        xzoom
      ];
    };

    Xfce-Aarch64 = pkgs.buildEnv {
      name = "xfce-aarch64";
      paths = [
        bamf
        dunst
        polkit_gnome
        xfce.exo
        xfce.garcon
        xfce.libxfce4ui
        xfce.libxfce4util
        xfce.thunar
        xfce.thunar-archive-plugin
        xfce.thunar-volman
        xfce.xfce4-session
        xfce.xfce4-settings
        xfce.xfconf
        xfce.xfdesktop
        xfce.xfwm4
        xfce.xfwm4-themes
        zuki-themes
      ];
    };

    Graphical-Aarch64 = pkgs.buildEnv {
      name = "graphical-aarch64";
      paths = [
        unstable.firefox
        unstable.ungoogled-chromium
        audacity
        freerdp
        fsearch
        galculator
        gpicview
        pavucontrol
        pcmanfm
        sylpheed
        xsane
      ];
    };

    Terminal-Aarch64 = pkgs.buildEnv {
      name = "terminal-aarch64";
      paths = [
        alsaUtils
        fzf
        libnotify
        redshift
        rofi
        rxvt-unicode
        skippy-xd
        tigervnc
        vimHugeX
      ];
    };
  };
}
