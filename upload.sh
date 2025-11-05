#!/bin/bash

# Upload world assets to Arena of Ideas server
# This script runs the Arena of Ideas client in world upload mode

set -e

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
WORLD_REPO="$SCRIPT_DIR"
AOI_REPO="$SCRIPT_DIR/../arena-of-ideas"

# Check if arena-of-ideas repo exists
if [ ! -d "$AOI_REPO" ]; then
    echo "Error: Arena of Ideas repository not found at $AOI_REPO"
    echo "Make sure the arena-of-ideas repository is cloned as a sibling to arena-of-ideas-world"
    exit 1
fi

# Check if assets directory exists
if [ ! -d "$WORLD_REPO/assets" ]; then
    echo "Error: No assets directory found in $WORLD_REPO"
    echo "Make sure you have downloaded world assets first using download.sh"
    exit 1
fi

# Set environment variable to point to this world repo
export AOI_WORLD_PATH="$WORLD_REPO"

# Change to the arena-of-ideas directory
cd "$AOI_REPO"

echo "Uploading world assets to server..."
echo "World repository: $WORLD_REPO"
echo "Arena of Ideas repository: $AOI_REPO"

# Run the client in world upload mode
cargo run --features dynamic_linking -- --mode world-upload

echo "World assets upload completed!"
