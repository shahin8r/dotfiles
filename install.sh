#!/bin/bash

if [[ "$(uname -s)" == "Darwin" ]]; then
  bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  brew install git zsh node wget tmux vim pv yarn nvm awscli aws-elasticbeanstalk jq htop mpv ranger ncdu terraform blueutil nload docker-credential-helper-ecr act mysql-client
  brew install --cask aws-vault iterm2 visual-studio-code docker google-chrome slack spotify telegram-desktop notion figma keepingyouawake kitty poedit transmission

  # disable press and hold for vscode so we can use vim keybindings
  defaults write com.microsoft.VSCode ApplePressAndHoldEnabled -bool false
fi

if [[ "$(uname -s)" == "Linux" ]]; then
  sudo apt update
  sudo apt install -y awscli curl vim build-essential nodejs npm tmux pv zsh htop jq mpv ranger ncdu telegram-desktop slack-desktop telegram-desktop nload amazon-ecr-credential-helper kitty poedit transmission mysql-client

  # set kitty as default terminal in gnome
  gsettings set org.gnome.desktop.default-applications.terminal exec 'kitty'

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
  sudo apt install -y build-essential zlib1g-dev libssl-dev libncurses-dev libffi-dev libsqlite3-dev libreadline-dev libbz2-dev
  git clone https://github.com/aws/aws-elastic-beanstalk-cli-setup.git /tmp
  /tmp/aws-elastic-beanstalk-cli-setup/scripts/bundled_installer

  # install act
  curl https://raw.githubusercontent.com/nektos/act/master/install.sh | sudo bash

  # install yarn
  npm install -g yarn

  # install google-chrome
  wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb -P /tmp
  sudo apt install -y /tmp/google-chrome-stable_current_amd64.deb

  # install spotify
  curl -sS https://download.spotify.com/debian/pubkey_0D811D58.gpg | sudo apt-key add - 
  echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list
  sudo apt update && sudo apt install -y spotify-client
fi

git clone https://github.com/shahin8r/dotfiles.git $HOME/.dotfiles
ln -sf $HOME/.dotfiles/.gitconfig $HOME
ln -sf $HOME/.dotfiles/.vimrc $HOME

# setup kitty config
mkdir -p $HOME/.config/kitty
ln -sf $HOME/.dotfiles/kitty.conf $HOME/.config/kitty
ln -sf $HOME/.dotfiles/kitty_zoom_toggle.py $HOME/.config/kitty

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

wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf -qP $FONTDIR 
wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold.ttf -qP $FONTDIR
wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Italic.ttf -qP $FONTDIR
wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold%20Italic.ttf -qP $FONTDIR

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
