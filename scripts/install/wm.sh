#!/usr/bin/env bash
# Setup Window Manager: AeroSpace + SketchyBar

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

    if ! brew list sketchybar &>/dev/null; then
        if ask "Install SketchyBar (custom menu bar)?"; then
            brew tap FelixKratz/formulae
            brew install sketchybar
            log_success "SketchyBar installed"
        fi
    else
        log_success "SketchyBar already installed"
    fi

    log_info "Creating symlinks for aerospace..."
    mkdir -p "$HOME/.config/aerospace"

    ln -sf "$DOTFILES_DIR/.config/aerospace/aerospace.toml" "$HOME/.config/aerospace/aerospace.toml"

    log_success "Window manager symlinks created"

    if ask "Start AeroSpace and SketchyBar now?"; then
        open -a AeroSpace 2>/dev/null || log_info "Open AeroSpace manually from Applications"
        brew services start sketchybar 2>/dev/null || log_info "Start sketchybar manually: sketchybar &"
    fi

    log_success "Window manager setup complete"
}
