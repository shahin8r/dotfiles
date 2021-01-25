export PATH="$HOME/bin:$PATH"
export ZSH="$HOME/.oh-my-zsh"
export VISUAL=vim
export EDITOR="$VISUAL"

# adding aws elastic beanstalk cli to path on linux
if [[ "$(uname -s)" == "Linux" ]]; then
  export PATH="$HOME/.pyenv/versions/3.7.2/bin:$PATH"
  export PATH="$HOME/.ebcli-virtual-env/executables:$PATH"
fi

ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(git zsh-autosuggestions)

source $ZSH/oh-my-zsh.sh

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
PROMPT_EOL_MARK=''

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /usr/bin/terraform terraform
