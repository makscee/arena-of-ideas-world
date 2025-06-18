# Synchronization Scripts

These scripts handle synchronization between local Arena of Ideas assets and this repository.

## sync.py

Python script for bidirectional synchronization.

### Usage

```bash
# Sync local assets to remote repository
python sync.py to-remote [local-path]

# Sync remote assets to local
python sync.py from-remote [local-path]
```

Default local path is `assets/nodes`.

### Requirements

- Python 3.6+
- Git
- Proper GitHub authentication (SSH key or HTTPS token)

## Rust Integration

The Rust code in the main project includes extensions to `NodeAssetsManager` for remote synchronization.
