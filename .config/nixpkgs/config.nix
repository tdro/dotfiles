let

  stable = import (builtins.fetchTarball {
    url = "https://releases.nixos.org/nixos/21.05/nixos-21.05.650.eaba7870ffc/nixexprs.tar.xz";
    sha256 = "08fpds1bkv9106c6s5w3p5r4v3dc24bhk9asm9vqbxxypjglqg9l"; }) {};

  unstable = import (builtins.fetchTarball {
    url = "https://releases.nixos.org/nixos/unstable/nixos-21.11pre292748.6933d068c5d/nixexprs.tar.xz";
    sha256 = "1bwwrij68m0jb7vq5vzjnas3c5ylq5lj6fvwklyzawhkarq4hv1k"; }) {};

in

{
  allowUnfree = true;

  packageOverrides = pkgs: with stable; {

    # Machines

    Woodpecker = pkgs.buildEnv {
      name = "woodpecker";
      paths = [
        Terminal Graphical Xorg Awesome Fonts Audio LaTeX
        Android JavaScript Python PHP Lua Elixir HTML Shell Haskell
        Perl Nix C Golang Rust CSS SQL YAML Ruby
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
      paths = [ Terminal Graphical Fonts Xorg Awesome Audio ];
    };

    Tiger = pkgs.buildEnv {
      name = "tiger";
      paths = [ Nix Terminal Graphical Fonts Xorg Awesome JavaScript Python ];
    };

    Hound = pkgs.buildEnv {
      name = "hound";
      paths = [ Terminal Graphical Fonts Xorg Xfce JavaScript Python ];
    };

    # Package Sets

    Terminal = pkgs.buildEnv {
      name = "terminal";
      paths = [
        (callPackage ./packages/chromexup/default.nix {})
        (callPackage ./packages/gmni/default.nix {})
        (callPackage ./packages/literate/default.nix {})
        (callPackage ./packages/systemd2nix/default.nix {})
        (callPackage ./packages/youtube-dl/default.nix {})
        (pass.withExtensions (ext: with ext; [ (callPackage ./packages/pass-import/default.nix {}) pass-audit pass-otp ]))
        unstable.amfora
        unstable.emacs
        unstable.fzf
        unstable.hugo
        aerc
        alsaUtils
        ansible
        bat
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
        subversion
        surfraw
        tcl
        tmux
        trash-cli
        units
        vale
        vault
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
        unstable.nyxt
        unstable.tilp2
        unstable.ungoogled-chromium
        aegisub
        anki
        audacity
        blender
        code-server
        copyq
        dconf
        diffpdf
        escrotum
        evince
        feh
        firefox
        flameshot
        freerdp
        gImageReader
        gimp
        gnome3.simple-scan
        gnome3.zenity
        google-chrome
        gparted
        i3lock-fancy
        kcharselect
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
        qownnotes
        qrencode
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
        thunderbird
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
        zathura
        zim
      ];
      pathsToLink = [ "/share" "/bin" ];
    };

    Xorg = pkgs.buildEnv {
      name = "xorg";
      paths = [
        (callPackage ./packages/x11vnc/default.nix {})
        (callPackage ./packages/xprintidle/default.nix {})
        glxinfo
        tdrop
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

    Design = pkgs.buildEnv {
      name = "design";
      paths = [ freecadStable kicad ];
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
        (python38.withPackages (ps: with ps; [ bandit black mypy pyflakes pylint ]))
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
      paths = [ bats dash shellcheck shfmt ];
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
      paths = [
        (callPackage ./packages/rufo/default.nix {})
        rubocop
        ruby
      ];
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
        python38Packages.yamllint
      ];
    };
  };
}
