#!/usr/bin/env bash
# Setup Window Manager: AeroSpace + Borders

install_wm() {
    log_header "WINDOW MANAGER"

    if ! brew list --cask nikitabobko/tap/aerospace &>/dev/null; then
        if ask "Install AeroSpace (tiling window manager)?"; then
            brew install --cask nikitabobko/tap/aerospace
            log_success "AeroSpace installed"
        fi
    else
        log_success "AeroSpace already installed"
    fi

    if ! brew list borders &>/dev/null; then
        if ask "Install Borders (window border highlight)?"; then
            brew tap FelixKratz/formulae
            brew install borders
            log_success "Borders installed"
        fi
    else
        log_success "Borders already installed"
    fi

    echo "🔗 Creating symlinks for aerospace and borders..."
    mkdir -p "$HOME/.config/aerospace"
    mkdir -p "$HOME/.config/borders"

    ln -sf "$DOTFILES_DIR/.config/aerospace/aerospace.toml" "$HOME/.config/aerospace/aerospace.toml"
    ln -sf "$DOTFILES_DIR/.config/borders/bordersrc" "$HOME/.config/borders/bordersrc"

    log_success "Window manager symlinks created"

    if ask "Start AeroSpace and Borders now?"; then
        open -a AeroSpace 2>/dev/null || log_info "Open AeroSpace manually from Applications"
        brew services start borders 2>/dev/null || log_info "Start borders manually: borders &"
    fi

    log_success "Window manager setup complete"
}
