let
  unstable = import (builtins.fetchTarball https://github.com/nixos/nixpkgs/tarball/master) {};
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
          p7zip
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
        ];
        pathsToLink = [ "/share" "/bin" ];
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
          lxappearance
          syncthing
          qownnotes
          keepassxc
          krop
          libreoffice
          gcolor2
          libnotify
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
          connman-gtk
          freerdp
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
          wmctrl
          rofi
          dmenu
          scrot
        ];
      };

      Awesome = pkgs.buildEnv {
        name = "awesome";
        paths = [
          awesome
        ];
        pathsToLink = [ "/share" "/bin" ];
      };

      Fonts = pkgs.buildEnv {
        name = "fonts";
        paths = [
          corefonts
          font-awesome_4
          noto-fonts
          noto-fonts-cjk
          noto-fonts-emoji
        ];
      };

      Themes = pkgs.buildEnv {
        name = "themes";
        paths = [
          gnome-themes-extra
          papirus-icon-theme
          adwaita-qt
          vanilla-dmz
          gtk3
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
          nodePackages.prettier
          nodePackages.eslint
        ];
        pathsToLink = [ "/bin" ];
      };


    };
  }
