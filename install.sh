#!/usr/bin/env bash
# =============================================
# Dotfiles Installer - nxhung2304 (macOS)
# Modular installer with optional components
# =============================================

set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$DOTFILES_DIR"

echo "🚀 Starting dotfiles installation for nxhung2304..."

# Source common functions and modules
source scripts/install/common.sh
source scripts/install/xcode.sh
source scripts/install/homebrew.sh
source scripts/install/brewfile.sh
source scripts/install/asdf.sh
source scripts/install/direnv.sh
source scripts/install/stow.sh
source scripts/install/omz.sh
source scripts/install/starship.sh
source scripts/install/tmux.sh
source scripts/install/wm.sh
source scripts/install/codex.sh
source scripts/install/gemini.sh
source scripts/install/vim.sh
source scripts/install/claude.sh

# ====================== INSTALLATION FLOW ======================
install_xcode
install_homebrew
install_brewfile
install_asdf
install_direnv
install_stow
install_omz
install_starship
install_tmux
install_wm
install_codex
install_gemini
install_vim
install_claude

# ====================== FINAL ======================
log_header "INSTALLATION COMPLETE"
echo -e "${GREEN}✅ Dotfiles installation finished!${NC}"
echo ""
echo "📋 Next steps:"
echo "1. source ~/.zshrc"
echo "2. Open Karabiner-Elements → Enable"
echo "3. Neovim → :Lazy sync (installs plugins & language servers)"
echo "4. tmux → Prefix + I (installs TPM plugins)"
echo "5. direnv allow . (if using .envrc files)"
echo ""
echo "Happy coding! 🔥"
