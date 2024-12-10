#!/bin/bash

setxkbmap us -variant dvorak 
setxkbmap -option caps:swapescape
xhost +local:
xlock -fontset "-misc-dejavu serif condensed-medium-i-semicondensed--0-0-0-0-p-0-ascii-0" -mode fiberlamp
