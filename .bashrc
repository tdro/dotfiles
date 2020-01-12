#!/bin/bash

# bail if not interactive
[[ $- != *i* ]] && return

# set prompt
[[ "$EUID" -ne 0 ]] && PS1='\[\e[0;34m\]\W \$\[\e[0m\] '
[[ "$EUID" -eq 0 ]] && PS1='\[\e[1;31m\]\W \$\[\e[0m\] '

# cd using directory name
shopt -s autocd;

# append bash history entries
shopt -s histappend;

# bash history one command per line
shopt -s cmdhist;

# disable ctrl+s
stty stop '';
stty start '';
stty -ixon;
stty -ixoff;

# set virtual console colors
if [ "$TERM" = "linux" ]; then
  echo -en "\e]P0111111" #black [background]
  echo -en "\e]P1D84F4F" #darkred
  echo -en "\e]P2DEFF3E" #darkgreen
  echo -en "\e]P3FFDF23" #brown
  echo -en "\e]P479AEFF" #darkblue
  echo -en "\e]P58894CF" #darkmagenta
  echo -en "\e]P679AEFF" #darkcyan
  echo -en "\e]P7dddddd" #lightgray
  echo -en "\e]P8DDDDDD" #darkgray
  echo -en "\e]P9E84F4F" #red
  echo -en "\e]PABEFF3E" #green
  echo -en "\e]PBFEA63C" #yellow
  echo -en "\e]PC69AEFF" #blue
  echo -en "\e]PD9894CF" #magenta
  echo -en "\e]PE69AEFF" #cyan
  echo -en "\e]PFffffff" #white [foreground]
  clear #for background artifacting
fi

# color man
man() {
  env LESS_TERMCAP_mb="$(printf "\e[1;31m")" \
  LESS_TERMCAP_md="$(printf "\e[1;31m")" \
  LESS_TERMCAP_me="$(printf "\e[0m")" \
  LESS_TERMCAP_se="$(printf "\e[0m")" \
  LESS_TERMCAP_so="$(printf "\e[1;44;33m")" \
  LESS_TERMCAP_ue="$(printf "\e[0m")" \
  LESS_TERMCAP_us="$(printf "\e[1;32m")" \
  man "$@"
}

# ssh bash prompt color change
if [ -n "$SSH_CLIENT" ]; then
  export PS1='\[\e[1;32m\]\W \$\[\e[0m\] '
fi

# disable less history
export LESSHISTFILE=-

# bash history settings
export HISTSIZE=
export HISTFILESIZE=
export HISTCONTROL=ignoredups:erasedups

# prompt command runs on every command
export PROMPT_COMMAND="cd .; history -a"

# ssh agent with keychain
alias ssh='eval $(/usr/bin/keychain --eval --agents ssh -Q --quiet ~/.ssh/mobile ~/.ssh/primary) && ssh'

# colorize the ls output
alias ls='ls --color=always'

# lsblk
alias lsblk='lsblk -o NAME,MAJ:MIN,RM,SIZE,FSTYPE,RO,TYPE,MOUNTPOINT,MODEL'

# do not delete / or prompt if deleting more than 3 files
alias rm='rm -I --preserve-root'

# confirmation
alias mv='mv -i'
alias cp='cp -i'
alias ln='ln -i'

# parenting changing perms on /
alias chown='chown --preserve-root'
alias chmod='chmod --preserve-root'
alias chgrp='chgrp --preserve-root'

# locate replaced with locate -e
alias locate='locate -ie'

# reboot / halt / poweroff which are symlink'd to systemd
alias reboot='sudo /sbin/reboot'
alias poweroff='sudo /sbin/poweroff'
alias halt='sudo /sbin/halt'
alias shutdown='sudo /sbin/shutdown'

# journalctl
alias journalctl='sudo journalctl -q'

# wavemon
alias wavemon='sudo wavemon'

# pacman
alias pacman='sudo pacman'

# color grep
alias grep='grep --color=tty -d skip'

# alsamixer
alias alsamixer='alsamixer -V all'

# fzf listed history
alias fuzzy-history='cat $HOME/.bash_history | fzf'

# pulse delay on audacity
alias audacity='PULSE_LATENCY_MSEC=30 audacity'

# dmesg
alias dmesg='dmesg -e'

# diceware
alias diceware='diceware -d " "'

# colortest
alias colortest='msgcat --color=test'

# ranger keep running
alias rangerinf='while true; do ranger; done'

# archey3
alias archey3="archey3 --config=~/.config/archey3.cfg"

# docker aliases
alias pdf2htmlEX='docker run -ti --rm -v "$PWD":/pdf bwits/pdf2htmlex:1.0 pdf2htmlEX'
alias composer='docker run -ti --rm -v $PWD:/app composer:1.8.6 composer'
alias npm='docker run -ti --rm -v "$PWD":/usr/src/app -w /usr/src/app node:12.7.0-alpine npm --prefix .node_modules'
alias pgloader="docker run --rm dimitri/pgloader:latest pgloader"
#alias php='docker run -ti --rm -v "$PWD":/var/www/html php:7.3.7-fpm-alpine php'

# paths
PATH="$PATH:$HOME/.config/composer/vendor/bin"
PATH="$PATH:$HOME/.node_modules/node_modules/.bin"
PATH="$PATH:$HOME/.local/bin"

export FZF_DEFAULT_OPTS="--color=fg:255,hl:9 \
 --color=fg+:81,bg+:237,hl+:9 \
 --color=info:188,prompt:69,pointer:199 \
 --color=marker:109,spinner:248,header:255"

# source fzm
[ -f "$HOME"/.config/fzf-marks/fzf-marks.plugin.bash ] && source "$HOME/.config/fzf-marks/fzf-marks.plugin.bash"

# change directory with fzf
fd() {
  DIR=$(ls -t -A1 --color=never | fzf-tmux) \
    && cd "$DIR" || exit
}

# remove bash history duplicates
history-remove-duplicates() {
  awk '!visited[$0]++' "$HOME/.bash_history" > /tmp/.bash_history.tmp;
  mv -f /tmp/.bash_history.tmp "$HOME/.bash_history"
}
