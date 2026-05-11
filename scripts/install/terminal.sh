#!/usr/bin/env bash
# Setup Terminal & UI: Tmux

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

    log_success "Terminal and UI setup complete"
}
