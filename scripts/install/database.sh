#!/usr/bin/env bash
# Setup Databases: PostgreSQL and MySQL

install_database() {
    log_header "DATABASES"

    # PostgreSQL
    if ask "Install PostgreSQL (v17)?"; then
        log_info "Checking PostgreSQL v17..."
        if ! brew list postgresql@17 &>/dev/null; then
            log_info "Installing PostgreSQL@17..."
            brew install postgresql@17
        fi
        
        log_info "Starting PostgreSQL service..."
        brew services start postgresql@17 || true
        
        # Add to PATH for current session if not already there
        export PATH="/usr/local/opt/postgresql@17/bin:$PATH"
        
        log_success "PostgreSQL 17 setup complete"
    fi

    # MySQL
    if ask "Install MySQL?"; then
        log_info "Checking MySQL..."
        if ! brew list mysql &>/dev/null; then
            log_info "Installing MySQL..."
            brew install mysql
        fi
        
        log_info "Starting MySQL service..."
        brew services start mysql || true
        
        log_success "MySQL setup complete"
    fi
}
