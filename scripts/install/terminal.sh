#!/usr/bin/env bash
# Setup Terminal & UI: Tmux, AeroSpace, SketchyBar

install_terminal() {
    log_header "TERMINAL & UI"

    # 1. Tmux & TPM
    echo "🪟 Setting up Tmux..."
    if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
        if ask "Install Tmux Plugin Manager (TPM)?"; then
            git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
            log_success "TPM installed"
        fi
    else
        log_success "TPM already installed"
    fi

    echo "🔗 Linking Tmux config..."
    ln -sf "$DOTFILES_DIR/.tmux.conf" "$HOME/.tmux.conf"
    rm -rf "$HOME/.config/tmux" && ln -sf "$DOTFILES_DIR/.config/tmux" "$HOME/.config/tmux"
    
    mkdir -p "$HOME/.local/bin/scripts"
    ln -sf "$DOTFILES_DIR/scripts/tmux-sessionizer" "$HOME/.local/bin/scripts/tmux-sessionizer"
    chmod +x "$DOTFILES_DIR/scripts/tmux-sessionizer"

    # 2. Window Manager (AeroSpace + SketchyBar)
    echo "🖥️ Setting up Window Manager..."
    if ! brew list --cask nikitabobko/tap/aerospace &>/dev/null; then
        if ask "Install AeroSpace (tiling window manager)?"; then
            brew install --cask nikitabobko/tap/aerospace
        fi
    fi

    if ! brew list sketchybar &>/dev/null; then
        if ask "Install SketchyBar (custom menu bar)?"; then
            brew tap FelixKratz/formulae
            brew install sketchybar
        fi
    fi

    echo "🔗 Linking WM configs..."
    mkdir -p "$HOME/.config/aerospace"
    ln -sf "$DOTFILES_DIR/.config/aerospace/aerospace.toml" "$HOME/.config/aerospace/aerospace.toml"

    if ask "Start AeroSpace and SketchyBar now?"; then
        open -a AeroSpace 2>/dev/null || log_info "Open AeroSpace manually"
        brew services start sketchybar 2>/dev/null || log_info "Start sketchybar manually"
    fi

    log_success "Terminal and UI setup complete"
}
