# ~/.bash_profile

[[ -f ~/.bashrc ]] && . ~/.bashrc
[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && exec startx -- -keeptty -nolisten tcp > /dev/null 2>&1

# add php composer path
export PATH="${PATH}:~/.config/composer/vendor/bin/"
