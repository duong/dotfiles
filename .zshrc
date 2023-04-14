# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
  dotenv
  docker
  aws
  yarn
  gh
  kubectl
  brew
)

source $ZSH/oh-my-zsh.sh

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

alias ls='ls --color=auto'
alias ll='ls -lah --color=auto'
alias grep='grep --color=auto'
alias ec="$EDITOR $HOME/.zshrc" # edit .zshrc
alias sc="source $HOME/.zshrc"  # reload zsh configuration

# Conditionally load dotfiles based on OS
if [[ $(uname) == "Darwin" ]]; then
  source ~/.darwin.zsh
elif [[ $(uname) == "Linux" ]]; then
  source ~/.linux.zsh
fi

# zplug - manage plugins
zplug "zsh-users/zsh-syntax-highlighting"
zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-completions"
zplug mafredri/zsh-async, from:github

# pure theme colors
PINK='#fa68bd'
LIGHT_GREEN='#55e787'
LIGHT_BLUE='#55c3fb'
DARK_GREY='#282a36'

zplug install
zplug load --verbose

# set aws prompt
ZSH_THEME_AWS_PREFIX='( '
ZSH_THEME_AWS_SUFFIX=' )'

# nvm to path
export NVM_DIR="$HOME/.nvm"
source ~/.nvm/nvm.sh

# use nvmrc
# place this after nvm initialization!
autoload -U add-zsh-hook
load-nvmrc() {
  local node_version="$(nvm version)"
  local nvmrc_path="$(nvm_find_nvmrc)"

  if [ -n "$nvmrc_path" ]; then
    local nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

    if [ "$nvmrc_node_version" = "N/A" ]; then
      nvm install
    elif [ "$nvmrc_node_version" != "$node_version" ]; then
      nvm use
    fi
  elif [ "$node_version" != "$(nvm version default)" ]; then
    echo "Reverting to nvm default version"
    nvm use default
  fi
}
add-zsh-hook chpwd load-nvmrc
load-nvmrc
export PATH="${HOME}/.pyenv/shims:${PATH}"

# configure aws autocomplete
export AWS_DEFAULT_REGION="ap-southeast-2"

# Created by `pipx` on 2023-03-20 00:34:08
export PATH="$PATH:/Users/duong/.local/bin"

# starship prompt
eval "$(starship init zsh)"

