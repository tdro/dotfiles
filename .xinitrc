#!/bin/sh

userresources=$HOME/.config/Xresources
usermodmap=$HOME/.config/Xmodmap

# merge in defaults and keymaps
[ -f "$userresources" ] && xrdb -merge "$userresources";
[ -f "$usermodmap" ] && xmodmap "$usermodmap";

# screen timeouts
xset s 0 0 &
xset dpms 3600 3600 3600 &

# set cursor
xsetroot -cursor_name left_ptr;

# set keypress repeat
xset r rate 200 60;

# import systemd environment
systemctl --user import-environment;

# Run awesome
exec awesome --no-argb;
