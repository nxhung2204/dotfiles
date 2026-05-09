#!/usr/bin/env bash
# Install and setup Google Gemini CLI

install_gemini() {
    log_header "GEMINI CLI"

    if command -v gemini &>/dev/null; then
        log_success "Gemini CLI already installed"
        return
    fi

    if ask "Install Gemini CLI (requires Node.js)?"; then
        npm install -g @google/gemini-cli
        log_success "Gemini CLI installed"
    fi

    echo "🔗 Creating symlinks for gemini config..."
    mkdir -p "$HOME/.gemini"
    ln -sf "$DOTFILES_DIR/.gemini/settings.json" "$HOME/.gemini/settings.json"
    rm -rf "$HOME/.gemini/skills" && ln -sf "$DOTFILES_DIR/.gemini/skills" "$HOME/.gemini/skills"

    log_success "Gemini setup complete"
}
