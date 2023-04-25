# Init zplug
source ~/.zplug/init.zsh

# Setup arch
if [[ -n $(uname -r | grep 'arch') ]]; then
  source ~/config-arch.sh
fi

