#!/usr/bin/env python3
"""
Synchronization script for Arena of Ideas node assets.

This script handles bidirectional sync between local assets and the GitHub repository.
"""

import os
import sys
import json
import subprocess
from pathlib import Path
from typing import Dict, List, Optional


class NodeAssetSync:
    def __init__(self, local_path: str, repo_url: str, branch: str = "main"):
        self.local_path = Path(local_path)
        self.repo_url = repo_url
        self.branch = branch
        self.repo_path = Path("arena-of-ideas-world")
        
    def clone_or_pull(self):
        """Clone the repository or pull latest changes."""
        if self.repo_path.exists():
            print("Pulling latest changes...")
            subprocess.run(["git", "pull"], cwd=self.repo_path, check=True)
        else:
            print("Cloning repository...")
            subprocess.run(["git", "clone", self.repo_url], check=True)
    
    def sync_to_remote(self):
        """Sync local assets to remote repository."""
        print("Syncing local assets to remote...")
        
        # Ensure repo is up to date
        self.clone_or_pull()
        
        # Copy local assets to repo
        nodes_src = self.local_path
        nodes_dst = self.repo_path / "nodes"
        
        if nodes_src.exists():
            # Remove existing nodes in repo
            if nodes_dst.exists():
                subprocess.run(["rm", "-rf", str(nodes_dst)], check=True)
            
            # Copy new assets
            subprocess.run(["cp", "-r", str(nodes_src), str(nodes_dst)], check=True)
            
            # Commit and push
            os.chdir(self.repo_path)
            subprocess.run(["git", "add", "."], check=True)
            
            # Check if there are changes to commit
            result = subprocess.run(["git", "diff", "--cached", "--quiet"], 
                                  capture_output=True)
            if result.returncode != 0:
                subprocess.run(["git", "commit", "-m", "Sync node assets from local"], 
                             check=True)
                subprocess.run(["git", "push"], check=True)
                print("Assets synced successfully!")
            else:
                print("No changes to sync.")
        else:
            print(f"Local assets path {nodes_src} does not exist.")
    
    def sync_from_remote(self):
        """Sync remote assets to local."""
        print("Syncing remote assets to local...")
        
        # Ensure repo is up to date
        self.clone_or_pull()
        
        # Copy remote assets to local
        nodes_src = self.repo_path / "nodes"
        nodes_dst = self.local_path
        
        if nodes_src.exists():
            # Ensure local directory exists
            nodes_dst.parent.mkdir(parents=True, exist_ok=True)
            
            # Remove existing local assets
            if nodes_dst.exists():
                subprocess.run(["rm", "-rf", str(nodes_dst)], check=True)
            
            # Copy remote assets
            subprocess.run(["cp", "-r", str(nodes_src), str(nodes_dst)], check=True)
            print("Remote assets synced to local successfully!")
        else:
            print("No remote assets found.")


def main():
    if len(sys.argv) < 2:
        print("Usage: python sync.py [to-remote|from-remote] [local-path]")
        sys.exit(1)
    
    command = sys.argv[1]
    local_path = sys.argv[2] if len(sys.argv) > 2 else "assets/nodes"
    
    syncer = NodeAssetSync(
        local_path=local_path,
        repo_url="https://github.com/makscee/arena-of-ideas-world.git"
    )
    
    if command == "to-remote":
        syncer.sync_to_remote()
    elif command == "from-remote":
        syncer.sync_from_remote()
    else:
        print("Invalid command. Use 'to-remote' or 'from-remote'.")
        sys.exit(1)


if __name__ == "__main__":
    main()
