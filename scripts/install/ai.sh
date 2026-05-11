#!/usr/bin/env bash
# Setup AI CLI Tools: Gemini, Claude, and Codex

install_ai() {
    log_header "AI TOOLS"

    # --- Gemini ---
    echo "🤖 Setting up Gemini CLI..."
    if ! command -v gemini &>/dev/null; then
        if ask "Install Gemini CLI (requires Node.js)?"; then
            npm install -g @google/gemini-cli
            log_success "Gemini CLI installed"
        fi
    else
        log_success "Gemini CLI already installed"
    fi

    echo "🔗 Creating symlinks for Gemini config..."
    mkdir -p "$HOME/.gemini"
    ln -sf "$DOTFILES_DIR/.gemini/settings.json" "$HOME/.gemini/settings.json"
    rm -rf "$HOME/.gemini/skills" && ln -sf "$DOTFILES_DIR/.gemini/skills" "$HOME/.gemini/skills"

    # --- Codex ---
    echo "💻 Setting up Codex CLI..."
    if ! command -v codex &>/dev/null; then
        if ask "Install Codex CLI (requires Node.js)?"; then
            npm install -g @openai/codex
            log_success "Codex CLI installed"
        fi
    else
        log_success "Codex CLI already installed"
    fi

    echo "🔗 Creating symlinks for Codex config..."
    mkdir -p "$HOME/.codex"
    ln -sf "$DOTFILES_DIR/.codex/config.toml" "$HOME/.codex/config.toml"
    rm -rf "$HOME/.codex/rules" && ln -sf "$DOTFILES_DIR/.codex/rules" "$HOME/.codex/rules"
    rm -rf "$HOME/.codex/skills" && ln -sf "$DOTFILES_DIR/.codex/skills" "$HOME/.codex/skills"

    # --- Claude ---
    echo "🛡️ Setting up Claude Code config..."
    # (Claude binary is installed via Brewfile)
    mkdir -p "$HOME/.claude"
    for item in settings.json CLAUDE.md commands agents skills code-rules statusline-command.sh; do
        rm -rf "$HOME/.claude/$item"
        ln -sf "$DOTFILES_DIR/.claude/$item" "$HOME/.claude/$item"
    done

    log_success "AI tools setup complete"
}
