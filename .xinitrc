#!/bin/sh
# ~/.xinitrc
# Executed by startx (run your window manager from here)

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

# Set Xresources to be sourced
[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources

# Normal cursor
xsetroot -cursor_name left_ptr &

# Protect eyes with redshift
redshift &

# Key mappings
xmodmap .Xmodmap &

# Run awesome
exec awesome --no-argb
