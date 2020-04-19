#!/bin/bash

# auto login
[ "$EUID" != 0 ] && [ -z "$DISPLAY" ] && [ "$(tty)" = '/dev/tty1' ] && exec startx >/dev/null 2>&1;

# set prompt
PS1_USER='\[\e[38;5;250m\]$(date +%T)\[\e[0m\] \[\e[0;34m\]\W\[\e[0m\] \[\e[0;34m\]\$\[\e[0m\] '
PS1_ROOT='\[\e[38;5;250m\]$(date +%T)\[\e[0m\] \[\e[0;31m\]\W\[\e[0m\] \[\e[0;31m\]\$\[\e[0m\] '
PS1_SSHD='\[\e[38;5;250m\]$(date +%T)\[\e[0m\] \[\e[0;32m\]\W\[\e[0m\] \[\e[0;32m\]\$\[\e[0m\] '

[ "$EUID" != 0 ] && export PS1="$PS1_USER";
[ "$EUID" = 0 ] && export PS1="$PS1_ROOT";

# ssh set prompt
[ -n "$SSH_CLIENT" ] && [ "$EUID" -ne 0 ] && export PS1="$PS1_SSHD";

# path exports
export PATH="$PATH:$HOME/.config/composer/vendor/bin"
export PATH="$PATH:$HOME/.node_modules/node_modules/.bin"
export PATH="$PATH:$HOME/.local/bin"

# general exports
export EDITOR=vim
export TERMINAL=urxvt
export PROMPT_COMMAND='cd .; history -a'
export HISTSIZE=
export HISTFILESIZE=
export HISTTIMEFORMAT="%d/%m/%y %T "
export HISTCONTROL=ignoredups:erasedups
export LESSHISTFILE=$HOME/.cache/less.history
export SUDO_ASKPASS=$HOME/.local/bin/rofi-askpass

# fzf settings
export FZF_DEFAULT_OPTS="--color=fg:255,hl:9 \
 --color=fg+:81,bg+:237,hl+:9 \
 --color=info:188,prompt:69,pointer:199 \
 --color=marker:109,spinner:236,header:255"

# source frequently changed files
. /etc/profile.d/theme.sh

# source bashrc
[ -z "$BASH_PROFILE" ] && . "$HOME/.bashrc"
