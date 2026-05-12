#!/usr/bin/env bash
# Setup Databases: PostgreSQL and MySQL

# Version Pinnings
# PostgreSQL 17 - Released: 2024-09-26
# Announcement: https://www.postgresql.org/about/news/postgresql-17-released-2936/
POSTGRES_VERSION="17"

install_database() {
    log_header "DATABASES"

    # PostgreSQL
    if ask "Install PostgreSQL (v$POSTGRES_VERSION)?"; then
        log_info "Checking PostgreSQL v$POSTGRES_VERSION..."
        if ! brew list "postgresql@$POSTGRES_VERSION" &>/dev/null; then
            log_info "Installing postgresql@$POSTGRES_VERSION..."
            brew install "postgresql@$POSTGRES_VERSION"
        fi
        
        log_info "Starting PostgreSQL service..."
        brew services start "postgresql@$POSTGRES_VERSION" || true
        
        # Add to PATH for current session if not already there
        # Note: Brew path may vary by architecture (Intel vs Apple Silicon)
        # Using a more robust check for the path
        PG_PATH="$(brew --prefix "postgresql@$POSTGRES_VERSION")/bin"
        if [[ -d "$PG_PATH" ]]; then
            export PATH="$PG_PATH:$PATH"
        fi
        
        log_success "PostgreSQL $POSTGRES_VERSION setup complete"
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
