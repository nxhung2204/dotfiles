#!/usr/bin/env bash
# Install and setup Starship prompt

install_starship() {
    log_header "STARSHIP"

    echo "⭐ Installing Starship prompt..."
    sudo mkdir -p /usr/local/bin
    sudo chmod 755 /usr/local/bin
    curl -sS https://starship.rs/install.sh | sh

    log_success "Starship installed"
}
