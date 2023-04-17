# Conditionally load dotfiles based on OS
if [[ $(uname) == "Darwin" ]]; then
  # add brew binaries to path
  export PATH="/opt/homebrew/bin:$PATH"
fi

