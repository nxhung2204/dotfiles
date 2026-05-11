#!/usr/bin/env bash
# Setup Mobile Development: Flutter and SDKMAN!

install_mobile() {
    log_header "MOBILE DEVELOPMENT"

    # 1. Flutter (via FVM)
    echo "🐦 Setting up Flutter (FVM)..."
    if ! command -v fvm &>/dev/null; then
        if ask "Install FVM via Homebrew?"; then
            brew tap leoafarias/fvm
            brew install fvm
            log_success "FVM installed"
        fi
    else
        log_success "FVM already installed"
    fi

    if command -v fvm &>/dev/null; then
        if ask "Install Flutter stable version?"; then
            fvm install stable
            fvm global stable
            log_success "Flutter stable installed"
        fi
    fi

    # 2. SDKMAN!
    echo "☕ Setting up SDKMAN!..."
    if [ ! -d "$HOME/.sdkman" ]; then
        if ask "Install SDKMAN! (Software Development Kit Manager)?"; then
            curl -s "https://get.sdkman.io" | bash
            log_success "SDKMAN! installed"
            log_info "Note: You may need to restart your terminal or source ~/.zshrc"
        fi
    else
        log_success "SDKMAN! already installed"
    fi
}
