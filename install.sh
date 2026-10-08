#!/usr/bin/env bash
set -e

REPO_URL="https://github.com/itzthaani/agile-ds/archive/refs/heads/main.tar.gz"
TARGET_DIR="$HOME/Desktop/KADAGILE-DS"

echo "Downloading agile-ds repository files to Desktop..."

mkdir -p "$TARGET_DIR"
curl -sSL "$REPO_URL" | tar -xz -C "$TARGET_DIR" --strip-components=1 --exclude='install.sh' --exclude='install.ps1'

echo "Done! Files extracted to $TARGET_DIR"
