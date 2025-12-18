# duong's dotfiles

![Screenshot](/screenshot.png)

## Quick Start

```bash
git clone git@github.com:duong/dotfiles.git ~/dotfiles
cd ~/dotfiles
./install.sh
```

The install script is **idempotent** (safe to run multiple times) and will:
- Create symlinks for all configs (backs up existing files once)
- Detect OS and install platform-specific configs (aerospace/sketchybar for macOS, qtile/rofi for Linux)
- Create `~/.env.local` for machine-specific secrets

## Requirements

| Tool | Install |
|------|---------|
| zsh | Default on macOS, `pacman -S zsh` on Arch |
| [oh-my-zsh](https://ohmyz.sh/) | `sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"` |
| [zplug](https://github.com/zplug/zplug) | `brew install zplug` or see repo |
| [starship](https://starship.rs/) | `brew install starship` or `curl -sS https://starship.rs/install.sh \| sh` |
| [nvm](https://github.com/nvm-sh/nvm) | `curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh \| bash` |

## What's Included

```
~/.zshrc          → shell config
~/.config/nvim    → neovim
~/.config/kitty   → terminal
~/.config/lazygit → git TUI
~/.config/amp     → amp AI
~/.config/starship.toml → prompt
~/.ssh/config     → ssh hosts
~/.env.local      → secrets (not tracked)
```

## Secrets

Add machine-specific secrets to `~/.env.local` (created from `.env.template`):

```bash
export OPENAI_API_KEY="..."
export GITHUB_TOKEN="..."
```

## macOS Extras

```bash
xcode-select --install
brew services start borders
```

