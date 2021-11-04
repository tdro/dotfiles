#!/bin/bash -eu
# shellcheck disable=SC2016

prefixPath() {
  case ":$PATH:" in
    *":$1:"*) true ;;
    *) PATH="$1:$PATH" ;;
  esac
  export PATH;
}

# path exports
prefixPath "$HOME/.local/bin";
prefixPath "$HOME/.local/bin/scripts";

# auto login
[ "$EUID" != 0 ] && [ -z "$DISPLAY" ] && [ "$(tty)" = '/dev/tty1' ] \
  && command -v nix && "$HOME"/.local/bin/scripts/nix-xorg-conf > "$HOME"/.config/X11/xorg.conf.d/00-modules.conf \
  && exec sx;

# set umask
umask 0022;

# set prompt
PS1_USER='$(E=$? && [ "$E" = 0 ] || echo "$E ")\[\e[0;34m\]\W\[\e[0m\] \[\e[0;34m\]\$\[\e[0m\] '
PS1_ROOT='$(E=$? && [ "$E" = 0 ] || echo "$E ")\[\e[0;31m\]\W\[\e[0m\] \[\e[0;31m\]\$\[\e[0m\] '
PS1_SSHD='$(E=$? && [ "$E" = 0 ] || echo "$E ")\[\e[0;32m\]\W\[\e[0m\] \[\e[0;32m\]\$\[\e[0m\] '

# export prompt
[ "$EUID" != 0 ] && export PS1="$PS1_USER";
[ "$EUID" = 0 ] && export PS1="$PS1_ROOT";

# ssh set prompt
[ -n "$SSH_CLIENT" ] && [ "$EUID" != 0 ] && export PS1="$PS1_SSHD";

# xdg exports
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"

# general exports
export BROWSER=browser;
export CARGO_HOME="$XDG_CACHE_HOME/cargo"
export DOWNLOAD_KEYSERVER="hkp://keyserver.ubuntu.com"
export EDITOR=vim
export FZF_DIRECTORY_MARKS=$XDG_CONFIG_HOME/fzf/marks/directories
export FZF_FILE_MARKS=$XDG_CONFIG_HOME/fzf/marks/files
export GNUPGHOME="$XDG_DATA_HOME/gnupg"
export GOPATH="$XDG_DATA_HOME/go"
export HISTCONTROL=ignoreboth:erasedups
export HISTFILESIZE=
export HISTSIZE=
export HISTTIMEFORMAT="%d/%m/%y %T "
export ICEAUTHORITY="$XDG_CACHE_HOME/ICEauthority"
export INPUTRC="$XDG_CONFIG_HOME/inputrc"
export LESSHISTFILE="$XDG_CACHE_HOME/less.history"
export MANPAGER="vim -M +MANPAGER -"
export MPLAYER_HOME="$XDG_CONFIG_HOME/mplayer"
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npmrc"
export PASSWORD_STORE_DIR="$XDG_CONFIG_HOME/pass"
export PROMPT_COMMAND='cd .; history -a; history -n;'
export PYTHONSTARTUP="$XDG_CONFIG_HOME/python/pythonrc"
export RECOLL_CONFDIR="$XDG_CONFIG_HOME/recoll"
export RUSTUP_HOME="$XDG_DATA_HOME/rustup"
export TERMINAL=urxvt
export WEECHAT_HOME="$XDG_CONFIG_HOME/weechat"

# themes
export DESKTOP_SESSION=gnome
export XDG_CURRENT_DESKTOP=gnome
export GTK2_RC_FILES="$HOME/.gtkrc-2.0"

command -v rsvg-convert > /dev/null 2>&1 && \
  GDK_PIXBUF_MODULE_FILE=$(printf "%s" "$HOME"/.nix-profile/lib/gdk-pixbuf*/*/loaders.cache) && \
  export GDK_PIXBUF_MODULE_FILE

# fzf settings
export FZF_DEFAULT_OPTS="--color=fg:255,hl:203 \
 --color=fg+:81,bg+:237,hl+:203 \
 --color=info:188,prompt:69,pointer:199 \
 --color=marker:109,spinner:236,header:255"

# source bashrc
[ -z "$BASH_PROFILE" ] && . "$HOME/.bashrc"
