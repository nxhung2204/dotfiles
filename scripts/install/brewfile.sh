#!/usr/bin/env bash
# Install packages from Brewfile

install_brewfile() {
    log_header "BREWFILE"

    echo "📦 Installing packages from Brewfile..."
    brew update

    if ask "Run brew bundle install?"; then
        brew bundle install --verbose
        log_success "Brewfile packages installed"
    else
        log_info "Brewfile installation skipped"
    fi
}
