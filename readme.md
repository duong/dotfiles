# duong's dotfiles

![Screenshot of a comment on a GitHub issue showing an image, added in the Markdown, of an Octocat smiling and raising a tentacle.](/screenshot.png)

## Requirements

- `sudo pacman -Syu unzip zsh zsh-completions ttf-space-mono-nerd bottom lazygit`
- astronvim
- nvm
  - with npm installed
- zsh
  - zplug
  - oh-my-zsh
  - starship
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
ln -s ~/dotfiles/.lazy.zsh ~/.lazy.zsh
ln -s ~/dotfiles/config/starship.toml ~/.config/starship.toml
ln -s ~/dotfiles/config/kitty ~/.config/kitty
ln -s ~/dotfiles/config/nvim/lua/user ~/.config/nvim/lua/user
```
