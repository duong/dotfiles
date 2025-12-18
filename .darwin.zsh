# Set python path
export PATH="/opt/homebrew/bin/python3:$PATH"

# zplug setup
export ZPLUG_HOME=$(brew --prefix)/opt/zplug
source $ZPLUG_HOME/init.zsh

# add brew binaries to path
export PATH="/opt/homebrew/bin:$PATH"

# make Homebrew’s completions available in zsh
if type brew &>/dev/null; then
  FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
  autoload -Uz compinit
  compinit
fi

# Make python do python3
# export PATH="/opt/homebrew/opt/python@3.11/libexec/bin:$PATH"

# Add DBeaver to path
export PATH="${PATH}:/Applications/DBeaver.app/Contents/MacOS"

# bind left and right keys
bindkey "\e[1;3D" backward-word # ⌥←
bindkey "\e[1;3C" forward-word # ⌥→

# setup grc for colorising
source "${HOME}/dotfiles/grc.zsh"

# need to logout for changes to take effect
defaults write -g InitialKeyRepeat -int 14 # normal minimum is 14 (225 ms)
defaults write -g KeyRepeat -int 2 # normal minimum is 2 (30 ms)

# Manually specify which python version to use. We cannot update 
# the python version using homebrew until the default mac version of python is updated
# https://apple.stackexchange.com/questions/450303/how-to-make-python-3-11-my-default-python3-with-brew
export PATH="$(brew --prefix)/opt/python@3.10/libexec/bin:$PATH"

# Add .NET Core SDK tools
export PATH="$PATH:$HOME/.dotnet/tools"

# Set XDG_CONFIG_HOME to .config for mac
export XDG_CONFIG_HOME="$HOME/.config"

