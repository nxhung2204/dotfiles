#!/usr/bin/env bash
# Setup ASDF and install runtime versions

install_asdf() {
    log_header "ASDF"

    echo "🔌 Setting up ASDF plugins..."
    log_info "Adding Node.js plugin..."
    asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git || true
    log_info "Adding Python plugin..."
    asdf plugin add python || true
    log_info "Adding Ruby plugin..."
    asdf plugin add ruby https://github.com/asdf-vm/asdf-ruby.git || true
    log_info "Adding Java plugin..."
    asdf plugin add java https://github.com/halcyon/asdf-java.git || true

    if ask "Install Node.js 22.22.2 (LTS)?"; then
        log_info "Installing Node.js 22.22.2..."
        asdf install nodejs 22.22.2
        asdf set -u nodejs 22.22.2
        # Enable corepack for yarn and pnpm (standard in modern Node.js)
        corepack enable
        log_success "Node.js 22.22.2 installed (Yarn and PNPM enabled via Corepack)"
    fi

    if ask "Install Python 3.13.3?"; then
        log_info "Installing Python 3.13.3..."
        asdf install python 3.13.3
        asdf set -u python 3.13.3
        log_success "Python 3.13.3 installed"
    fi

    if ask "Install Ruby 3.3.11?"; then
        log_info "Installing Ruby 3.3.11..."
        if command -v brew &>/dev/null; then
            brew list libyaml &>/dev/null || brew install libyaml
            export RUBY_CONFIGURE_OPTS="--with-libyaml-dir=$(brew --prefix libyaml)"
        fi
        asdf install ruby 3.3.11
        asdf set -u ruby 3.3.11
        log_success "Ruby 3.3.11 installed"
    fi

    if ask "Install Java (Temurin 17)?"; then
        log_info "Installing Java (Temurin 17)..."
        asdf install java openjdk-17
        asdf set -u java openjdk-17
        log_success "Java 17 installed"
    fi
}
