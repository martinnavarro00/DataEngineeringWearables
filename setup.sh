#!/bin/bash
set -e

VENV_DIR=".venv"

echo "Creating virtual environment..."
python3 -m venv "$VENV_DIR"

echo "Activating virtual environment..."
source "$VENV_DIR/bin/activate"

echo "Upgrading pip..."
pip install --upgrade pip

echo "Installing Python packages..."
pip install numpy matplotlib pandas

echo "Installing Quarto..."
if [[ "$OSTYPE" == "darwin"* ]]; then
    if command -v brew &>/dev/null; then
        brew install --cask quarto
    else
        echo "Homebrew not found. Download Quarto from: https://quarto.org/docs/get-started/"
        exit 1
    fi
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    QUARTO_VERSION="1.6.42"
    QUARTO_DEB="quarto-${QUARTO_VERSION}-linux-amd64.deb"
    curl -LO "https://github.com/quarto-dev/quarto-cli/releases/download/v${QUARTO_VERSION}/${QUARTO_DEB}"
    sudo dpkg -i "$QUARTO_DEB"
    rm "$QUARTO_DEB"
else
    echo "Unsupported OS. Download Quarto from: https://quarto.org/docs/get-started/"
    exit 1
fi

echo ""
echo "Setup complete. Activate your environment with:"
echo "  source ${VENV_DIR}/bin/activate"
