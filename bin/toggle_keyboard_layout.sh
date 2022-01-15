#!/bin/bash

KBD_LAYOUT=$(setxkbmap -query | grep layout | sed -e 's/layout://g' | sed -e 's/ //g')

if [[ $KBD_LAYOUT == "us" ]]; then
  setxkbmap se
else
  setxkbmap us
fi

setxkbmap -option ctrl:nocaps

