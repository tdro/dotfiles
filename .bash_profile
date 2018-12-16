# ~/.bash_profile

# add php composer path
export PATH="${PATH}:~/.config/composer/vendor/bin/"

[[ -f ~/.bashrc ]] && . ~/.bashrc
[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && exec startx &> /dev/null
