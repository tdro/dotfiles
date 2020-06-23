let
  unstable = import (builtins.fetchTarball {
    url= "https://github.com/NixOS/nixpkgs/archive/0e2444aacb02b8c12416b71febca5cea416405f0.tar.gz";
    sha256 = "18lki60qb77h8akbzpzyang08i5iqppqz65msm7gmdhrky7f3i07"; }) {};
in
  {
    allowUnfree = true;

    packageOverrides = pkgs: with pkgs; {

      Terminal = pkgs.buildEnv {
        name = "terminal";
        paths = [
          unstable.fzf
          unstable.hugo
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
          sbcl_2_0_1
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
          bats
          bleachbit
          docker-compose
          electrum
          fortune
          ansible_2_9
          gifsicle
          shellcheck
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

      LaTeX = pkgs.buildEnv {
        name = "latex";
        paths = [
          gummi
          texworks
          texlive.combined.scheme-full
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

      JavaScript = pkgs.buildEnv {
        name = "javascript";
        paths = [
          nodejs-13_x
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
            pip2nix
          ]))
        ];
      };

      Golang = pkgs.buildEnv {
        name = "golang";
        paths = [
          go
        ];
      };

      PHP = pkgs.buildEnv {
        name = "php";
        paths = [
          php74
          php74Packages.composer
          php74Packages.phpcbf
        ];
      };

      Lua = pkgs.buildEnv {
        name = "lua";
        paths = [
          (callPackage ./packages/luaformatter/default.nix {})
          lua5_3
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
