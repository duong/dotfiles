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
│   ├── lazygit/        # Git TUI
│   ├── amp/            # Amp AI config
│   ├── starship.toml   # Prompt config
│   ├── aerospace/      # macOS window manager
│   ├── sketchybar/     # macOS status bar
│   ├── qtile/          # Linux window manager
│   └── rofi/           # Linux launcher
└── ssh/config          # SSH hosts
```

## Conventions

- Use `$HOME` instead of hardcoded paths like `/Users/duong`
- OS-specific configs go in `.darwin.zsh` or `.linux.zsh`
- Machine-specific secrets go in `~/.env.local` (not tracked)
- Neovim uses lazy.nvim with plugins in `config/nvim/lua/plugins/`
- Kitty includes OS-specific configs via `${KITTY_OS}.conf`

## Dependency Injection Best Practices

- **"New is glue"**: Avoid using `new` to create dependencies inside classes/functions. Instead, inject dependencies via constructor or function parameters
- **Invert control when complexity grows**: Start simple, refactor to DI when code evolves and tight coupling causes maintenance issues
- **Use interfaces**: Accept interface types rather than concrete implementations to allow swapping implementations (real vs fake/mock)
- **Flatten call trees**: Don't pass parameters through multiple layers; inject pre-built dependencies at the call site
- **Avoid React Context**: It's an anti-pattern at Canva. Use `React.children` or inject components as props instead
- **Hybrid React pattern**: Inject required components as props (e.g., `<Section Header={headerImpl}>`) rather than prop drilling

```typescript
// ❌ Tightly coupled
class Presenter {
  private service = new HttpClient();
}

// ✅ Dependency injection
class Presenter {
  constructor(private readonly service: ServiceInterface) {}
}
```

## Testing Changes

```bash
# Validate shell syntax
zsh -n ~/.zshrc

# Validate lua syntax
nvim --headless -c "luafile config/nvim/init.lua" -c "q"

# Check install script
bash -n install.sh
```
