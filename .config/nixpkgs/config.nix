let

  stable = import (builtins.fetchTarball {
    url= "https://github.com/NixOS/nixpkgs/archive/f8248ab6d9e69ea9c07950d73d48807ec595e923.tar.gz";
    sha256 = "009i9j6mbq6i481088jllblgdnci105b2q4mscprdawg3knlyahk"; }) {};

  unstable = import (builtins.fetchTarball {
    url= "https://github.com/NixOS/nixpkgs/archive/c308da1c4b14b0ffdfe9c2e2a948320124938220.tar.gz";
    sha256 = "0ab9jhnlscxl1fl9rc7l978n26al1n77w32sr8gdbb11pfnhsizp"; }) {};

in

  {
    allowUnfree = true;

    packageOverrides = pkgs: with stable; {

      Terminal = pkgs.buildEnv {
        name = "terminal";
        paths = [
          unstable.fzf
          unstable.hugo
          tcl
          sbcl
          nix-linter
          sshfs
          ffmpeg
          ripgrep
          dtrx
          rxvt-unicode
          pulsemixer
          entr
          keychain
          nnn
          ranger
          aerc
          vimHugeX
          emacs
          alsaUtils
          diceware
          bfg-repo-cleaner
          html-tidy
          davmail
          dive
          exercism
          mimeo
          xdg-user-dirs
          ideviceinstaller
          kjv
          pngquant
          pngnq
          imagemagick
          moc
          libqalculate
          encfs
          bleachbit
          docker-compose
          electrum
          fortune
          ansible_2_9
          gifsicle
          img2pdf
          powertop
          rclone
          wavemon
          weechat
          w3m
          lynx
          youtube-dl
          groff
          ocrmypdf
          vault
          neofetch
          surfraw
          libxml2
          html-xml-utils
          hunspell
          hunspellDicts.en-us-large
        ];
        pathsToLink = [ "/etc" "/share" "/bin" ];
      };

      Graphical = pkgs.buildEnv {
        name = "graphical";
        paths = [
          (callPackage ./packages/ntrviewer/default.nix {})
          unstable.ungoogled-chromium
          firefox
          palemoon
          google-chrome
          thunderbird
          spaceFM
          skippy-xd
          peek
          scrcpy
          treesheets
          virt-manager
          mplayer
          gnome3.zenity
          gnome3.simple-scan
          mate.engrampa
          treesheets
          vscode
          pavucontrol
          mupdf
          zathura
          evince
          gparted
          tigervnc
          flameshot
          copyq
          audacity
          blender
          redshift
          unclutter
          syncthing
          qownnotes
          keepassxc
          krop
          libreoffice
          gcolor2
          feh
          aegisub
          scribus
          meld
          gimp
          gImageReader
          i3lock-fancy
          recoll
          sigil
          sublime3-dev
          tabula
          xournalpp
          zim
          sqlitebrowser
          qrencode
          xsane
          freerdp
          wmctrl
          rofi
          dmenu
          escrotum
          libnotify
          screenkey
        ];
        pathsToLink = [ "/share" "/bin" ];
      };

      Xorg = pkgs.buildEnv {
        name = "xorg";
        paths = [
          xorg.xev
          xorg.xset
          xorg.xrdb
          xorg.xinit
          xorg.xinput
          xorg.xauth
          xorg.xrandr
          xorg.xmodmap
          xorg.xsetroot
          xorg.xorgserver
          xorg.xf86videonouveau
          xorg.xf86videointel
          xorg.xf86videoati
          xorg.xf86videoamdgpu
          xorg.xf86inputlibinput
          xorg.xf86inputevdev
          xorg.xf86inputsynaptics
          x11vnc
          xdotool
          xzoom
          xbindkeys
          glxinfo
        ];
      };

      Awesome = pkgs.buildEnv {
        name = "awesome";
        paths = [
          awesome
          lxappearance
          deepin.deepin-gtk-theme
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
          corefonts
          font-awesome_4
          noto-fonts
          noto-fonts-cjk
          noto-fonts-emoji
          etBook
          ibm-plex
          cooper-hewitt
          fira
          fira-code
          fira-code-symbols
          fira-mono
          source-serif-pro
          source-code-pro
          yanone-kaffeesatz
          cm_unicode
        ];
      };

      Audio = pkgs.buildEnv {
        name = "audio";
        paths = [
          ardour
          cadence
          qjackctl
          jack2
        ];
      };

      LaTeX = pkgs.buildEnv {
        name = "latex";
        paths = [
          gummi
          texworks
          texlive.combined.scheme-full
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
          (python38.withPackages (ps: with ps; [
            mypy
            bandit
            pylint
            pip2nix
            pyflakes
          ]))
        ];
      };

      Golang = pkgs.buildEnv {
        name = "golang";
        paths = [
          go
          unstable.gore
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
        paths = [
          elixir
        ];
      };

      Bash = pkgs.buildEnv {
        name = "bash";
        paths = [
          bats
          shellcheck
        ];
      };

      C = pkgs.buildEnv {
        name = "c";
        paths = [
          gnumake
          meson
          ninja
          gcc
        ];
      };
    };
  }
