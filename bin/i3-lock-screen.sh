#!/bin/bash

dunst set-paused true

img=$(mktemp /tmp/XXXXXXXXXX.png)
import -window root $img
convert $img -scale 10% -scale 1000% $img

i3lock -n -u -i $img
rm $img

dunst set-paused false
