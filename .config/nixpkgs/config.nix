let

  pkgs = import <nixpkgs> { };

  system = builtins.currentSystem;

  previous = import (builtins.fetchTarball {
    url = "https://releases.nixos.org/nixos/22.11/nixos-22.11.466.596a8e828c5/nixexprs.tar.xz";
    sha256 = "1367bad5zz0mfm4czb6p0s0ni38f0x1ffh02z76rx4nranipqbgg"; }) { inherit system; };

  stable = import (builtins.fetchTarball {
    url = "https://releases.nixos.org/nixos/23.11/nixos-23.11.6510.a5e4bbcb4780/nixexprs.tar.xz";
    sha256 = "0f73pbh4j89wgk7rn9xp0q8ybw15zkhw0prjz5r37aaryjs8hnbd"; }) { inherit system; };

  unstable = import (builtins.fetchTarball {
    url = "https://releases.nixos.org/nixos/unstable/nixos-24.11pre690827.5633bcff0c61/nixexprs.tar.xz";
    sha256 = "09vghfcvmics34y6n2m7adn41y423i40ir4y63bq8jn7i5g70fwy"; }) { inherit system; };

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
        Terminal Graphical Xorg Wayland Awesome Fonts Audio LaTeX Dictionary Android
        JavaScript Python PHP Lua Elixir HTML Shell Haskell Perl Nix C Golang Rust CSS
        SQL YAML HTTP Ruby Nim Themes Emulators Clojure Lisp
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
        (callPackage ./packages/chromexup/package.nix { })
        (callPackage ./packages/emacs-batch-indent/package.nix { })
        (callPackage ./packages/pdf2htmlex/package.nix { })
        (callPackage ./packages/systemd2nix/package.nix { })
        (callPackage ./packages/w3m/package.nix { })
        (pass.withExtensions (ext: with ext; [ pass-import pass-audit pass-otp ]))
        unstable.emacs
        unstable.hugo
        unstable.ios-webkit-debug-proxy
        unstable.libimobiledevice
        unstable.piper-tts
        unstable.validator-nu
        unstable.vimHugeX
        unstable.yt-dlp
        aerc
        alacritty
        alsaUtils
        amfora
        ansi2html
        ansible
        atftp
        atool
        bat
        bind
        bleachbit
        cava
        cloc
        csvkit
        curlftpfs
        davmail
        desktop-file-utils
        diceware
        dive
        docker-compose
        dtrx
        electrum
        encfs
        entr
        expect
        fdupes
        ffmpeg-full
        flashrom
        fortune
        fzf
        gettext
        gifsicle
        git
        groff
        hexedit
        hexyl
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
        nethogs
        newsboat
        nnn
        nodePackages.mermaid-cli
        ocrmypdf
        pandoc
        pdsh
        pipes
        plantuml
        pngnq
        pngquant
        poppler_utils
        pssh
        quickemu
        ranger
        rclone
        ripgrep
        rxvt-unicode
        s-tui
        sfeed
        silver-searcher
        sshfs
        subversion
        surfraw
        tcl
        tesseract
        tmux
        toipe
        trash-cli
        units
        vale
        vcal
        ventoy-bin
        vnstat
        wavemon
        weechat
        woof
        xdg-user-dirs
        xterm
        zbar
      ];
      pathsToLink = [ "/etc" "/share" "/bin" ];
    };

    Graphical = pkgs.buildEnv {
      name = "graphical";
      paths = [
        (callPackage ./packages/boomer/package.nix { })
        (callPackage ./packages/dmenu/package.nix { })
        (callPackage ./packages/rofi/package.nix { })
        (callPackage ./packages/sowon/package.nix { })
        (mplayer.override { v4lSupport = true; })
        previous.code-server
        previous.qownnotes
        previous.recoll
        unstable.scrcpy
        unstable.firefox
        unstable.google-chrome
        unstable.ungoogled-chromium
        aegisub
        anki
        blender
        claws-mail
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
        gnaural
        gparted
        gromit-mpx
        gst_all_1.gst-plugins-base
        gst_all_1.gst-plugins-good
        gst_all_1.gstreamer
        i3lock-fancy
        kcharselect
        keepassxc
        krop
        libnotify
        libreoffice
        liferea
        mate.engrampa
        meld
        mupdf_1_17
        mypaint
        opensnitch-ui
        pavucontrol
        peek
        qrencode
        redshift
        screenkey
        sent
        sigil
        skippy-xd
        spaceFM
        stalonetray
        sublime3
        sxiv
        syncthing
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
        (callPackage ./packages/ntrviewer/package.nix { })
        (callPackage ./packages/tiemu/package.nix { })
        desmume
        mgba
      ];
    };

    Xorg = pkgs.buildEnv {
      name = "xorg";
      paths = [
        previous.x11vnc
        autocutsel
        glxinfo
        unclutter-xfixes
        wmctrl
        xbindkeys
        xdotool
        xorg.libxcvt
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
        xprintidle
        xsel
        xzoom
      ];
    };

    Wayland = pkgs.buildEnv {
      name = "wayland";
      paths = [
        (callPackage ./packages/wf-shell/package.nix { })
        wayfire
        weston
        wev
        wofi
      ];
    };

    Awesome = pkgs.buildEnv {
      name = "awesome";
      paths = [ (callPackage ./packages/awesome/package.nix { }) ];
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
        (callPackage ./packages/nerdfonts-dejavu-sans-mono/package.nix { })
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
        inter
        noto-fonts
        noto-fonts-cjk
        noto-fonts-emoji
        source-code-pro
        source-sans-pro
        source-serif-pro
        yanone-kaffeesatz
      ];
    };

    Themes = pkgs.buildEnv {
      name = "themes";
      paths = [
        glib
        gnome.dconf-editor
        gnome.gnome-themes-extra
        gtk-engine-murrine
        gtk3.dev
        librsvg
        lxappearance
        papirus-icon-theme
        qt5ct
        unstable.nwg-look
        vanilla-dmz
      ];
    };

    Dictionary = pkgs.buildEnv {
      name = "dictionary";
      paths = [
        (aspellWithDicts (dictionary: [
          dictionary.en
          dictionary.en-computers
          dictionary.en-science
        ]))
        hunspell
        hunspellDicts.en_US-large
        hyphen
        mythes
      ];
    };

    Audio = pkgs.buildEnv {
      name = "audio";
      paths = [
        (callPackage ./packages/qprompt/package.nix { })
        ardour
        pulsemixer
        qjackctl
        tenacity
      ];
    };

    Design = pkgs.buildEnv {
      name = "design";
      paths = [ kicad freecadStable openscad librecad ];
    };

    Graphs = pkgs.buildEnv {
      name = "graphs";
      paths = [ R gnuplot julia ];
    };

    Android = pkgs.buildEnv {
      name = "android";
      paths = [
        (callPackage ./packages/mkbootfs/package.nix { })
        (callPackage ./packages/mkbootimg/package.nix { })
        edl
        abootimg
      ];
    };

    LaTeX = pkgs.buildEnv {
      name = "latex";
      paths = [ gummi texlive.combined.scheme-full previous.texworks ];
    };

    JavaScript = pkgs.buildEnv {
      name = "javascript";
      paths = [
        unstable.deno
        unstable.swc
        esbuild
        nodePackages.eslint
        nodePackages.jsonlint
        nodePackages.prettier
        nodejs
      ];
      pathsToLink = [ "/bin" ];
    };

    Python = pkgs.buildEnv {
      name = "python";
      paths = [
        (python3.withPackages (ps: with ps; [
          bandit
          black
          flake8
          mypy
          pyflakes
          pygments
          pylint
        ]))
        ruff
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
        (callPackage ./packages/phar-composer/package.nix { })
        graphviz
        kcachegrind
        phpPackages.composer
        phpPackages.phpcbf
        phpPackages.phpstan
        phpPackages.psalm
        phpPackages.psysh
      ];
    };

    Lua = pkgs.buildEnv {
      name = "lua";
      paths = [
        (callPackage ./packages/redbean/package.nix { })
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
      paths = [ ghc ghcid haskellPackages.hlint previous.haskellPackages.brittany ];
    };

    Clojure = pkgs.buildEnv {
      name = "clojure";
      paths = [ clojure leiningen ];
    };

    Perl = pkgs.buildEnv {
      name = "perl";
      paths = [ rakudo (perl.withPackages (ps: with ps; [ PerlCritic PerlTidy TextLorem LaTeXML ])) ];
    };

    Nix = pkgs.buildEnv {
      name = "nix";
      paths = [ nix-index previous.nix-linter nixfmt nixpkgs-fmt nixpkgs-lint ];
    };

    Ruby = pkgs.buildEnv {
      name = "ruby";
      paths = [ rubocop ruby ];
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

    Lisp = pkgs.buildEnv {
      name = "lisp";
      paths = [
        (pkgs.writeScriptBin "guile" ''
          export GUILE_LOAD_PATH="${pkgs.lib.concatStrings [
            "${unstable.guile-gnutls}/share/guile/site/3.0:"
            "$GUILE_LOAD_PATH"
          ]}"
          ${unstable.guile_3_0}/bin/guile "$@"
        '')
        sbcl
      ];
    };

    HTTP = pkgs.buildEnv {
      name = "http";
      paths = [ caddy apacheHttpd httpie ];
    };

    CSS = pkgs.buildEnv {
      name = "css";
      paths = [
        (previous.callPackage ./packages/csstidy/package.nix { })
        nodePackages.stylelint
        csslint
        sassc
      ];
    };

    SQL = pkgs.buildEnv {
      name = "sql";
      paths = [
        pgformatter
        skeema
        sqlfluff
        sqlint
        sqlite-interactive
        sqlitebrowser
        unstable.sqldef
      ];
    };

    YAML = pkgs.buildEnv {
      name = "yaml";
      paths = [
        (previous.callPackage ./packages/yaml2nix/package.nix { })
        (callPackage ./packages/ruamel.yaml.cmd/package.nix { })
        python39Packages.yamllint
        yj
      ];
    };

    Xorg-Aarch64 = pkgs.buildEnv {
      name = "xorg-aarch64";
      paths = [
        glxinfo
        unclutter-xfixes
        wmctrl
        x11vnc
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
        xprintidle
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
        unstable.vimHugeX
        alsaUtils
        fzf
        libnotify
        redshift
        rofi
        rxvt-unicode
        skippy-xd
        tigervnc
      ];
    };
  };
}
