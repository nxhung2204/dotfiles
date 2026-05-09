#!/usr/bin/env bash
# Install and setup Homebrew

install_homebrew() {
    log_header "HOMEBREW"

    if command -v brew &> /dev/null; then
        log_success "Homebrew already installed"
    else
        echo "🍺 Installing Homebrew..."
        if ask "Install Homebrew now?"; then
            /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        else
            log_error "Homebrew installation skipped"
            return 1
        fi
    fi

    # Fix PATH for Apple Silicon
    if [ -f "/opt/homebrew/bin/brew" ]; then
        eval "$(/opt/homebrew/bin/brew shellenv)"
    elif [ -f "/usr/local/bin/brew" ]; then
        eval "$(/usr/local/bin/brew shellenv)"
    fi

    log_success "Homebrew ready"
}
