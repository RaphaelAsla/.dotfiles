#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps

if [ -f $sysresources ]; then

    xrdb -merge $sysresources

fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then

    xrdb -merge "$userresources"

fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

# start some nice programs

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

# Display Resolution
xrandr --output HDMI-0 --mode 1920x1080 --primary &
xrandr --output DP-1 --mode 1920x1080 &
xrandr --output DP-1 --auto --right-of HDMI-0 &

# status bar
/home/reavey/.config/dwm-bar/dwm_bar.sh &

# Compositor
picom &

# wallpaper
nitrogen --restore &

# Execute DWM
exec dwm
