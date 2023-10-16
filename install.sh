#!/bin/bash

set -e

function log () {
  echo -e "\n---------------------"
  echo "$1..."
  echo -e "---------------------\n"
}

sudo pacman -S --noconfirm git

git clone https://github.com/shahin8r/dotfiles.git $HOME/.dotfiles
cd $HOME/.dotfiles
git remote set-url origin git@github.com:shahin8r/dotfiles.git
ln -sf $HOME/.dotfiles/.gitconfig $HOME
cd $HOME

sudo pacman -S --noconfirm openssh man zsh aws-cli curl neovim vim nodejs npm tmux pv htop jq mpv ranger screen ncdu telegram-desktop nload transmission-gtk mariadb-clients peco light compton feh i3-gaps xss-lock ripgrep xorg-xinput scrot fzf xsel hsetroot playerctl bat python-pip networkmanager dunst imagemagick i3lock wget libnotify yarn rsync unzip fd polkit bind noto-fonts-emoji ibus-emoji zip

log 'install yay'
sudo pacman -S --noconfirm --needed base-devel git
git clone https://aur.archlinux.org/yay-git.git
cd yay-git
makepkg -si
cd $HOME && rm -rf yay-git

log 'install vscode'
sudo pacman -S --noconfirm code

log 'install docker'
sudo pacman -S --noconfirm docker docker-compose

log 'install terraform'
sudo pacman -S --noconfirm terraform

log 'install aws-vault'
sudo curl -Lo /usr/local/bin/aws-vault https://github.com/99designs/aws-vault/releases/latest/download/aws-vault-linux-amd64
sudo chmod 755 /usr/local/bin/aws-vault

log 'install adwaita gtk theme'
sudo pacman -S --noconfirm gnome-themes-extra

log 'install xidlehook'
yay -S --noconfirm --answerdiff=None xidlehook

log 'install 1password'
yay -S --noconfirm --answerdiff=None 1password

log 'install google-chrome'
yay -S --noconfirm --answerdiff=None google-chrome

log 'install slack'
yay -S --noconfirm --answerdiff=None slack-desktop

log 'install spotify'
yay -S --noconfirm --answerdiff=None spotify

log 'install beekeeper studio'
yay -S --noconfirm --answerdiff=None beekeeper-studio

log 'setup i3'
mkdir -p $HOME/.config/i3
ln -sf $HOME/.dotfiles/i3config $HOME/.config/i3/config
ln -sf $HOME/.dotfiles/.i3status.conf $HOME

log 'setup picom'
ln -sf $HOME/.dotfiles/picom.conf $HOME/.config

log 'setup gtk settings'
mkdir -p $HOME/.config/gtk-3.0
ln -sf $HOME/.dotfiles/gtk-3.0-settings.ini $HOME/.config/gtk-3.0/settings.ini

log 'install alacritty'
sudo pacman -S --noconfirm alacritty
ln -sf $HOME/.dotfiles/alacritty.yml $HOME/.config/alacritty.yml

ln -sf $HOME/.dotfiles/.Xresources $HOME/.Xresources

log 'install rofi'
sudo pacman -S --noconfirm rofi rofi-calc
yay -S --noconfirm --answerdiff=None rofi-bluetooth-git

log 'setup xorg keyboard config'
sudo ln -sf $HOME/.dotfiles/00-keyboard.conf /etc/X11/xorg.conf.d/00-keyboard.conf

log 'setup xorg mouse config'
sudo ln -sf $HOME/.dotfiles/00-mouse.conf /etc/X11/xorg.conf.d/00-mouse.conf

log 'setup tmux'
ln -sf $HOME/.dotfiles/.tmux.conf $HOME/.tmux.conf

log 'setup neovim'
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
mkdir -p $HOME/.config/nvim
ln -sf $HOME/.dotfiles/nvim/* $HOME/.config/nvim/
pip install pynvim

log 'install nvm'
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.37.2/install.sh | bash

log 'install oh-my-zsh and plugins'
sh -c "RUNZSH=no KEEP_ZSHRC=yes $(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
ln -sf $HOME/.dotfiles/.zshrc $HOME

log 'install powerlevel10k zsh prompt'
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
ln -sf $HOME/.dotfiles/.p10k.zsh $HOME

log 'install bluetooth'
sudo pacman -S --noconfirm bluez bluez-utils

log 'install polybar'
sudo pacman -S --noconfirm polybar
mkdir $HOME/.config/polybar
ln -sf $HOME/.dotfiles/polybar/config.ini $HOME/.config/polybar/config.ini
ln -sf $HOME/.dotfiles/polybar/launch.sh $HOME/.config/polybar/launch.sh

log 'install fonts'
sudo pacman -S --noconfirm ttf-dejavu
FONTDIR=$HOME/.local/share/fonts
mkdir -p $FONTDIR

yay -S --noconfirm --answerdiff=None nerd-fonts-hack

log 'set zsh to default shell'
sudo chsh -s $(which zsh) $USER

log 'setup global gitignore'
ln -sf $HOME/.dotfiles/.gitconfig $HOME/.gitconfig

log 'install gnome-keyring'
sudo pacman -S --noconfirm gnome-keyring seahorse

log 'generate ssh key'
ssh-keygen -t ed25519 -C "shahin.ag@gmail.com"

chmod +x $HOME/.dotfiles/bin/*
mkdir -p $HOME/bin
ln -sf $HOME/.dotfiles/bin/* $HOME/bin

log 'All done! Log out and log in again.'
