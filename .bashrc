# ~/.bashrc
# If not running interactively, don't do anything

[[ $- != *i* ]] && return
PS1='\[\e[0;34m\][ \W ] \$\[\e[0m\] '

# github dotfiles
alias dotfile='/usr/bin/git --git-dir=$HOME/.local/share/dotfiles/ --work-tree=$HOME'

# no repeating history
unset HISTSIZE 
unset HISTFILESIZE
HISTCONTROL=ignoredups:erasedups
shopt -s histappend
PROMPT_COMMAND="history -n; history -w; history -c; history -r; $PROMPT_COMMAND"

# ssh agent with keychain
alias ssh='eval $(/usr/bin/keychain --eval --agents ssh -Q --quiet ~/.ssh/primary) && ssh'

# make mount command output pretty and human readable format
alias mount='mount | column -t'

# colorize the ls output
alias ls='ls --color=always'
 
# use a long listing format
alias ll='ls -la --color=always'
 
# show hidden files
alias l.='ls -d .* --color=always'

# do not delete / or prompt if deleting more than 3 files at a time
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
alias locate='locate -e'

# reboot / halt / poweroff which are symlink'd to systemd
alias reboot='sudo /sbin/reboot'
alias poweroff='sudo /sbin/poweroff'
alias halt='sudo /sbin/halt'
alias shutdown='sudo /sbin/shutdown'

# reduce strokes for clear
alias c='clear'

# journalctl
alias journalctl='sudo journalctl -q'

# netctl
alias netctl='sudo netctl'

# wifi-menu
alias wifi-menu='sudo wifi-menu'

# wavemon
alias wavemon='sudo wavemon'

# pacman
alias pacman='sudo pacman'
alias pacman-optimize='pacman -Sc --noconfirm && sudo pacman-optimize'

# color grep
alias grep='grep --color=tty -d skip'

# alsamixer
alias alsamixer='alsamixer -V all'

# archey
alias archey='archey3'

# listed history
alias hist='history | grep'

# live streams
alias alj='rtmpdump -v -r rtmp://aljazeeraflashlivefs.fplive.net/aljazeeraflashlive-live/aljazeera_eng_med | mplayer -'
alias alja='rtmpdump -r "rtmp://ajam.lsops.net/live/" -a "live/" -f "LNX 11,2,202,332" -W "http://static.ls-cdn.com/player/5.10/livestation-player.swf?1387140070" -p "http://www.livestation.com" -y "ajam_en_584" | mplayer -'
alias zns='rtmpdump -v -r rtmp://streamcomedia.streamguys1.com/live/znsmobile | mplayer -'
alias bbc='rtmpdump -v -r rtmp://hd4.lsops.net/live/bbcnews_en_364 http://p.jwpcdn.com/6/8/jwplayer.flash.swf http://www.wherever.tv/tv-channels/BBC-News-24.jsf | mplayer -'

# ssh bash prompt color change
if [ -n "$SSH_CLIENT" ]; then
export PS1='\[\e[0;32m\][ \W ] \$\[\e[0m\] '
fi

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
