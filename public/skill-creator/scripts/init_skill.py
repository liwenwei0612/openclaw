#!/usr/bin/env python3
"""
Initialize a new skill with proper structure.
Usage: python init_skill.py <skill-name> --path <output-directory>
"""

import argparse
import os
import sys
from pathlib import Path


def create_skill_structure(skill_name: str, output_path: str):
    """Create the skill directory structure."""
    
    skill_path = Path(output_path) / skill_name
    
    # Create directories
    (skill_path / "scripts").mkdir(parents=True, exist_ok=True)
    (skill_path / "references").mkdir(parents=True, exist_ok=True)
    (skill_path / "assets").mkdir(parents=True, exist_ok=True)
    
    # Create SKILL.md template
    skill_md_content = f'''---
name: {skill_name}
description: TODO - Describe what this skill does and when to use it
---

# {skill_name.replace("-", " ").title()}

TODO - Write skill documentation here.

## Overview

Brief description of what this skill does.

## When to Use

- Use case 1
- Use case 2
- Use case 3

## Quick Start

Quick example of how to use the skill.

## Resources

### Scripts (`scripts/`)
- `script.py` - Description of what this script does

### References (`references/`)
- `reference.md` - Reference documentation

### Assets (`assets/`)
- `template.txt` - Template files for output

## Examples

### Example 1: Basic Usage
```
Example of how to use the skill
```

### Example 2: Advanced Usage
```
More complex example
```

## Notes

Additional notes about the skill.
'''
    
    (skill_path / "SKILL.md").write_text(skill_md_content, encoding="utf-8")
    
    # Create example script
    script_content = '''#!/usr/bin/env python3
"""
Example script for the skill.
TODO: Replace with actual implementation.
"""

import sys


def main():
    """Main function."""
    print("Hello from the skill script!")
    print(f"Arguments: {sys.argv[1:]}")


if __name__ == "__main__":
    main()
'''
    
    (skill_path / "scripts" / "example_script.py").write_text(script_content, encoding="utf-8")
    
    # Create example reference
    reference_content = '''# Reference Documentation

TODO - Add reference documentation here.

This file contains detailed information that Claude should reference when using this skill.

## Section 1

Content here...

## Section 2

Content here...
'''
    
    (skill_path / "references" / "example_reference.md").write_text(reference_content, encoding="utf-8")
    
    # Create example asset
    asset_content = '''TODO - This is an example asset file.
Replace with actual templates, configurations, or other files needed for output.
'''
    
    (skill_path / "assets" / "example_template.txt").write_text(asset_content, encoding="utf-8")
    
    print(f"✅ Skill '{skill_name}' created at: {skill_path}")
    print(f"\nStructure:")
    print(f"  {skill_name}/")
    print(f"  ├── SKILL.md")
    print(f"  ├── scripts/")
    print(f"  │   └── example_script.py")
    print(f"  ├── references/")
    print(f"  │   └── example_reference.md")
    print(f"  └── assets/")
    print(f"      └── example_template.txt")
    print(f"\nNext steps:")
    print(f"  1. Edit {skill_path}/SKILL.md")
    print(f"  2. Replace example files with actual implementations")
    print(f"  3. Delete files you don't need")
    print(f"  4. Run package_skill.py to create the .skill file")


def main():
    parser = argparse.ArgumentParser(description="Initialize a new skill")
    parser.add_argument("skill_name", help="Name of the skill")
    parser.add_argument("--path", default=".", help="Output directory (default: current directory)")
    
    args = parser.parse_args()
    
    create_skill_structure(args.skill_name, args.path)


if __name__ == "__main__":
    main()
