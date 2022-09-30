#!/bin/sh

if rm /tmp/screen_awake; then
  notify-send "Screen can now be locked"
else
  touch /tmp/screen_awake
  notify-send "Screen will not lock for 1 hour"
  sleep 60m
  rm /tmp/screen_awake
fi
