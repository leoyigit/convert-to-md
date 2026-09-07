#!/usr/bin/env bash

# Convert to Markdown Uninstaller
# Developed by Leo Yigit Ekiz
# https://github.com/leoyigit

set -e

INSTALL_PATH="$HOME/.local/bin/convert"

echo ""

if [ -f "$INSTALL_PATH" ]; then

    rm "$INSTALL_PATH"

    echo "Convert to Markdown has been removed."

else

    echo "Convert to Markdown is not installed."

fi

echo ""