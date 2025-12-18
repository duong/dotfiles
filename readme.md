# duong's dotfiles

![Screenshot of a comment on a GitHub issue showing an image, added in the Markdown, of an Octocat smiling and raising a tentacle.](/screenshot.png)

## Requirements

1. Install brew https://brew.sh/
1. Install dependencies

- `sudo pacman -Syu unzip zsh zsh-completions ttf-space-mono-nerd bottom lazygit dotnet-runtime dotnet-sdk ripgrep`
- nvm
  - with npm installed
- zsh
  - zplug
  - oh-my-zsh
  - starship

3. Install stuff with brew
```bash
xargs brew tap < brew.taps
xargs brew install < brew.list
xargs brew install --cask < brew.list.casks
```

## Setup

Run the install script to create symbolic links:

```bash
./install.sh
```

This will symlink all config files to the appropriate locations, backing up any existing files.

Check startup time of neovim

```bash
nvim --startuptime somefile
```

Macos extra steps

1. Install developer tools
1. Set keyboard shortcuts for switching between desktops (keyboard -> keyboard shortcuts -> mission control)
1. Set Reduce Motion in display accessibility settings
1. Install fonts with brew --cask
1. brew services start borders

