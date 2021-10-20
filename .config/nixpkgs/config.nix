let

  pkgs = import <nixpkgs> {};

  stable = import (builtins.fetchTarball {
    url = "https://releases.nixos.org/nixos/21.05/nixos-21.05.1510.a165aeceda9/nixexprs.tar.xz";
    sha256 = "124s05b0xk97arw0vvq8b4wcvsw6024dfdzwcx9qjxf3a2zszmam"; }) {};

  unstable = import (builtins.fetchTarball {
    url = "https://releases.nixos.org/nixos/unstable/nixos-21.11pre301985.23cd13167a1/nixexprs.tar.xz";
    sha256 = "0djd5zr9l2r6ahwhyasl1asrdjhbavdamkz8qzlkkb6j4z015zqd"; }) {};

in

{
  allowUnfree = true;

  packageOverrides = pkgs: with stable; {

    # Machines

    Woodpecker = pkgs.buildEnv {
      name = "woodpecker";
      paths = [
        Terminal Graphical Xorg Awesome Fonts Audio LaTeX Dictionary
        Android JavaScript Python PHP Lua Elixir HTML Shell Haskell
        Perl Nix C Golang Rust CSS SQL YAML Ruby Nim Themes
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

    # Package Sets

    Terminal = pkgs.buildEnv {
      name = "terminal";
      paths = [
        (callPackage ./packages/chromexup/default.nix {})
        (callPackage ./packages/gmni/default.nix {})
        (callPackage ./packages/literate/default.nix {})
        (callPackage ./packages/systemd2nix/default.nix {})
        (callPackage ./packages/tiemu/default.nix {})
        (callPackage ./packages/youtube-dl/default.nix {})
        (unstable.pass.withExtensions (ext: with ext; [ pass-import pass-audit pass-otp ]))
        unstable.amfora
        unstable.emacs
        unstable.fzf
        unstable.hugo
        aerc
        alsaUtils
        ansible
        bat
        bleachbit
        calcurse
        csvkit
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
        expect
        ffmpeg
        flashrom
        fortune
        gettext
        gifsicle
        git
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
        monolith
        neofetch
        netcat-openbsd
        newsboat
        nnn
        ocrmypdf
        pandoc
        picotts
        pipes
        pngnq
        pngquant
        poppler_utils
        ranger
        rclone
        ripgrep
        rxvt-unicode
        sbcl
        silver-searcher
        sshfs
        subversion
        surfraw
        tcl
        tmux
        trash-cli
        units
        vale
        vault
        vcal
        vimHugeX
        vnstat
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
        (callPackage ./packages/beaker-browser/default.nix {})
        (callPackage ./packages/boomer/default.nix {})
        (callPackage ./packages/dmenu/default.nix {})
        (callPackage ./packages/gnaural/default.nix {})
        (callPackage ./packages/ntrviewer/default.nix {})
        (callPackage ./packages/planner/default.nix {})
        (callPackage ./packages/sowon/default.nix {})
        (mplayer.override { v4lSupport = true; })
        unstable.claws-mail
        unstable.fsearch
        unstable.nyxt
        unstable.tilp2
        unstable.ungoogled-chromium
        aegisub
        anki
        blender
        code-server
        dconf
        diffpdf
        escrotum
        evince
        exiftool
        feh
        firefox
        flameshot
        freerdp
        gImageReader
        gimp
        gnome3.simple-scan
        google-chrome
        gparted
        i3lock-fancy
        kcharselect
        keepassxc
        krop
        libnotify
        libreoffice
        liferea
        mate.engrampa
        meld
        mupdf
        mypaint
        palemoon
        pavucontrol
        peek
        qownnotes
        qrencode
        quodlibet
        recoll
        redshift
        rofi
        scrcpy
        screenkey
        scribusUnstable
        sigil
        skippy-xd
        spaceFM
        sublime3
        sxiv
        syncthing
        tabula
        tigervnc
        transmission-gtk
        treesheets
        treesheets
        unclutter
        vimb
        virt-manager
        vscodium
        xournalpp
        xsane
        yad
        zathura
        zim
      ];
    };

    Xorg = pkgs.buildEnv {
      name = "xorg";
      paths = [
        (callPackage ./packages/x11vnc/default.nix {})
        (callPackage ./packages/xprintidle/default.nix {})
        autocutsel
        glxinfo
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
      paths = [
        awesome
        lxappearance
      ];
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
        xfce.tumbler
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
        papirus-icon-theme
        vanilla-dmz
        qt4
        librsvg
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
      paths = [ pulseeffects-pw pulsemixer audacity ardour qjackctl ];
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
      paths = [ gummi texworks texlive.combined.scheme-full ];
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
        (python39.withPackages (ps: with ps; [ bandit black mypy pylint pyflakes flake8 ]))
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
      paths = [ (callPackage ./packages/luaformatter/default.nix {}) lua5_3 lua53Packages.luacheck ];
    };

    Elixir = pkgs.buildEnv {
      name = "elixir";
      paths = [ elixir_1_10 ];
    };

    HTML = pkgs.buildEnv {
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
      paths = [ dash fish bats shellcheck shfmt ];
    };

    Haskell = pkgs.buildEnv {
      name = "haskell";
      paths = [ ghc ghcid haskellPackages.hlint haskellPackages.brittany ];
    };

    Perl = pkgs.buildEnv {
      name = "perl";
      paths = [ rakudo perl530 perl530Packages.PerlCritic perl530Packages.PerlTidy ];
    };

    Nix = pkgs.buildEnv {
      name = "nix";
      paths = [ nixos-generators nix-index nix-linter nixfmt nixpkgs-fmt nixpkgs-lint ];
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
      paths = [ go unstable.gore ];
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
      ];
    };

    SQL = pkgs.buildEnv {
      name = "sql";
      paths = [
        (callPackage ./packages/skeema/default.nix {})
        (callPackage ./packages/sqldef/default.nix {})
        (callPackage ./packages/sqlfluff/default.nix {})
        dbeaver
        pgformatter
        sqlint
        sqlite
      ];
    };

    YAML = pkgs.buildEnv {
      name = "yaml";
      paths = [
        (callPackage ./packages/ruamel.yaml.cmd/default.nix {})
        (callPackage ./packages/yaml2nix/default.nix {})
        python39Packages.yamllint
      ];
    };
  };
}
