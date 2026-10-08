#!/usr/bin/env bash

# Exit immediately if a command fails
set -e

# Repository configuration
REPO_URL="https://github.com/itzthaani/agile-ds/archive/refs/heads/main.tar.gz"
TARGET_DIR="$HOME/Desktop/agile-ds"

echo "Downloading agile-ds repository files to Desktop..."

# Create target directory on Desktop
mkdir -p "$TARGET_DIR"

# Download and extract the archive directly into target directory
curl -sSL "$REPO_URL" | tar -xz -C "$TARGET_DIR" --strip-components=1

echo "Done! Files extracted to $TARGET_DIR"
