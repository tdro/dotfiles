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

    latex = pkgs.buildEnv {
      name = "latex";
      paths = [
        gummi
        texworks
        texlive.combined.scheme-full
      ];
    };

  };
}
