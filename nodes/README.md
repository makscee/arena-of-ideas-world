# Node Assets

This directory contains all Arena of Ideas node assets organized by type.

## Structure

- Each node type has its own subdirectory (e.g., `NUnit/`, `NTeam/`, etc.)
- Individual nodes are stored as `.ron` files named by their ID
- Links between nodes are stored in `links.ron`

## File Format

Nodes are stored in RON (Rusty Object Notation) format:
```ron
("serialized_node_data", owner_id, rating)
```

Links are stored as:
```ron
[
  (parent_id, child_id, "parent_kind", "child_kind", rating),
  // ... more links
]
```

## Synchronization

This repository is synchronized with the main Arena of Ideas project using automated scripts and workflows.
