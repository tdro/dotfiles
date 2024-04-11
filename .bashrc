#!/bin/bash -eu

# source exports
export BASH_PROFILE=1 && . "$HOME/.bash_profile"

# bail if not interactive
printf '%s' "$-" | grep -q "i" || return

# cd using directory name
shopt -s autocd

# append bash history entries
shopt -s histappend

# bash history one command per line
shopt -s cmdhist

# disable program completion
shopt -u progcomp

# enable vi mode
set -o vi

# disable ctrl+s
stty stop ''
stty start ''
stty -ixon
stty -ixoff

# fzf bindings
fzfcompletion="$HOME/.config/fzf/completion.bash"
fzfkeybindings="$HOME/.config/fzf/key-bindings.bash"
[ -f "$fzfcompletion" ] && . "$fzfcompletion"
[ -f "$fzfkeybindings" ] && . "$fzfkeybindings"

# set virtual console colors
if [ "$TERM" = "linux" ]; then
  echo -en "\e]P0111111" # black [background]
  echo -en "\e]P1D84F4F" # darkred
  echo -en "\e]P2DEFF3E" # darkgreen
  echo -en "\e]P3FFDF23" # brown
  echo -en "\e]P479AEFF" # darkblue
  echo -en "\e]P58894CF" # darkmagenta
  echo -en "\e]P679AEFF" # darkcyan
  echo -en "\e]P7dddddd" # lightgray
  echo -en "\e]P8DDDDDD" # darkgray
  echo -en "\e]P9E84F4F" # red
  echo -en "\e]PABEFF3E" # green
  echo -en "\e]PBFEA63C" # yellow
  echo -en "\e]PC69AEFF" # blue
  echo -en "\e]PD9894CF" # magenta
  echo -en "\e]PE69AEFF" # cyan
  echo -en "\e]PFffffff" # white [foreground]
  clear                  # for background artifacting
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
alias ssh='eval $(keychain --dir $HOME/.cache/keychain --eval --agents ssh -Q --quiet ~/.ssh/mobile ~/.ssh/primary) && ssh'

# parenting
alias mv='mv -i'
alias cp='cp -i'
alias ln='ln -i'
alias rm='rm -I --preserve-root'
alias chown='chown --preserve-root'
alias chmod='chmod --preserve-root'
alias chgrp='chgrp --preserve-root'

# general aliases
alias alsamixer='alsamixer --view all'
alias archey3="archey3 --config=~/.config/archey3.cfg"
alias colortest='msgcat --color=test'
alias dash='PS1="$ " dash'
alias diceware='diceware -d " "'
alias dict='dict -h localhost'
alias dmesg='dmesg -e'
alias emacs='TERM=xterm-256color emacs -nw'
alias grep='grep --color=tty -d skip'
alias locate='locate -ie'
alias ls='ls -hN --color=always --group-directories-first'
alias lsblk='lsblk -o NAME,MAJ:MIN,RM,SIZE,FSTYPE,RO,TYPE,MOUNTPOINT,MODEL'
alias lxc-attach='lxc-attach --clear-env --name'
alias lxc-ls='lxc-ls --fancy'
alias lynx='lynx -cfg ~/.config/lynx/lynx.cfg'
alias mocp='mocp -M $XDG_CONFIG_HOME/moc'
alias newsboat='newsboat -c $XDG_CONFIG_HOME/newsboat/cache.db -u $XDG_CONFIG_HOME/newsboat/urls -C $XDG_CONFIG_HOME/newsboat/config'
alias nix-index='nix-index --db $XDG_DATA_HOME/nix-index'
alias nix-locate='nix-locate --db $XDG_DATA_HOME/nix-index'
alias rangerinf='while true; do ranger; done'
alias rofi='rofi -cache-dir $XDG_DATA_HOME'
alias sh='dash'
alias tidy='tidy -config $HOME/.config/tidy.conf'
alias units='units --history "$XDG_CACHE_HOME"/units_history'

# nix helpers
nix-which() { readlink --canonicalize "$(type -P "$1")"; }

# lxc helpers
lxc-copy() { A=$1 && B=$2 && shift 2 && $(type -P lxc-copy) --allowrunning --name "$A" -N "$B" "$@"; }
lxc-shell() { lxc-start "$1" > /dev/null 2>&1 && lxc-attach "$1" -- /bin/sh -c 'export HOME="/root" && . /etc/profile && /bin/sh'; }
lxc-restart() { $(type -P lxc-stop) --kill --name "$1"; $(type -P lxc-start) -n "$1"; }
lxc-start() { for container in "$@"; do $(type -P lxc-start) --name "$container"; done }
lxc-stop() { for container in "$@"; do $(type -P lxc-stop) --kill --name "$container"; done }
lxc-destroy() { for container in "$@"; do $(type -P lxc-destroy) --name "$container"; done }

# source fzf markers
[ -f "$HOME/.config/fzf/marks.plugin.bash" ] && . "$HOME/.config/fzf/marks.plugin.bash"

# extract docker container as rootfs
docker-rootfs() { id=$(docker run --detach "$1" /bin/true) \
  && docker export "$id" --output "rootfs.tar" \
  && docker container rm "$id" \
  && ls -l rootfs.tar; }

# press ctrl+d after writing string to standard input (https://til.simonwillison.net/bash/escaping-a-string)
shellquote() { printf '%q\n' "$(cat)"; }

# show window title of last command (https://stackoverflow.com/a/5080670)
trap 'echo -ne "\033]2;term: $PWD $(history 1 | tr -s " " | cut -d " " -f 5-)\007"' DEBUG

# swallow
swallow() { "$@" & disown; exit; }
