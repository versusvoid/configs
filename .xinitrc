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

# exec gnome-session
# exec startkde
# exec startxfce4
# ...or the Window Manager of your choice

# set cursor
xsetroot -cursor_name left_ptr

# configure urxvt
#xrdb -merge ~/.Xresources

# set background
feh --bg-scale ~/Pictures/222154.jpg 

# enable transparency
xcompmgr -n &

# enable system tray
trayer \
    --edge top             \
    --align right          \
    --SetDockType true     \
    --SetPartialStrut true \
    --widthtype pixel      \
    --width 200            \
    --heighttype request   \
    --transparent true     \
    --alpha 0              \
    --tint 0x000000        \
    &

# enable network-manager
nm-applet -sm-disable &

# disable beep
xset -b

# run guake terminal
guake &

# Let's rock!
exec xmonad

