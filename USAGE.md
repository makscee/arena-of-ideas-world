# Arena of Ideas - World Migration System

This document describes how to use the world migration system to synchronize node data between the Arena of Ideas server and this world repository.

## Quick Start

### Download World Data
```bash
# Using scripts (recommended)
./download.sh          # Unix/Linux/macOS
download.bat           # Windows

# Direct command
cd ../arena-of-ideas
cargo run --features bevy/dynamic_linking -- --mode world-download
```

### Upload World Data
```bash
# Using scripts (recommended)
./upload.sh            # Unix/Linux/macOS
upload.bat             # Windows

# Direct command
cd ../arena-of-ideas
cargo run --features bevy/dynamic_linking -- --mode world-upload
```

## How It Works

### Download Process
1. Connects to the Arena of Ideas server
2. Clears the local `assets/nodes/` directory
3. Fetches all nodes and links from the server database
4. Organizes nodes by type into separate directories
5. Saves individual nodes as `.ron` files named by their ID
6. Saves all links in a single `links.ron` file
7. Reports the number of items downloaded

### Upload Process
1. Reads all node and link files from the local repository
2. Converts them to the server format
3. Uploads all data to the server via the `admin_upload_world` reducer
4. Reports the number of items uploaded

## File Structure

After downloading, the repository structure looks like this:

```
assets/nodes/
├── unit/
│   ├── 1.ron
│   ├── 2.ron
│   └── ...
├── ability/
│   ├── 100.ron
│   ├── 101.ron
│   └── ...
├── house/
│   ├── 200.ron
│   └── ...
├── status/
│   └── ...
└── links.ron
```

## Environment Variables

- `AOI_WORLD_PATH` - Override the world repository path (optional)

## Development Integration

### VS Code
Tasks are available in the arena-of-ideas `.vscode/tasks.json`:
- "World Download"
- "World Upload"

### Zed Editor
Copy tasks from `zed_tasks.json` to your `~/.config/zed/tasks.json` file.

### Admin Panel
Manual buttons are available in the Arena of Ideas admin interface:
- "Download Node Assets"
- "Upload Node Assets"

## Prerequisites

1. **Repository Structure**: `arena-of-ideas` and `arena-of-ideas-world` must be sibling directories
2. **Server Connection**: You must be connected to the Arena of Ideas server
3. **Dependencies**: Rust and Cargo must be installed

## Troubleshooting

### Common Issues

**"Arena of Ideas repository not found"**
- Ensure `arena-of-ideas` is a sibling directory to `arena-of-ideas-world`
- Check that the path structure is correct

**"No assets directory found"**
- Run download first before attempting upload
- Ensure the assets directory exists and contains node data

**Connection Errors**
- Verify server connection in the Arena of Ideas client
- Check network connectivity
- Ensure proper authentication with the server

### Debugging

Add `RUST_LOG=debug` environment variable for detailed logging:

```bash
RUST_LOG=debug ./download.sh
```

## Data Format

All files use RON (Rust Object Notation) format:

### Node File Example (`unit/1.ron`)
```ron
(
    data: "Unit data as string",
    owner_id: 12345,
    rating: 100
)
```

### Links File Example (`links.ron`)
```ron
[
    (
        parent_id: 1,
        child_id: 100,
        parent_kind: "unit",
        child_kind: "ability",
        rating: 50,
        solid: true
    ),
    // ... more links
]
```

## Version Control

This repository is designed to work well with Git:
- Individual node files allow for granular change tracking
- RON format is human-readable and diff-friendly
- Clear directory structure makes navigation easy

## Safety Notes

- **Download operations clear existing data** - make sure to commit any local changes first
- **Upload operations replace server data** - ensure your local data is correct before uploading
- **Always backup important data** before performing bulk operations