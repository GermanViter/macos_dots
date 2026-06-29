#!/bin/bash

# setup_symlinks.sh - Automate symlinking of macOS dotfiles using GNU Stow
# Usage:
#   ./setup_symlinks.sh              → stows packages
#   ./setup_symlinks.sh --dry-run    → simulates without modifying
#   ./setup_symlinks.sh --unlink     → unstows packages
#   ./setup_symlinks.sh --brew       → installs packages via Homebrew
#   ./setup_symlinks.sh --help       → shows help

set -euo pipefail

DOTFILES_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)
DRY_RUN=false
UNLINK=false
RUN_BREW=false

# ── Colors ───────────────────────────────────────────────────────────────────
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
RESET='\033[0m'

log_info() { echo -e "${BLUE}  →${RESET} $*"; }
log_success() { echo -e "${GREEN}  ✓${RESET} $*"; }
log_error() { echo -e "${RED}  ✗${RESET} $*" >&2; }

# ── Arguments ──────────────────────────────────────────────────────────────────
for arg in "$@"; do
    case $arg in
    --dry-run)
        DRY_RUN=true
        echo -e "${YELLOW}[DRY RUN — no files will be modified]${RESET}\n"
        ;;
    --unlink)
        UNLINK=true
        echo -e "${CYAN}[UNLINK MODE — removing symlinks]${RESET}\n"
        ;;
    --brew)
        RUN_BREW=true
        ;;
    --help)
        echo "Usage: $0 [--dry-run | --unlink | --brew]"
        echo ""
        echo "  (no arguments)    Create symlinks using GNU Stow"
        echo "  --dry-run         Simulate the process"
        echo "  --unlink          Remove symlinks (unstow)"
        echo "  --brew            Install packages via Homebrew"
        echo "  --help            Show this help"
        exit 0
        ;;
    *)
        log_error "Unknown argument: $arg"
        echo "Run '$0 --help' for options."
        exit 1
        ;;
    esac
done

# ── Dependency Check ──────────────────────────────────────────────────────────
if ! command -v stow &>/dev/null; then
    log_error "GNU Stow is not installed. Please install it first (e.g., 'brew install stow')."
    exit 1
fi

# ── Homebrew Mode ─────────────────────────────────────────────────────────────
if [ "$RUN_BREW" = true ]; then
    if ! command -v brew &>/dev/null; then
        log_error "Homebrew is not installed. Please install Homebrew first (https://brew.sh/)."
    else
        echo -e "${BLUE}▸ Homebrew (Brewfile)${RESET}"
        BREWFILE="$DOTFILES_DIR/brew/Brewfile"
        if [ -f "$BREWFILE" ]; then
            if [ "$DRY_RUN" = true ]; then
                log_info "[dry-run] Would run: brew bundle install --file=\"$BREWFILE\""
            else
                brew bundle install --file="$BREWFILE"
                log_success "Homebrew installation complete"
            fi
        else
            log_error "No Brewfile found at $BREWFILE"
        fi
    fi
fi

# ── Stow Packages ─────────────────────────────────────────────────────────────
# Packages to exclude (not meant for stowing)
EXCLUDE=("scripts" "assets" "gemini" "raycast")

cd "$DOTFILES_DIR"

# Collect packages (directories that are not in EXCLUDE and don't start with .)
packages=()
for dir in */; do
    dir=${dir%/}
    [[ " ${EXCLUDE[@]} " =~ " ${dir} " ]] && continue
    [[ "$dir" == .* ]] && continue
    packages+=("$dir")
done

STOW_FLAGS="-v -t $HOME"
if [ "$DRY_RUN" = true ]; then
    STOW_FLAGS+=" -n"
fi

if [ "$UNLINK" = true ]; then
    STOW_FLAGS+=" -D"
    echo -e "${BLUE}Packages to unstow:${RESET} ${packages[*]}\n"
else
    STOW_FLAGS+=" -S"
    echo -e "${BLUE}Packages to stow:${RESET} ${packages[*]}\n"
fi

for pkg in "${packages[@]}"; do
    if [ "$UNLINK" = true ]; then
        stow $STOW_FLAGS "$pkg" || log_error "Failed to unstow $pkg"
    else
        # Stow will fail if it encounters a real file instead of a symlink
        # We could add logic here to backup, but Stow's default behavior is safer
        stow $STOW_FLAGS "$pkg" || log_error "Failed to stow $pkg. Check for existing files."
    fi
done

echo ""
if [ "$UNLINK" = true ]; then
    log_success "Unlink complete!"
else
    log_success "Stow complete!"
    if [ "$DRY_RUN" = true ]; then
        echo -e "${YELLOW}(Dry-run mode — run without --dry-run to apply)${RESET}"
    fi
fi

exit 0
