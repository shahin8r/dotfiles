#!/bin/bash


#git clone https://github.com/shahin8r/dotfiles.git $HOME/.dotfiles
ln -sf $HOME/.dotfiles/.gitconfig $HOME
ln -sf $HOME/.dotfiles/.vimrc $HOME

if [[ "$(uname -s)" == "Darwin" ]]; then
  bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  brew install git zsh node wget tmux neovim vim pv yarn nvm awscli aws-elasticbeanstalk jq htop mpv ranger ncdu terraform blueutil nload docker-credential-helper-ecr act mysql-client ripgrep
  brew install --cask aws-vault iterm2 visual-studio-code docker google-chrome slack spotify telegram-desktop keepingyouawake sequel-ace transmission peco

  # disable press and hold for vscode so we can use vim keybindings
  defaults write com.microsoft.VSCode ApplePressAndHoldEnabled -bool false
fi

if [[ "$(uname -s)" == "Linux" ]]; then
  sudo apt update
  sudo apt install -y zsh awscli curl python3-pip neovim vim build-essential nodejs npm tmux pv zsh htop jq mpv ranger ncdu telegram-desktop nload amazon-ecr-credential-helper transmission mysql-client peco light compton feh i3 rofi xss-lock ripgrep xinput rxvt-unicode

  # install vscode
  wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
  sudo install -o root -g root -m 644 packages.microsoft.gpg /etc/apt/trusted.gpg.d/
  sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/trusted.gpg.d/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'

  sudo apt install -y apt-transport-https
  sudo apt update && sudo apt install -y code

  # install docker
  sudo apt install -y ca-certificates gnupg-agent software-properties-common
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
  sudo add-apt-repository -y "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
  sudo apt update
  sudo apt install -y docker-ce docker-ce-cli containerd.io docker-compose
  sudo usermod -a -G docker $USER

  # install terraform
  curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
  sudo apt-add-repository -y "deb [arch=$(dpkg --print-architecture)] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
  sudo apt install -y terraform

  # install aws-vault
  sudo curl -Lo /usr/local/bin/aws-vault https://github.com/99designs/aws-vault/releases/latest/download/aws-vault-linux-amd64
  sudo chmod 755 /usr/local/bin/aws-vault

  # install aws-elasticbeanstalk
  pip install awsebcli

  # install yarn
  npm install -g yarn

  # install google-chrome
  wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb -P /tmp
  sudo apt install -y /tmp/google-chrome-stable_current_amd64.deb

  # install spotify
  curl -sS https://download.spotify.com/debian/pubkey_0D811D58.gpg | sudo apt-key add - 
  echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list
  sudo apt update && sudo apt install -y spotify-client

  # setup i3
  ln -sf $HOME/.dotfiles/i3config $HOME/.config/i3/config
  ln -sf $HOME/.dotfiles/.i3status.conf $HOME

  # setup compton
  ln -sf $HOME/.dotfiles/compton.conf $HOME/.config

  # setup rofi
  mkdir -p $HOME/.config/rofi
  ln -sf $HOME/.dotfiles/rofi-config $HOME/.config/rofi/config

  # setup gtk settings
  ln -sf $HOME/.dotfiles/gtk-3.0-settings.conf $HOME/.config/gtk-3.0/settings.ini

  # setup urxvt
  ln -sf $HOME/.dotfiles/.Xresources $HOME/.Xresources
  wget https://raw.githubusercontent.com/simmel/urxvt-resize-font/master/resize-font -qP $HOME/.urxvt/ext/
fi

# setup tmux
ln -sf $HOME/.dotfiles/.tmux.conf $HOME/.tmux.conf

# setup neovim
mkdir -p $HOME/.config/nvim
ln -sf $HOME/.dotfiles/nvim/* $HOME/.config/nvim/

# install nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.37.2/install.sh | bash

# install oh-my-zsh and plugins
sh -c "RUNZSH=no KEEP_ZSHRC=yes $(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
ln -sf $HOME/.dotfiles/.zshrc $HOME

# install powerlevel10k zsh prompt
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
ln -sf $HOME/.dotfiles/.p10k.zsh $HOME

# install fonts
if [[ "$(uname -s)" == "Darwin" ]]; then
  FONTDIR=$HOME/Library/Fonts
fi

if [[ "$(uname -s)" == "Linux" ]]; then
  FONTDIR=$HOME/.local/share/fonts
  mkdir -p $FONTDIR
fi

wget https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/Hack/Regular/complete/Hack%20Regular%20Nerd%20Font%20Complete.ttf -qP $FONTDIR

if [[ "$(uname -s)" == "Linux" ]]; then
  # set zsh to default shell
  sudo chsh -s $(which zsh) $USER

  # update font cache
  fc-cache -f $FONTDIR
fi

chmod +x $HOME/.dotfiles/bin/*
mkdir -p $HOME/bin
ln -sf $HOME/.dotfiles/bin/* $HOME/bin

echo -e "\nAll done! Log out and log in again.\n"
