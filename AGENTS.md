# Dotfiles Agent Instructions

## Overview

Personal dotfiles for macOS and Linux (Arch). Configs are symlinked from `~/dotfiles` to their respective locations.

## Key Commands

```bash
./install.sh          # Install/update all symlinks (idempotent)
source ~/.zshrc       # Reload shell config
time zsh -i -c exit   # Test shell startup time
```

## Structure

```
~/dotfiles/
├── .zshrc              # Main shell config (cross-platform)
├── .darwin.zsh         # macOS-specific shell config
├── .linux.zsh          # Linux-specific shell config
├── .env.template       # Template for machine-specific secrets
├── install.sh          # Idempotent install script
├── config/
│   ├── nvim/           # Neovim config (lazy.nvim)
│   ├── kitty/          # Kitty terminal
│   ├── aerospace/      # macOS window manager
│   ├── lazygit/        # Git TUI
│   └── amp/            # Amp AI config
└── ssh/config          # SSH hosts
```

## Conventions

- Use `$HOME` instead of hardcoded paths like `/Users/duong`
- OS-specific configs go in `.darwin.zsh` or `.linux.zsh`
- Machine-specific secrets go in `~/.env.local` (not tracked)
- Neovim uses lazy.nvim with plugins in `config/nvim/lua/plugins/`
- Kitty includes OS-specific configs via `${KITTY_OS}.conf`

## Testing Changes

```bash
# Validate shell syntax
zsh -n ~/.zshrc

# Validate lua syntax
nvim --headless -c "luafile config/nvim/init.lua" -c "q"

# Check install script
bash -n install.sh
```
