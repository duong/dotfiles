# Uncomment for speed testing (see end of file also)
# zmodload zsh/zprof
# run this to time: time zsh -i -c exit

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
alias gl='git log --all --graph --abbrev-commit --decorate --format=format:"%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(auto)%d%C(reset)"'

# Conditionally load dotfiles based on OS
if [[ $(uname) == "Darwin" ]]; then
  source ~/.darwin.zsh
elif [[ $(uname) == "Linux" ]]; then
  source ~/.linux.zsh
fi

# zsh-nvm options
export NVM_AUTO_USE=true
export NVM_LAZY_LOAD=true
export NVM_LAZY_LOAD_EXTRA_COMMANDS=('nvim')

# zplug - manage plugins
zplug "zsh-users/zsh-syntax-highlighting", defer:2
zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-completions"
zplug mafredri/zsh-async, from:github
zplug "lukechilds/zsh-nvm"

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

# configure aws autocomplete
export AWS_DEFAULT_REGION="ap-southeast-2"

# Created by `pipx` on 2023-03-20 00:34:08
export PATH="$PATH:/Users/duong/.local/bin"

# starship prompt
eval "$(starship init zsh)"

# hook direnv into shell
eval "$(direnv hook zsh)"

# setup pyenv
# export PYENV_ROOT="$HOME/.pyenv"
# command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
# eval "$(pyenv init -)"

# Uncomment for performance testing (see beginning of file)
# zprof
