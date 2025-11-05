# Arena of Ideas - World Data

This repository contains the world data and node assets for the Arena of Ideas project.

## Structure

- `assets/nodes/` - Contains all node assets organized by type
  - Each node type has its own directory (e.g., `unit/`, `ability/`, etc.)
  - Individual nodes are stored as `.ron` files named by their ID
  - Links between nodes are stored in `links.ron`

## World Migration Commands

This repository provides command-line tools to synchronize world data with the Arena of Ideas server.

### Download World Assets

Downloads all nodes and links from the server and saves them to local files:

**Unix/Linux/macOS:**
```bash
./download.sh
```

**Windows:**
```cmd
download.bat
```

**Direct command (from arena-of-ideas directory):**
```bash
cargo run --features bevy/dynamic_linking -- --mode world-download
```

### Upload World Assets

Uploads all local world assets to the server:

**Unix/Linux/macOS:**
```bash
./upload.sh
```

**Windows:**
```cmd
upload.bat
```

**Direct command (from arena-of-ideas directory):**
```bash
cargo run --features bevy/dynamic_linking -- --mode world-upload
```

### Environment Configuration

The system automatically detects the world repository location, but you can override it:

```bash
export AOI_WORLD_PATH="/path/to/arena-of-ideas-world"
```

## Integration with Development Tools

### VS Code Tasks

The arena-of-ideas repository includes VS Code tasks for world operations:
- "World Download" - Downloads assets from server
- "World Upload" - Uploads assets to server

### Zed Editor

To add world migration tasks to Zed, copy the task templates from `zed_tasks.json` and merge them into your `~/.config/zed/tasks.json` file:

```bash
# View the tasks to copy
cat zed_tasks.json

# Edit your Zed tasks file
# Add the "templates" array from zed_tasks.json to your existing tasks.json
```

If you don't have a tasks.json file yet, you can copy the entire file:

```bash
cp zed_tasks.json ~/.config/zed/tasks.json
```

### Manual Operations

You can also perform world operations through the admin interface in the Arena of Ideas client:
- "Download Node Assets" button in the Admin panel
- "Upload Node Assets" button in the Admin panel

## File Format

All assets are stored in RON (Rust Object Notation) format for easy reading and version control.

## Prerequisites

- The arena-of-ideas repository must be cloned as a sibling directory
- You must be connected to the Arena of Ideas server to perform upload/download operations
- Cargo and Rust must be installed for direct commands

## Notes

- Download operations will clear the existing assets folder before downloading new data
- Upload operations will read all assets from the local folder and send them to the server
- All operations provide console feedback about the number of nodes and links processed