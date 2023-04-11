# Set python path
export PATH="/opt/homebrew/bin/python3:$PATH"

# zplug brew stuff
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

# nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Add DBeaver to path
export PATH="${PATH}:/Applications/DBeaver.app/Contents/MacOS"

# bind left and right keys
bindkey "\e[1;3D" backward-word # ⌥←
bindkey "\e[1;3C" forward-word # ⌥→

