# ~/.bash_profile

[[ $XDG_VTNR -ne 1 ]] && . ~/.bashrc;

[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && exec startx &> /dev/null;
