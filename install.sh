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

echo ""
echo "Convert to Markdown"
echo "Developed by Leo Yigit Ekiz"
echo "https://github.com/leoyigit"
echo ""

echo "Installing..."

mkdir -p "$INSTALL_DIR"

cp "$SOURCE_DIR/convert" "$INSTALL_DIR/convert"

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