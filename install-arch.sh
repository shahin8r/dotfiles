#!/bin/bash

set -e

function log () {
  echo "---------------------"
  echo "$1..."
  echo "---------------------"
}

sudo pacman -S git

git clone https://github.com/shahin8r/dotfiles.git $HOME/.dotfiles
cd $HOME/.dotfiles
git remote set-url origin git@github.com:shahin8r/dotfiles.git
ln -sf $HOME/.dotfiles/.gitconfig $HOME
cd $HOME

sudo pacman -S --noconfirm openssh man zsh aws-cli curl neovim vim nodejs npm tmux pv htop jq mpv ranger ncdu telegram-desktop nload transmission-gtk mariadb-clients peco light compton feh i3-gaps i3status rofi xss-lock ripgrep xorg-xinput scrot fzf xsel hsetroot playerctl xautolock bat python-pip networkmanager dunst

log 'install yay'
sudo pacman -S --needed base-devel git
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

log 'install 1password'
yay -S --noconfirm 1password

log 'install google-chrome'
yay -S --noconfirm google-chrome

log 'install slack'
yay -S --noconfirm slack-desktop

log 'install spotify'
yay -S --noconfirm spotify

log 'setup i3'
mkdir -p $HOME/.config/i3
ln -sf $HOME/.dotfiles/i3config $HOME/.config/i3/config
ln -sf $HOME/.dotfiles/.i3status.conf $HOME

log 'setup picom'
ln -sf $HOME/.dotfiles/picom.conf $HOME/.config

log 'setup gtk settings'
mkdir -p $HOME/.config/gtk-3.0
ln -sf $HOME/.dotfiles/gtk-3.0-settings.conf $HOME/.config/gtk-3.0/settings.ini

log 'install st'
sudo pacman -S --noconfirm libxft
mkdir -p $HOME/src
git clone git@github.com:shahin8r/st.git $HOME/src/st
cd $HOME/src/st && sudo make clean install

ln -sf $HOME/.dotfiles/.Xresources $HOME/.Xresources

log 'install rofi-calc'
sudo pacman -S --noconfirm rofi-calc

log 'setup xorg keyboard config'
sudo ln -sf $HOME/.dotfiles/00-keyboard.conf /etc/X11/xorg.conf.d/00-keyboard.conf

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
sudo pacman -S bluez bluez-utils

log 'install fonts'
FONTDIR=$HOME/.local/share/fonts
mkdir -p $FONTDIR

wget https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/Hack/Regular/complete/Hack%20Regular%20Nerd%20Font%20Complete.ttf -qP $FONTDIR

log 'update font cache'
fc-cache -f $FONTDIR

log 'set zsh to default shell'
sudo chsh -s $(which zsh) $USER

chmod +x $HOME/.dotfiles/bin/*
mkdir -p $HOME/bin
ln -sf $HOME/.dotfiles/bin/* $HOME/bin

log "\nAll done! Log out and log in again.\n"