# dotfiles

Personal macOS development environment configuration managed via GNU Stow.

## Requirements

- macOS
- nvim 0.11+
- tmux
- wezterm
- AeroSpace (tiling window manager)
- Borders (window border highlight)

## Quick Setup

```bash
chmod +x install.sh
./install.sh
```

The installer handles:
- Xcode CLI tools
- Homebrew + Brewfile packages
- asdf (runtime version manager)
- direnv
- GNU Stow (symlinks)
- Oh My Zsh + plugins
- Starship prompt
- Tmux Plugin Manager
- AeroSpace + Borders (window manager)

## What's Included

| Tool | Config path |
|------|-------------|
| Neovim | `.config/nvim/` |
| Tmux | `.config/tmux/` |
| Wezterm | `.config/wezterm/` |
| AeroSpace | `.config/aerospace/` |
| Borders | `.config/borders/` |
| Zsh | `.zshrc` |
| Git | `.gitconfig` |
| Starship | `.config/starship.toml` |

## Neovim

Plugin manager: **Lazy.nvim**. Key plugins:
- **snacks.nvim** — picker, explorer, notifier, image preview, input
- **nvim-cmp** — completion
- **nvim-lspconfig + mason** — LSP
- **neogit + gitsigns** — git
- **conform + nvim-lint** — formatting & linting
- **copilot.lua** — AI completion

First launch: `:Lazy sync`

## Environment Variables

```bash
cp .env.sample ~/.env
vi ~/.env
```

## Troubleshooting

- **Tmux plugins missing**: `Prefix + I` to install via TPM
- **Neovim LSP not working**: run `:Mason` to install language servers
- **Symlinks broken**: re-run `./install.sh` and choose the stow step
