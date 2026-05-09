#!/usr/bin/env bash
# Install and setup Starship prompt

install_starship() {
    log_header "STARSHIP"

    echo "⭐ Installing Starship prompt..."
    sudo mkdir -p /usr/local/bin
    sudo chmod 755 /usr/local/bin
    curl -sS https://starship.rs/install.sh | sh

    echo "🔗 Creating symlinks for starship config..."
    mkdir -p "$HOME/.config"
    ln -sf "$DOTFILES_DIR/.config/starship.toml" "$HOME/.config/starship.toml"

    log_success "Starship installed"
}
