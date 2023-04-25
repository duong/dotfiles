# duong's dotfiles

## Requirements

- `sudo pacman -Syu zsh zsh-completions ttf-space-mono-nerd`
- astronvim
- nvm
- zsh
  - zplug
  - oh-my-zsh
- fish
  - omf
  - starship

## Setup

Create symbolic links to use the config

```bash
cp .zshrc .zprofile .linux.zsh ~
ln -s ~/dotfiles/.zshrc ~/.zshrc
ln -s ~/dotfiles/.zprofile ~/.zprofile
ln -s ~/dotfiles/.linux.zsh ~/.linux.zsh
ln -s ~/dotfiles/config/starship.toml ~/.config/starship.toml
ln -s ~/dotfiles/config/kitty ~/.config/kitty
ln -s ~/dotfiles/config/nvim/lua/user ~/.config/nvim/lua/user
```

