# Conditionally load dotfiles based on OS
if [[ $(uname) == "Darwin" ]]; then
  # add brew binaries to path
  export PATH="/opt/homebrew/bin:$PATH"
fi

# set nvm dir
export NVM_DIR="$HOME/.nvm"

# init pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"

