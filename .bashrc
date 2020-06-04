#!/bin/bash

# source exports
export BASH_PROFILE=loaded && . "$HOME/.bash_profile";

# bail if not interactive
echo $- | grep -q "i" || return;

# cd using directory name
shopt -s autocd;

# append bash history entries
shopt -s histappend;

# bash history one command per line
shopt -s cmdhist;

# enable vi mode
set -o vi;

# disable ctrl+s
stty stop '';
stty start '';
stty -ixon;
stty -ixoff;

# fzf bindings
fzfcompletion=$(readlink "$(type -P fzf)" | cut -d '/' -f -4)/share/fzf/completion.bash;
fzfkeybindings=$(readlink "$(type -P fzf)" | cut -d '/' -f -4)/share/fzf/key-bindings.bash;
[ -f "$fzfcompletion" ] && . "$fzfcompletion";
[ -f "$fzfkeybindings" ] && . "$fzfkeybindings";

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

# ssh agent with keychain
alias ssh='eval $(keychain --eval --agents ssh -Q --quiet ~/.ssh/mobile ~/.ssh/primary) && ssh'

# parenting
alias mv='mv -i'
alias cp='cp -i'
alias ln='ln -i'
alias rm='rm -I --preserve-root'
alias chown='chown --preserve-root'
alias chmod='chmod --preserve-root'
alias chgrp='chgrp --preserve-root'

# general aliases
alias locate='locate -ie'
alias wavemon='sudo wavemon'
alias pacman='sudo pacman'
alias grep='grep --color=tty -d skip'
alias alsamixer='alsamixer -V all'
alias dmesg='dmesg -e'
alias diceware='diceware -d " "'
alias colortest='msgcat --color=test'
alias rangerinf='while true; do ranger; done'
alias archey3="archey3 --config=~/.config/archey3.cfg"
alias wget='wget --hsts-file $HOME/.cache/wget.history'
alias ls='ls -hN --color=always --group-directories-first'
alias lsblk='lsblk -o NAME,MAJ:MIN,RM,SIZE,FSTYPE,RO,TYPE,MOUNTPOINT,MODEL'
alias emacs='TERM=xterm-256color emacs -nw --load ~/.config/emacs/emacs.el'
alias mocp='mocp -M "$XDG_CONFIG_HOME"/moc'
alias rofi='rofi -cache-dir $XDG_DATA_HOME'
alias lxc-attach='lxc-attach --clear-env -n'
alias lxc-ls='lxc-ls -f'
alias audacity='PULSE_LATENCY_MSEC=30 audacity'
alias go='GOPATH=$(pwd)/go go'
alias tidy='tidy -config $HOME/.config/tidy.conf'

# nix helpers
nix-which() { readlink "$(type -P "$1")"; }

# lxc helpers
lxc-copy() { $(type -P lxc-copy) -n "$1" -N "$2"; }
lxc-restart() { $(type -P lxc-stop) -n "$1"; $(type -P lxc-start) -n "$1"; }
lxc-start() { for container in "$@"; do $(type -P lxc-start) -n "$container"; done }
lxc-stop() { for container in "$@"; do $(type -P lxc-stop) -kn "$container"; done }

# source fzm
[ -f "$HOME/.config/fzf-marks/fzf-marks.plugin.bash" ] && . "$HOME/.config/fzf-marks/fzf-marks.plugin.bash"

# remove bash history duplicates
history-remove-duplicates() { awk '!visited[$0]++' "$HOME/.bash_history" > /tmp/.bash_history.tmp && mv -f /tmp/.bash_history.tmp "$HOME/.bash_history"; }

# extract docker container as rootfs
docker-rootfs() { id=$(docker run -d "$1" /bin/true) && docker export -o "$2" "$id" && docker container rm "$id"; }
