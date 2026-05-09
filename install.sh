#!/usr/bin/env bash
# =============================================
# Dotfiles Installer - nxhung2304 (macOS)
# Full version - Brewfile + Stow + Oh My Zsh + Plugins
# =============================================

set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$DOTFILES_DIR"

echo "🚀 Bắt đầu cài đặt dotfiles nxhung2304..."

# Colors
RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'; NC='\033[0m'

ask() {
    printf "${YELLOW}❓ $1 (y/N): ${NC}"
    read -r ans
    [[ $ans =~ ^[Yy]$ ]]
}

# ====================== XCODE ======================
if ! xcode-select -p &> /dev/null; then
    echo "🛠 Cài Xcode Command Line Tools..."
    xcode-select --install
    echo "⏳ Chờ cài xong rồi nhấn Enter..."
    read -r
fi

# ====================== HOMEBREW ======================
if ! command -v brew &> /dev/null; then
    echo "🍺 Cài Homebrew..."
    if ask "Cài Homebrew ngay?"; then
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi
fi

# Fix PATH cho Apple Silicon
if [ -f "/opt/homebrew/bin/brew" ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
elif [ -f "/usr/local/bin/brew" ]; then
    eval "$(/usr/local/bin/brew shellenv)"
fi

# ====================== BREWFILE ======================
echo "📦 Cài packages từ Brewfile..."
brew update
if ask "Chạy brew bundle install?"; then
    brew bundle install --verbose
fi

# ====================== ASDF ======================
echo "🔌 Thiết lập asdf plugins..."
asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git || true
asdf plugin add python || true
asdf plugin add ruby https://github.com/asdf-vm/asdf-ruby.git || true

echo "💡 Lưu ý: Sau khi cài xong, bạn cần chạy lệnh sau để cài Node.js:"

# ====================== SYMLINK ======================
echo "🔗 Tạo symbolic links..."

if ask "Tạo backup config cũ trước khi stow?"; then
    BACKUP_DIR="$HOME/.dotfiles-backup/$(date +%Y%m%d-%H%M%S)"
    mkdir -p "$BACKUP_DIR"
    echo "📦 Backup vào: $BACKUP_DIR"
    cp -r ~/.config/nvim ~/.config/karabiner ~/.zshrc ~/.tmux.conf "$BACKUP_DIR/" 2>/dev/null || true
fi

brew install stow || true

stow --restow --target="$HOME" --verbose .config 2>&1 | tee stow-config.log

for dir in .claude .codex .gemini scripts; do
    if [ -d "$dir" ]; then
        stow --restow --target="$HOME" --verbose "$dir" 2>&1 | tee "stow-$dir.log" || true
    fi
done

# .env
if [ ! -f "$HOME/.env" ] && [ -f ".env.sample" ]; then
    if ask "Copy .env.sample → ~/.env?"; then
        cp "$DOTFILES_DIR/.env.sample" ~/.env
    fi
fi

# ====================== OH MY ZSH ======================
echo "🐚 Thiết lập Oh My Zsh (tùy chọn - starship là prompt chính)..."
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    if ask "Cài Oh My Zsh framework?"; then
        sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
        # Symlink .zshrc lại sau khi Oh My Zsh install
        ln -sf "$DOTFILES_DIR/.zshrc" ~/.zshrc
    fi
fi

# ====================== ZSH PLUGINS ======================
echo "🔌 Cài Oh My Zsh plugins..."
ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"
mkdir -p "$ZSH_CUSTOM/plugins"

for plugin in zsh-autosuggestions zsh-syntax-highlighting; do
    if [ ! -d "$ZSH_CUSTOM/plugins/$plugin" ]; then
        git clone --depth=1 "https://github.com/zsh-users/$plugin" "$ZSH_CUSTOM/plugins/$plugin"
    fi
done

# ====================== STARSHIP ======================
echo "⭐ Cài Starship prompt..."
sudo mkdir -p /usr/local/bin
sudo chmod 755 /usr/local/bin
curl -sS https://starship.rs/install.sh | sh


# ====================== TMUX TPM ======================
if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
    if ask "Cài Tmux Plugin Manager (TPM)?"; then
        git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
    fi
fi

# ====================== TMUX SCRIPTS ======================
echo "🔗 Tạo symlink cho tmux scripts..."
mkdir -p "$HOME/.local/bin/scripts"
ln -sf "$DOTFILES_DIR/scripts/tmux-sessionizer" "$HOME/.local/bin/scripts/tmux-sessionizer"
chmod +x "$DOTFILES_DIR/scripts/tmux-sessionizer"

# ====================== FINAL ======================
echo -e "${GREEN}✅ Cài đặt dotfiles hoàn tất!${NC}"
echo ""
echo "Các bước tiếp theo:"
echo "1. source ~/.zshrc"
echo "2. asdf install nodejs latest && asdf global nodejs latest"
echo "3. asdf install python latest && asdf global python latest   (nếu cần)"
echo "4. Mở Karabiner-Elements → Enable"
echo "5. Neovim → :Lazy sync"
echo "6. tmux → Prefix + I"
echo ""
echo "Chúc bạn code vui! 🔥"
