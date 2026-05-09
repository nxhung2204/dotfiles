#!/usr/bin/env bash
# Setup Claude Code CLI config via symlinks

install_claude() {
    log_header "CLAUDE CODE"

    echo "🔗 Creating symlinks for Claude Code config..."
    mkdir -p "$HOME/.claude"

    for item in settings.json CLAUDE.md commands agents skills code-rules statusline-command.sh; do
        rm -rf "$HOME/.claude/$item"
        ln -sf "$DOTFILES_DIR/.claude/$item" "$HOME/.claude/$item"
    done

    log_success "Claude Code setup complete"
}
