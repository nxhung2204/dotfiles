#!/usr/bin/env bash
# Setup Oh My Zsh and plugins

install_omz() {
    log_header "OH MY ZSH"

    echo "🐚 Setting up Oh My Zsh (optional - starship is primary prompt)..."
    if [ ! -d "$HOME/.oh-my-zsh" ]; then
        if ask "Install Oh My Zsh framework?"; then
            sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
            ln -sf "$DOTFILES_DIR/.zshrc" ~/.zshrc
            log_success "Oh My Zsh installed"
        else
            log_info "Oh My Zsh installation skipped"
            return 0
        fi
    else
        log_success "Oh My Zsh already installed"
    fi

    echo "🔗 Creating symlinks for zsh config..."
    ln -sf "$DOTFILES_DIR/.zshrc" "$HOME/.zshrc"

    # Install plugins only if Oh My Zsh is present
    if [ -d "$HOME/.oh-my-zsh" ]; then
        echo "🔌 Installing Oh My Zsh plugins..."
        ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"
        mkdir -p "$ZSH_CUSTOM/plugins"

        for plugin in zsh-autosuggestions zsh-syntax-highlighting; do
            if [ ! -d "$ZSH_CUSTOM/plugins/$plugin" ]; then
                git clone --depth=1 "https://github.com/zsh-users/$plugin" "$ZSH_CUSTOM/plugins/$plugin"
            fi
        done
        log_success "Zsh plugins installed"
    fi
}
