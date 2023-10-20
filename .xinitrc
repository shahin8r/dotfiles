# needed for gnome-keyring to work
/etc/X11/xinit/xinitrc.d/50-systemd-user.sh
xrdb ~/.Xresources

exec i3
