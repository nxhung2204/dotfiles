#!/usr/bin/env bash
# Install and setup OpenAI Codex CLI

install_codex() {
    log_header "CODEX CLI"

    if command -v codex &>/dev/null; then
        log_success "Codex CLI already installed"
        return
    fi

    if ask "Install Codex CLI (requires Node.js)?"; then
        npm install -g @openai/codex
        log_success "Codex CLI installed"
    fi

    echo "🔗 Creating symlinks for codex config..."
    mkdir -p "$HOME/.codex"
    ln -sf "$DOTFILES_DIR/.codex/config.toml" "$HOME/.codex/config.toml"
    rm -rf "$HOME/.codex/rules" && ln -sf "$DOTFILES_DIR/.codex/rules" "$HOME/.codex/rules"
    rm -rf "$HOME/.codex/skills" && ln -sf "$DOTFILES_DIR/.codex/skills" "$HOME/.codex/skills"

    log_success "Codex setup complete"
}
