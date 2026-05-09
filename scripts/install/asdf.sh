#!/usr/bin/env bash
# Setup ASDF and install runtime versions

install_asdf() {
    log_header "ASDF"

    echo "🔌 Setting up ASDF plugins..."
    asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git || true
    asdf plugin add python || true
    asdf plugin add ruby https://github.com/asdf-vm/asdf-ruby.git || true

    if ask "Install Node.js latest version?"; then
        asdf install nodejs latest
        asdf global nodejs latest
        log_success "Node.js installed"
    fi

    if ask "Install Python latest version?"; then
        asdf install python latest
        asdf global python latest
        log_success "Python installed"
    fi

    if ask "Install Ruby latest version?"; then
        asdf install ruby latest
        asdf global ruby latest
        log_success "Ruby installed"
    fi
}
