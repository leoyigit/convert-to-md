#!/usr/bin/env bash

# Convert to Markdown - double-click uninstaller for macOS
# Developed by Leo Yigit Ekiz
# https://github.com/leoyigit

cd "$(dirname "$0")" || exit 1

bash ./uninstall.sh

read -r -p "Press Enter to close this window."
