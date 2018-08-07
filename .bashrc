# ~/.bashrc

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

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

# github dotfiles
alias dotfile='/usr/bin/git --git-dir=$HOME/.local/share/dotfiles/ --work-tree=$HOME'

# bash history settings
export HISTSIZE=
export HISTFILESIZE=
export HISTCONTROL=ignoredups:erasedups

# append bash history entries
shopt -s histappend
export PROMPT_COMMAND="history -a"

# ssh agent with keychain
alias ssh='eval $(/usr/bin/keychain --eval --agents ssh -Q --quiet ~/.ssh/mobile) && ssh'

# make mount command output pretty and human readable format
alias mount='mount | column -t'

# colorize the ls output
alias ls='ls --color=always'

# use a long listing format
alias ll='ls -la --color=always'

# show hidden files
alias l.='ls -d .* --color=always'

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

# reduce strokes for clear
alias c='clear'

# journalctl
alias journalctl='sudo journalctl -q'

# wavemon
alias wavemon='sudo wavemon'

# pacman
alias pacman='sudo pacman'
alias pacman-optimize='pacman -Sc --noconfirm'

# color grep
alias grep='grep --color=tty -d skip'

# alsamixer
alias alsamixer='alsamixer -V all'

# listed history
alias hist='history | grep'

# dmesg
alias dmesg='dmesg -e'

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
