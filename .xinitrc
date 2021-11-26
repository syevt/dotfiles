#!/bin/sh
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

xrdb -merge ~/.Xresources

# `$ xrandr` to get the names and values, `--left-of` means `to the left of this one`
xrandr --output HDMI-1 --primary --mode 1920x1080 --rate 60.00 --output VGA-1 --mode 1360x768 --rate 60.02 --left-of HDMI-1
