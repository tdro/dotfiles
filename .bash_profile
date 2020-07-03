#!/bin/bash

# set xauthority path
export XAUTHORITY=$HOME/.config/X11/Xauthority;

# auto login
[ "$EUID" != 0 ] && [ -z "$DISPLAY" ] && [ "$(tty)" = '/dev/tty1' ] \
  && command -v nix && "$HOME"/.local/bin/scripts/nix-xorg-conf > "$HOME"/.config/X11/xorg.conf.d/00-modules.conf \
  && exec xinit "$HOME/.config/X11/xinitrc" -- :0 \
  -configdir "$HOME/.config/X11/xorg.conf.d" \
  -logfile "$HOME/.cache/xorg.log" vt1 -keeptty -auth "$XAUTHORITY";

# set prompt
PS1_USER='$(E=$? && [ "$E" = 0 ] || echo "$E ")\[\e[0;34m\]\W\[\e[0m\] \[\e[0;34m\]\$\[\e[0m\] '
PS1_ROOT='$(E=$? && [ "$E" = 0 ] || echo "$E ")\[\e[0;31m\]\W\[\e[0m\] \[\e[0;31m\]\$\[\e[0m\] '
PS1_SSHD='$(E=$? && [ "$E" = 0 ] || echo "$E ")\[\e[0;32m\]\W\[\e[0m\] \[\e[0;32m\]\$\[\e[0m\] '

# export prompt
[ "$EUID" != 0 ] && export PS1="$PS1_USER";
[ "$EUID" = 0 ] && export PS1="$PS1_ROOT";

# ssh set prompt
[ -n "$SSH_CLIENT" ] && [ "$EUID" != 0 ] && export PS1="$PS1_SSHD";

# path exports
export PATH="$HOME/.local/bin:$PATH"

# general exports
export EDITOR=vim
export TERMINAL=urxvt
export PROMPT_COMMAND='cd .; history -a'
export HISTSIZE=
export HISTFILESIZE=
export HISTTIMEFORMAT="%d/%m/%y %T "
export HISTCONTROL=ignoredups:erasedups

export SUDO_ASKPASS="$HOME/.local/bin/rofi-askpass"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"
export LESSHISTFILE="$XDG_CACHE_HOME/less.history"
export INPUTRC="$XDG_CONFIG_HOME/inputrc"
export ICEAUTHORITY="$XDG_CACHE_HOME/ICEauthority"
export WEECHAT_HOME="$XDG_CONFIG_HOME/weechat"
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npmrc"

# themes
export DESKTOP_SESSION=gnome
export XDG_CURRENT_DESKTOP=gnome
export GTK2_RC_FILES="$HOME/.gtkrc-2.0"
export QT_STYLE_OVERRIDE=adwaita

# specific themes
[ "$(cat /etc/hostname)" = "tiger" ] && export QT_STYLE_OVERRIDE=adwaita-dark
[ "$(cat /etc/hostname)" = "talon" ] && export QT_STYLE_OVERRIDE=adwaita-dark

# fzf settings
export FZF_DEFAULT_OPTS="--color=fg:255,hl:203 \
 --color=fg+:81,bg+:0,hl+:203 \
 --color=info:188,prompt:69,pointer:199 \
 --color=marker:109,spinner:236,header:255"

# source bashrc
[ -z "$BASH_PROFILE" ] && . "$HOME/.bashrc"
