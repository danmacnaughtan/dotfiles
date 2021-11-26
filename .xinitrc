#! /bin/bash

picom &

redshift -l 43.42537:-80.5112 &

setxkbmap -option caps:escape

# So the minecraft-launcher remembers my login...
eval $(gnome-keyring-daemon --start)
export SSH_AUTH_SOCK

exec startxfce4
