export PATH="$HOME/bin:$HOME/.local/bin:$PATH"
export ZSH="$HOME/.oh-my-zsh"
export VISUAL=nvim
export LESSCHARSET=UTF-8
export LESS='-R --use-color'
export EDITOR="$VISUAL"

alias vim="nvim"

ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(git zsh-autosuggestions ssh-agent)

source $ZSH/oh-my-zsh.sh

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
PROMPT_EOL_MARK=''

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /usr/bin/terraform terraform

source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh
