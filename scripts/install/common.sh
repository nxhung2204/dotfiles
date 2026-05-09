#!/usr/bin/env bash
# Common functions for install modules

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

ask() {
    printf "${YELLOW}❓ $1 (y/N): ${NC}"
    read -r ans
    [[ $ans =~ ^[Yy]$ ]]
}

log_header() {
    echo ""
    echo "====================== $1 ======================"
}

log_success() {
    echo -e "${GREEN}✅ $1${NC}"
}

log_error() {
    echo -e "${RED}❌ $1${NC}"
}

log_info() {
    echo "ℹ️  $1"
}
