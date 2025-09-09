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
    linux)   FILE="${APP_NAME}-${OS}-${ARCH}.zip" ;;
    darwin)  FILE="${APP_NAME}-macos-${ARCH}.zip" ;;
    msys*|mingw*|cygwin*) FILE="${APP_NAME}-win-${ARCH}.zip" ;;
    *) echo "❌ Unsupported OS: $OS"; exit 1 ;;
esac

# Fetch latest release tag via GitHub API
TAG=$(curl -s https://api.github.com/repos/$REPO/releases/latest | grep -Po '"tag_name": "\K.*?(?=")')

DOWNLOAD_URL="https://github.com/$REPO/releases/download/$TAG/$FILE"

echo "⬇️  Downloading $FILE from $DOWNLOAD_URL"
curl -L "$DOWNLOAD_URL" -o "/tmp/$FILE"

echo "📦 Extracting..."
unzip -o "/tmp/$FILE" -d /tmp/

BINARY="/tmp/${APP_NAME}-${OS}-${ARCH}"
echo "🚚 Installing to $INSTALL_DIR/$APP_NAME"
sudo mv "$BINARY" "$INSTALL_DIR/$APP_NAME"
sudo chmod +x "$INSTALL_DIR/$APP_NAME"

echo "✅ Installation complete!"
echo "Run '$APP_NAME --help' to get started."
