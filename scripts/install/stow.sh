#!/usr/bin/env bash
# Setup symlinks with stow

install_stow() {
    log_header "SYMLINK"

    if ask "Create backup of old config before stow?"; then
        BACKUP_DIR="$HOME/.dotfiles-backup/$(date +%Y%m%d-%H%M%S)"
        mkdir -p "$BACKUP_DIR"
        echo "📦 Backup location: $BACKUP_DIR"
        cp -r ~/.config/nvim ~/.config/karabiner ~/.config/wezterm ~/.zshrc ~/.tmux.conf ~/.gitconfig ~/.vimrc 2>/dev/null || true
        mv ~/.* "$BACKUP_DIR/" 2>/dev/null || true
    fi

    brew install stow || true

    echo "🔗 Creating symlinks with stow..."
    stow --restow --target="$HOME" --verbose .config 2>&1 | tee stow-config.log

    for dir in .claude .codex .gemini scripts; do
        if [ -d "$dir" ]; then
            stow --restow --target="$HOME" --verbose "$dir" 2>&1 | tee "stow-$dir.log" || true
        fi
    done

    log_success "Symlinks created"

    # .env setup
    if [ ! -f "$HOME/.env" ] && [ -f ".env.sample" ]; then
        if ask "Copy .env.sample → ~/.env?"; then
            cp "$DOTFILES_DIR/.env.sample" ~/.env
            log_success ".env created"
        fi
    fi
}
