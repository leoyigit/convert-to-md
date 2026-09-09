#!/usr/bin/env bash

# ============================================================
# Convert to Markdown - double-click installer for macOS
#
# Developed by Leo Yigit Ekiz
# https://github.com/leoyigit
# ============================================================

cd "$(dirname "$0")" || exit 1

echo ""
echo "Convert to Markdown"
echo "Developed by Leo Yigit Ekiz"
echo "https://github.com/leoyigit"
echo ""

# ------------------------------------------------------------
# Install the command
# ------------------------------------------------------------

bash ./install.sh

echo "Open a new Terminal window and run:"
echo ""
echo "  convert"
echo ""
read -r -p "Press Enter to close this window."
