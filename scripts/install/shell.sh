#!/usr/bin/env bash
# Setup Shell environment: Oh My Zsh, Starship, and Direnv

install_shell() {
    log_header "SHELL ENVIRONMENT"

    # 1. Oh My Zsh
    echo "🐚 Setting up Oh My Zsh..."
    if [ ! -d "$HOME/.oh-my-zsh" ]; then
        if ask "Install Oh My Zsh framework?"; then
            sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
            ln -sf "$DOTFILES_DIR/.zshrc" ~/.zshrc
            log_success "Oh My Zsh installed"
        else
            log_info "Oh My Zsh installation skipped"
        fi
    else
        log_success "Oh My Zsh already installed"
    fi

    # 2. Zsh Plugins
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

    # 3. Starship Prompt
    echo "⭐ Setting up Starship prompt..."
    if ! command -v starship &>/dev/null; then
        sudo mkdir -p /usr/local/bin
        sudo chmod 755 /usr/local/bin
        curl -sS https://starship.rs/install.sh | sh
        log_success "Starship installed"
    else
        log_success "Starship already installed"
    fi
    ln -sf "$DOTFILES_DIR/.config/starship.toml" "$HOME/.config/starship.toml"

    # 4. Direnv
    echo "🔐 Setting up direnv..."
    if ! grep -q "direnv hook" ~/.zshrc; then
        echo 'eval "$(direnv hook zsh)"' >> ~/.zshrc
        log_success "Direnv hook added to .zshrc"
    else
        log_info "Direnv hook already in .zshrc"
    fi
}
