#!/usr/bin/env bash
# Setup ASDF and install runtime versions

# Version Pinnings
# Node.js 22.22.2 (LTS) - Released: 2026-03-24
# Release: https://github.com/nodejs/node/releases/tag/v22.22.2
NODE_VERSION="22.22.2"

# Python 3.13.3 - Released: 2025-04-08
# Release: https://github.com/python/cpython/releases/tag/v3.13.3
PYTHON_VERSION="3.13.3"

# Ruby 3.3.11 - Released: 2026-03-26
# Release: https://github.com/ruby/ruby/releases/tag/v3_3_11
RUBY_VERSION="3.3.11"

# Java (Temurin 17) - Released: 2026-04-22
# Release: https://github.com/adoptium/temurin17-binaries/releases/tag/jdk-17.0.19+10
JAVA_VERSION="openjdk-17"

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

    if ask "Install Node.js $NODE_VERSION (LTS)?"; then
        log_info "Installing Node.js $NODE_VERSION..."
        asdf install nodejs "$NODE_VERSION"
        asdf set -u nodejs "$NODE_VERSION"
        # Enable corepack for yarn and pnpm (standard in modern Node.js)
        corepack enable
        log_success "Node.js $NODE_VERSION installed (Yarn and PNPM enabled via Corepack)"
    fi

    if ask "Install Python $PYTHON_VERSION?"; then
        log_info "Installing Python $PYTHON_VERSION..."
        asdf install python "$PYTHON_VERSION"
        asdf set -u python "$PYTHON_VERSION"
        log_success "Python $PYTHON_VERSION installed"
    fi

    if ask "Install Ruby $RUBY_VERSION?"; then
        log_info "Installing Ruby $RUBY_VERSION..."
        if command -v brew &>/dev/null; then
            brew list libyaml &>/dev/null || brew install libyaml
            export RUBY_CONFIGURE_OPTS="--with-libyaml-dir=$(brew --prefix libyaml)"
        fi
        asdf install ruby "$RUBY_VERSION"
        asdf set -u ruby "$RUBY_VERSION"
        log_success "Ruby $RUBY_VERSION installed"
    fi

    if ask "Install Java ($JAVA_VERSION)?"; then
        log_info "Installing Java ($JAVA_VERSION)..."
        asdf install java "$JAVA_VERSION"
        asdf set -u java "$JAVA_VERSION"
        log_success "Java $JAVA_VERSION installed"
    fi
}
