#!/bin/bash

# auto login
[ -z "$DISPLAY" ] && [ "$(tty)" = '/dev/tty1' ] && exec startx >/dev/null 2>&1;

# general exports
export EDITOR=vim
export TERMINAL=urxvt
export PROMPT_COMMAND="cd .; history -a"
export HISTSIZE=
export HISTFILESIZE=
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
