#!/usr/bin/env bash
# Install Xcode Command Line Tools

install_xcode() {
    log_header "XCODE"

    if xcode-select -p &> /dev/null; then
        log_success "Xcode Command Line Tools already installed"
        return 0
    fi

    echo "🛠 Installing Xcode Command Line Tools..."
    xcode-select --install
    echo "⏳ Wait for installation to complete, then press Enter..."
    read -r
}
