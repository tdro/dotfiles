# ~/.bashrc

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# cd using directory name
shopt -s autocd;

# disable ctrl+s
stty -ixon;

# set prompt statement
PS1='\[\e[0;34m\]\W \$\[\e[0m\] '

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

# ssh bash prompt color change
if [ -n "$SSH_CLIENT" ]; then
  export PS1='\[\e[0;32m\][ \W ] \$\[\e[0m\] '
fi

# bash history settings
export HISTSIZE=
export HISTFILESIZE=
export HISTCONTROL=ignoredups:erasedups

# append bash history entries
shopt -s histappend

# get last command for prompt command
lastcmd() { LASTCMD=$(history 1 | cut -c8-); echo -ne "\e]2;$LASTCMD\a\e]1;$LASTCMD\a"; }

# prompt command runs on every command
export PROMPT_COMMAND="history -a; command -v lastcmd > /dev/null 2>&1 && lastcmd"

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

# listed history
alias hist='history | grep'

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

# color man
man() {
  env LESS_TERMCAP_mb=$(printf "\e[1;31m") \
  LESS_TERMCAP_md=$(printf "\e[1;31m") \
  LESS_TERMCAP_me=$(printf "\e[0m") \
  LESS_TERMCAP_se=$(printf "\e[0m") \
  LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
  LESS_TERMCAP_ue=$(printf "\e[0m") \
  LESS_TERMCAP_us=$(printf "\e[1;32m") \
  man "$@"
}

# docker aliases
alias pdf2htmlEX="docker run -ti --rm -v ${PWD}:/pdf bwits/pdf2htmlex pdf2htmlEX"

# add php composer path
export PATH="${PATH}:~/.config/composer/vendor/bin/"

# add npm path
PATH="$HOME/.node_modules/bin:$PATH"

# add npm prefix
export npm_config_prefix=~/.node_modules

# source fzm
source $HOME/.config/ranger/fzf-marks/fzf-marks.plugin.bash
