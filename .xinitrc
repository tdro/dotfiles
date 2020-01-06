#!/bin/sh

userresources=$HOME/.config/Xresources
usermodmap=$HOME/.config/Xmodmap


# merge in defaults and keymaps
if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

# Screen timeouts
xset s 0 0 &
xset dpms 3600 3600 3600 &

# set cursor
xsetroot -cursor_name left_ptr

# Run awesome
exec awesome --no-argb
