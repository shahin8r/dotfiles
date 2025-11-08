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

sudo pacman -S --noconfirm openssh man zsh aws-cli curl neovim vim nodejs npm tmux pv htop jq mpv ranger screen ncdu telegram-desktop nload transmission-gtk mariadb-clients peco feh ripgrep fzf playerctl bat python-pip iwd impala dunst imagemagick wget libnotify yarn rsync unzip fd polkit bind noto-fonts-emoji zip eza wiremix pamixer

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
sudo pacman -S --noconfirm aws-vault

log 'install packer'
sudo pacman -S --noconfirm packer

log 'install adwaita gtk theme'
sudo pacman -S --noconfirm gnome-themes-extra

log 'install 1password'
yay -S --noconfirm --answerdiff=None 1password

log 'install google-chrome'
yay -S --noconfirm --answerdiff=None google-chrome

log 'install brave'
yay -S --noconfirm --answerdiff=None brave-bin

log 'install slack'
yay -S --noconfirm --answerdiff=None slack-desktop

log 'install spotify'
yay -S --noconfirm --answerdiff=None spotify

log 'install beekeeper studio'
#yay -S --noconfirm --answerdiff=None beekeeper-studio

log 'install alacritty'
sudo pacman -S --noconfirm alacritty
ln -sf $HOME/.dotfiles/alacritty.toml $HOME/.config/alacritty.toml

log 'install github-cli'
yay -S --noconfirm --answerdiff=None github-cli

log 'install openai codex'
yay -S --noconfirm --answerdiff=None openai-codex-bin

log 'setup tmux'
ln -sf $HOME/.dotfiles/.tmux.conf $HOME/.tmux.conf

log 'setup neovim'
ln -sfn $HOME/.dotfiles/nvim $HOME/.config/nvim

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

log 'install fonts'
sudo pacman -S --noconfirm ttf-jetbrains-mono-nerd

log 'set zsh to default shell'
sudo chsh -s $(which zsh) $USER

log 'setup global gitignore'
ln -sf $HOME/.dotfiles/.gitignore $HOME/.gitignore

log 'install gnome-keyring'
sudo pacman -S --noconfirm gnome-keyring seahorse

log 'generate ssh key'
ssh-keygen -t ed25519 -C "shahin.ag@gmail.com"

ln -sf $HOME/.dotfiles/bin $HOME/bin

log 'install hyprland and related packages'
sudo pacman -S --noconfirm hyprland hyprlock hypridle hyprpaper hyprshot hyprpicker xdg-desktop-portal xdg-desktop-portal-gtk xdg-desktop-portal-hyprland swayosd swaync brightnessctl bluetui udiskie waybar nwg-look impala swayosd swaync brightnessctl bluetui udiskie waybar nwg-look btop nautilus
yay -S --noconfirm --answerdiff=None walker-bin elephant-desktopapplications elephant-calc elephant-clipboard elephant-providerlist elephant-symbols elephant-files terminaltexteffects-git

sudo pacman -S --noconfirm xdg-user-dirs
xdg-user-dirs-update

ln -sfn $HOME/.dotfiles/xdg-desktop-portal $HOME/.config/xdg-desktop-portal
ln -sfn $HOME/.dotfiles/hypr $HOME/.config/hypr
ln -sfn $HOME/.dotfiles/waybar $HOME/.config/waybar
ln -sfn $HOME/.dotfiles/swaync $HOME/.config/swaync
ln -sfn $HOME/.dotfiles/walker $HOME/.config/walker

log 'All done! Reboot.'
