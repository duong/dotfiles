#!/bin/bash
set -e

DOTFILES="$HOME/dotfiles"

create_symlink() {
  local src="$1"
  local dest="$2"
  
  if [ -L "$dest" ]; then
    rm "$dest"
  elif [ -e "$dest" ]; then
    if [ ! -e "$dest.backup" ]; then
      echo "Backing up existing file: $dest -> $dest.backup"
      mv "$dest" "$dest.backup"
    else
      echo "Skipping backup (already exists): $dest.backup"
      rm -rf "$dest"
    fi
  fi
  
  mkdir -p "$(dirname "$dest")"
  ln -s "$src" "$dest"
  echo "Created symlink: $dest -> $src"
}

OS="$(uname)"
echo "Installing dotfiles from $DOTFILES (detected OS: $OS)"

# Shell config
create_symlink "$DOTFILES/.zshrc" "$HOME/.zshrc"
create_symlink "$DOTFILES/.zprofile" "$HOME/.zprofile"
create_symlink "$DOTFILES/.darwin.zsh" "$HOME/.darwin.zsh"
create_symlink "$DOTFILES/.linux.zsh" "$HOME/.linux.zsh"

# Config files (cross-platform)
create_symlink "$DOTFILES/config/starship.toml" "$HOME/.config/starship.toml"
create_symlink "$DOTFILES/config/kitty" "$HOME/.config/kitty"
create_symlink "$DOTFILES/config/nvim" "$HOME/.config/nvim"
create_symlink "$DOTFILES/config/lazygit" "$HOME/.config/lazygit"
create_symlink "$DOTFILES/config/amp" "$HOME/.config/amp"

# macOS-only configs
if [ "$OS" = "Darwin" ]; then
  create_symlink "$DOTFILES/config/aerospace" "$HOME/.config/aerospace"
fi

# Linux-only configs
if [ "$OS" = "Linux" ]; then
  create_symlink "$DOTFILES/config/qtile" "$HOME/.config/qtile"
  create_symlink "$DOTFILES/config/rofi" "$HOME/.config/rofi"
fi

# SSH config
create_symlink "$DOTFILES/ssh/config" "$HOME/.ssh/config"

# Create .env.local from template if it doesn't exist
if [ ! -f "$HOME/.env.local" ]; then
  cp "$DOTFILES/.env.template" "$HOME/.env.local"
  echo "Created ~/.env.local from template - add your secrets there"
fi

echo "Done! Dotfiles installed successfully."
