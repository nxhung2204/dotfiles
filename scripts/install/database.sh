#!/usr/bin/env bash
# Setup Databases: PostgreSQL and MySQL

install_database() {
    log_header "DATABASES"

    # PostgreSQL
    if ask "Install PostgreSQL (v17)?"; then
        if ! brew list postgresql@17 &>/dev/null; then
            echo "🐘 Installing PostgreSQL@17..."
            brew install postgresql@17
        fi
        
        echo "🚀 Starting PostgreSQL service..."
        brew services start postgresql@17 || true
        
        # Add to PATH for current session if not already there
        export PATH="/usr/local/opt/postgresql@17/bin:$PATH"
        
        log_success "PostgreSQL 17 setup complete"
    fi

    # MySQL
    if ask "Install MySQL?"; then
        if ! brew list mysql &>/dev/null; then
            echo "🐬 Installing MySQL..."
            brew install mysql
        fi
        
        echo "🚀 Starting MySQL service..."
        brew services start mysql || true
        
        log_success "MySQL setup complete"
    fi
}
