#!/usr/bin/env bash
set -e

APP_NAME="porta"
INSTALL_DIR="/usr/local/bin"
REPO="Pritam307/Porta" # GitHub repository

echo "🔍 Detecting OS and architecture..."

OS=$(uname -s | tr '[:upper:]' '[:lower:]')
ARCH=$(uname -m)

case "$ARCH" in
    x86_64) ARCH="x64" ;;
    aarch64|arm64) ARCH="arm64" ;;
    *) echo "❌ Unsupported architecture: $ARCH"; exit 1 ;;
esac

case "$OS" in
    linux)   FILE="${APP_NAME}-linux-${ARCH}.zip"; BIN_NAME="${APP_NAME}-linux-${ARCH}" ;;
    darwin)  FILE="${APP_NAME}-macos-${ARCH}.zip"; BIN_NAME="${APP_NAME}-macos-${ARCH}" ;;
    msys*|mingw*|cygwin*)
        OS="windows"
        FILE="${APP_NAME}-win-${ARCH}.zip"
        BIN_NAME="${APP_NAME}-win-${ARCH}.exe"
        ;;
    *) echo "❌ Unsupported OS: $OS"; exit 1 ;;
esac

# Fetch latest release tag via GitHub API
TAG=$(curl -s https://api.github.com/repos/$REPO/releases/latest | grep -Po '"tag_name": "\K.*?(?=")')

ASSET_URL="https://github.com/$REPO/releases/download/$TAG/$FILE"
CHECKSUM_URL="https://github.com/$REPO/releases/download/$TAG/checksums.txt"

echo "⬇️  Downloading $FILE"
curl -L --fail "$ASSET_URL" -o "/tmp/$FILE"

echo "⬇️  Downloading checksums.txt"
curl -L --fail "$CHECKSUM_URL" -o "/tmp/checksums.txt"

echo "🔐 Verifying checksum..."
(
    cd /tmp
    sha256sum --ignore-missing -c checksums.txt | grep "$FILE: OK"
)

echo "📦 Extracting..."
unzip -o "/tmp/$FILE" -d /tmp/

BINARY="/tmp/$BIN_NAME"

if [ ! -f "$BINARY" ]; then
    echo "❌ Binary not found after extraction: $BINARY"
    exit 1
fi

echo "🚚 Installing to $INSTALL_DIR/$APP_NAME"
sudo mv "$BINARY" "$INSTALL_DIR/$APP_NAME"
sudo chmod +x "$INSTALL_DIR/$APP_NAME"

echo "✅ Installation complete!"
echo "Run '$APP_NAME --help' to get started."
