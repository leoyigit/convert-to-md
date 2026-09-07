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
# Dependencies
# ------------------------------------------------------------

missing=()

command -v pandoc    >/dev/null 2>&1 || missing+=("pandoc")
command -v pdftotext >/dev/null 2>&1 || missing+=("poppler")

if [ "${#missing[@]}" -gt 0 ]; then

    echo "Missing dependencies: ${missing[*]}"
    echo ""

    if command -v brew >/dev/null 2>&1; then

        read -r -p "Install them with Homebrew now? [Y/n] " answer

        case "${answer:-Y}" in
            [Yy]*)
                brew install "${missing[@]}"
                ;;
            *)
                echo "Skipped. Install them later with:"
                echo "  brew install ${missing[*]}"
                ;;
        esac

    else

        echo "Homebrew is not installed, so they cannot be installed automatically."
        echo "Install Homebrew from https://brew.sh and then run:"
        echo "  brew install ${missing[*]}"

    fi

    echo ""
fi

if ! python3 -c "import pandas, openpyxl, xlrd, tabulate" >/dev/null 2>&1; then

    echo "Python packages for spreadsheet conversion are missing."
    echo ""

    read -r -p "Install them with pip now? [Y/n] " answer

    case "${answer:-Y}" in
        [Yy]*)
            python3 -m pip install --user pandas openpyxl xlrd tabulate
            ;;
        *)
            echo "Skipped. Install them later with:"
            echo "  python3 -m pip install --user pandas openpyxl xlrd tabulate"
            ;;
    esac

    echo ""
fi

# ------------------------------------------------------------
# Install the command
# ------------------------------------------------------------

bash ./install.sh

echo "Open a new Terminal window and run:"
echo ""
echo "  convert"
echo ""
read -r -p "Press Enter to close this window."
