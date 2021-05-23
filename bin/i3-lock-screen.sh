#!/bin/bash
img=$(mktemp /tmp/XXXXXXXXXX.png)
import -window root $img 
convert $img -scale 10% -scale 1000% $img
i3lock -u -i $img
rm $img
