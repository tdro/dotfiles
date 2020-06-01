let
  unstable = import (builtins.fetchTarball https://github.com/NixOS/nixpkgs/archive/master.tar.gz) {};
in
  {
    allowUnfree = true;

    packageOverrides = pkgs: with pkgs; {

      Terminal = pkgs.buildEnv {
        name = "terminal";
        paths = [
          htop
          psmisc
          sshfs
          fzf
          nmap
          ffmpeg
          nixops
          git
          ripgrep
          rxvt-unicode
          pulsemixer
          entr
          rsync
          keychain
          nnn
          ranger
          aerc
          unrar
          hdparm
          ncdu
          ldns
          vimHugeX
          emacs
          alsaUtils
          iperf2
          diceware
          mimeo
          bfg-repo-cleaner
          html-tidy
          davmail
          dive
          drone-cli
          exercism
          xdg_utils
          ideviceinstaller
          iozone
          iotop
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
          hugo
          img2pdf
          powertop
          rclone
          smem
          udevil
          wavemon
          weechat
          w3m
          wget
          curl
          wol
          youtube-dl
          groff
          gnupg
          ocrmypdf
          file
          p7zip
          unzip
          vault
          neofetch
          surfraw
          libxml2
          html-xml-utils
        ];
        pathsToLink = [ "/etc" "/share" "/bin" ];
      };

      Graphical = pkgs.buildEnv {
        name = "graphical";
        paths = [
          firefox
          palemoon
          unstable.ungoogled-chromium
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
          ardour
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
          (callPackage ./packages/ntrviewer/default.nix {})
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
        ];
      };

      Lua = pkgs.buildEnv {
        name = "lua";
        paths = [
          lua5_3
          (callPackage ./packages/luaformatter/default.nix {})
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
