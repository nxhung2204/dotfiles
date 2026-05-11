#!/usr/bin/env bash
# Setup Editors: Xcode, VS Code, Sublime Text, Android Studio

install_editors() {
    log_header "EDITORS"

    # 1. Xcode Command Line Tools
    log_info "Checking Xcode Command Line Tools..."
    if xcode-select -p &> /dev/null; then
        log_success "Xcode Command Line Tools already installed"
    else
        echo "🛠 Installing Xcode Command Line Tools..."
        xcode-select --install
        echo "⏳ Wait for installation to complete, then press Enter..."
        read -r
    fi

    # 2. Visual Studio Code
    log_info "Checking Visual Studio Code..."
    if [ -d "/Applications/Visual Studio Code.app" ] || command -v code &>/dev/null; then
        log_success "Visual Studio Code already installed"
    else
        if ask "Install Visual Studio Code?"; then
            log_info "Installing VS Code..."
            brew install --cask visual-studio-code
            log_success "VS Code installed"
        fi
    fi

    # 3. Sublime Text
    log_info "Checking Sublime Text..."
    if [ -d "/Applications/Sublime Text.app" ]; then
        log_success "Sublime Text already installed"
    else
        if ask "Install Sublime Text?"; then
            log_info "Installing Sublime Text..."
            brew install --cask sublime-text
            log_success "Sublime Text installed"
        fi
    fi

    # 4. Android Studio
    log_info "Checking Android Studio..."
    if [ -d "/Applications/Android Studio.app" ]; then
        log_success "Android Studio already installed"
    else
        if ask "Install Android Studio?"; then
            log_info "Installing Android Studio..."
            brew install --cask android-studio
            log_success "Android Studio installed"
        fi
    fi
}
