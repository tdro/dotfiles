{
  allowUnfree = true;

  packageOverrides = pkgs: with pkgs; {

    terminal = pkgs.buildEnv {
      name = "terminal";
      paths = [
        htop
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
        vim
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
        ideviceinstaller
        iozone
        kjv
        pngquant
        pngnq
        imagemagick
        moc
        libqalculate
      ];
      pathsToLink = [ "/share" "/bin" ];
    };

    graphical = pkgs.buildEnv {
      name = "graphical";
      paths = [
        firefox
        palemoon
        chromium
        google-chrome
        thunderbird
        spaceFM
        skippy-xd
        peek
        scrcpy
        treesheets
        virt-manager
        mplayer
        texworks
        gummi
        treesheets
        vscode
        pavucontrol
        mupdf
        zathura
        gparted
        tigervnc
        flameshot
        copyq
        audacity
        blender
        redshift
        unclutter
        lxappearance
        xbindkeys
        syncthing
        gnome3.zenity
        qownnotes
        keepassxc
        krop
        xzoom
        libreoffice
        gcolor2
        libnotify
      ];
      pathsToLink = [ "/share" "/bin" ];
    };

    xserver = pkgs.buildEnv {
      name = "xserver";
      paths = [
        xorg.xev
        xorg.xset
        xorg.xrdb
        xorg.xinit
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
        x11vnc
        xdotool
        xzoom
        xbindkeys
        wmctrl
        rofi
        dmenu
      ];
    };

    awesome = pkgs.buildEnv {
      name = "awesome";
      paths = [
        awesome
      ];
      pathsToLink = [ "/share" "/bin" ];
    };

    fonts = pkgs.buildEnv {
      name = "fonts";
      paths = [
        corefonts
        font-awesome_4
        noto-fonts
        noto-fonts-cjk
        noto-fonts-emoji
      ];
    };

    themes = pkgs.buildEnv {
      name = "themes";
      paths = [
       gnome-themes-extra
       papirus-icon-theme
       adwaita-qt
       vanilla-dmz
       gtk3
      ];
    };

  };
}
