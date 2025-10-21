export ZSH="$HOME/.oh-my-zsh"
export PATH="$HOME/.dotfiles/bin:$HOME/.local/bin:$ANDROID_HOME/platform-tools:$PATH"
export VISUAL=nvim
export LESSCHARSET=UTF-8
export LESS='-R --use-color'
export EDITOR="$VISUAL"
export ANDROID_HOME=$HOME/Android/Sdk
#export JAVA_HOME=$HOME/.jdks/corretto-16.0.2
export JAVA_HOME=$HOME/.jdks/jbr-17.0.9
export XDG_CONFIG_HOME=$HOME/.config
export QT_QPA_PLATFORMTHEME=qt6ct

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

alias vim="nvim"
alias ls="eza -lh --group-directories-first --icons=auto"
alias cat="bat"

source $HOME/.struqturrc

export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

