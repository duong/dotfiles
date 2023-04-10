# duong's dotfiles

## Requirements

- `sudo pacman -Syu zsh zsh-completions ttf-space-mono-nerd`
- astronvim
- nvm
- zplug
- oh-my-zsh

## Setup

Create symbolic links to use the config

```bash
ln -s ~/dotfiles/.config/nvim/lua/user ~/.config/nvim/lua/user
```

```bash
ln -s ~/dotfiles/.config/kitty ~/.config/kitty
```

```bash
cp .zshrc .zprofile .linux.zsh ~
```
