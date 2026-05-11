#!/usr/bin/env bash
# Setup Vim with vim-plug and symlink config

install_vim() {
    log_header "VIM"

    log_info "Creating symlink for vim config..."
    ln -sf "$DOTFILES_DIR/.vimrc" "$HOME/.vimrc"
    log_success "Symlink created: ~/.vimrc"

    if [ ! -f "$HOME/.vim/autoload/plug.vim" ]; then
        if ask "Install vim-plug (Vim plugin manager)?"; then
            log_info "Installing vim-plug..."
            curl -fLo "$HOME/.vim/autoload/plug.vim" --create-dirs \
                https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
            log_success "vim-plug installed"
        fi
    else
        log_success "vim-plug already installed"
    fi

    log_success "Vim setup complete"
}
