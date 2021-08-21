#! /bin/bash

compton &

caffeine -a &

redshift -l 43.42537:-80.5112 &

setxkbmap -option caps:escape

exec startxfce4
