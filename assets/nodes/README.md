# Node Assets Directory Structure

This directory contains all node assets organized by node type.

## Expected Structure:
```
assets/nodes/
├── links.ron                    # All inter-node links
├── unit/                       # Unit node assets
│   ├── 1.ron
│   ├── 2.ron
│   └── ...
├── ability/                    # Ability node assets
│   ├── 1.ron
│   ├── 2.ron
│   └── ...
├── status/                     # Status node assets
│   └── ...
└── [other_node_types]/         # Additional node types
    └── ...
```

Each `.ron` file contains a NodeAsset tuple: (data, owner_id, rating)
The `links.ron` file contains a Vec<LinkAsset> with tuples: (parent_id, child_id, parent_kind, child_kind, rating)

