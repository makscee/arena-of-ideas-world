# Arena of Ideas - World Data

This repository contains the world data and node assets for the Arena of Ideas project.

## Structure

- `assets/nodes/` - Contains all node assets organized by type
  - Each node type has its own directory (e.g., `unit/`, `ability/`, etc.)
  - Individual nodes are stored as `.ron` files named by their ID
  - Links between nodes are stored in `links.ron`

## Usage

This repository is automatically managed by the Arena of Ideas application. The `NodeAssetsManager` in the main project handles reading from and writing to this repository.

## File Format

All assets are stored in RON (Rust Object Notation) format for easy reading and version control.

