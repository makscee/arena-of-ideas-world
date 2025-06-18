#!/bin/bash

# Setup script for arena-of-ideas-world repository

echo "Setting up Arena of Ideas World repository..."

# Pull latest changes from remote if it exists
if git remote get-url origin >/dev/null 2>&1; then
    echo "Pulling latest changes from remote..."
    git pull origin main 2>/dev/null || echo "No remote changes to pull"
fi

# Create necessary directories
mkdir -p assets/nodes

echo "World repository setup complete!"
echo "Repository path: $(pwd)"
echo "Assets path: $(pwd)/assets/nodes"
echo ""
echo "To use a custom path in Arena of Ideas, set the AOI_WORLD_PATH environment variable:"
echo "export AOI_WORLD_PATH=$(pwd)"

