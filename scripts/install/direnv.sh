#!/usr/bin/env bash
# Setup direnv integration

install_direnv() {
    log_header "DIRENV"

    echo "🔐 Setting up direnv..."
    if ! grep -q "direnv hook" ~/.zshrc; then
        echo 'eval "$(direnv hook zsh)"' >> ~/.zshrc
        log_success "Direnv hook added to .zshrc"
    else
        log_info "Direnv hook already in .zshrc"
    fi
}
