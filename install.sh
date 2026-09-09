#!/usr/bin/env bash

# ============================================================
# Convert to Markdown Installer
#
# Developed by Leo Yigit Ekiz
# https://github.com/leoyigit
# ============================================================

set -e

INSTALL_DIR="$HOME/.local/bin"
SOURCE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SOURCE_FILE="$SOURCE_DIR/convert"
TEMP_FILE=""

if [ ! -f "$SOURCE_FILE" ]; then

    command -v curl >/dev/null 2>&1 || {
        echo "curl is required when installing directly from GitHub."
        exit 1
    }

    TEMP_FILE="$(mktemp)"
    trap 'rm -f "$TEMP_FILE"' EXIT

    curl -fsSL "https://raw.githubusercontent.com/leoyigit/convert-to-md/main/convert" -o "$TEMP_FILE"
    SOURCE_FILE="$TEMP_FILE"

fi

echo ""
echo "Convert to Markdown"
echo "Developed by Leo Yigit Ekiz"
echo "https://github.com/leoyigit"
echo ""

echo "Checking dependencies..."

BREW_BIN=""

if command -v brew >/dev/null 2>&1; then
    BREW_BIN="$(command -v brew)"
else
    if [ "$(uname -m)" = "arm64" ]; then
        BREW_BIN="/opt/homebrew/bin/brew"
    else
        BREW_BIN="/usr/local/bin/brew"
    fi

    if [ ! -x "$BREW_BIN" ]; then
        echo "Homebrew is not installed. Installing it now..."
        NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi

    if [ ! -x "$BREW_BIN" ]; then
        echo "Homebrew installation did not complete."
        exit 1
    fi

    eval "$("$BREW_BIN" shellenv)"
fi

missing=()

command -v pandoc >/dev/null 2>&1 || missing+=("pandoc")
command -v python3 >/dev/null 2>&1 || missing+=("python")

if [ "${#missing[@]}" -gt 0 ]; then
    echo "Installing Homebrew dependencies: ${missing[*]}"
    "$BREW_BIN" install "${missing[@]}"
fi

PYTHON_PACKAGES=(pandas openpyxl xlrd tabulate pymupdf)

if ! python3 -c "import pandas, openpyxl, xlrd, tabulate, pymupdf" >/dev/null 2>&1; then
    echo "Installing Python dependencies..."
    # Newer Homebrew Pythons refuse plain pip installs (PEP 668).
    python3 -m pip install --user "${PYTHON_PACKAGES[@]}" ||
        python3 -m pip install --user --break-system-packages "${PYTHON_PACKAGES[@]}"
fi

echo "Installing..."

mkdir -p "$INSTALL_DIR"

cp "$SOURCE_FILE" "$INSTALL_DIR/convert"

chmod +x "$INSTALL_DIR/convert"

SHELL_NAME="$(basename "$SHELL")"

case "$SHELL_NAME" in

    zsh)
        PROFILE="$HOME/.zshrc"
        ;;

    bash)
        PROFILE="$HOME/.bashrc"
        ;;

    *)
        PROFILE="$HOME/.profile"
        ;;

esac

PATH_LINE='export PATH="$HOME/.local/bin:$PATH"'

if ! grep -Fq "$PATH_LINE" "$PROFILE" 2>/dev/null; then

    echo "" >> "$PROFILE"
    echo "# Convert to Markdown" >> "$PROFILE"
    echo "$PATH_LINE" >> "$PROFILE"

fi

echo ""
echo "Installed successfully."
echo ""
echo "Run:"
echo ""
echo "  convert"
echo ""
echo "If the command is not immediately available, restart Terminal."
echo ""