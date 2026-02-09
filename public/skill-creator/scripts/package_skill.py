#!/usr/bin/env python3
"""
Package a skill into a .skill file (zip format).
Usage: python package_skill.py <path/to/skill-folder> [output-directory]
"""

import argparse
import os
import re
import sys
import zipfile
from pathlib import Path


def validate_yaml_frontmatter(skill_md_path: Path) -> tuple[bool, list[str]]:
    """Validate the YAML frontmatter in SKILL.md."""
    errors = []
    
    content = skill_md_path.read_text(encoding="utf-8")
    
    # Check for frontmatter
    if not content.startswith("---"):
        errors.append("SKILL.md must start with YAML frontmatter (---)")
        return False, errors
    
    # Extract frontmatter
    match = re.search(r'^---\s*\n(.*?)\n---', content, re.DOTALL)
    if not match:
        errors.append("Could not parse YAML frontmatter")
        return False, errors
    
    frontmatter = match.group(1)
    
    # Check for required fields
    if "name:" not in frontmatter:
        errors.append("Missing required field: 'name' in frontmatter")
    
    if "description:" not in frontmatter:
        errors.append("Missing required field: 'description' in frontmatter")
    
    # Check for extra fields (only name and description allowed)
    lines = frontmatter.strip().split('\n')
    for line in lines:
        line = line.strip()
        if line and ':' in line and not line.startswith('#'):
            field_name = line.split(':')[0].strip()
            if field_name not in ['name', 'description']:
                errors.append(f"Extra field not allowed in frontmatter: '{field_name}'")
    
    return len(errors) == 0, errors


def validate_skill_name(skill_path: Path) -> tuple[bool, list[str]]:
    """Validate the skill name matches directory name."""
    errors = []
    
    skill_md_path = skill_path / "SKILL.md"
    if not skill_md_path.exists():
        errors.append("SKILL.md not found")
        return False, errors
    
    content = skill_md_path.read_text(encoding="utf-8")
    match = re.search(r'^---\s*\n.*?name:\s*(\S+)', content, re.DOTALL)
    
    if not match:
        errors.append("Could not find 'name' in frontmatter")
        return False, errors
    
    skill_name = match.group(1).strip()
    dir_name = skill_path.name
    
    if skill_name != dir_name:
        errors.append(f"Skill name '{skill_name}' does not match directory name '{dir_name}'")
    
    return len(errors) == 0, errors


def validate_skill(skill_path: Path) -> tuple[bool, list[str]]:
    """Validate the skill structure and content."""
    errors = []
    
    # Check SKILL.md exists
    skill_md_path = skill_path / "SKILL.md"
    if not skill_md_path.exists():
        errors.append("SKILL.md is required but not found")
        return False, errors
    
    # Validate YAML frontmatter
    valid, frontmatter_errors = validate_yaml_frontmatter(skill_md_path)
    errors.extend(frontmatter_errors)
    
    # Validate skill name matches directory
    valid, name_errors = validate_skill_name(skill_path)
    errors.extend(name_errors)
    
    # Check description is not empty
    content = skill_md_path.read_text(encoding="utf-8")
    match = re.search(r'description:\s*(.+?)(?:\n\w|$)', content, re.DOTALL)
    if match:
        description = match.group(1).strip()
        if not description or description == "TODO":
            errors.append("Description is empty or contains placeholder text")
    else:
        errors.append("Could not find 'description' in frontmatter")
    
    return len(errors) == 0, errors


def package_skill(skill_path: Path, output_dir: Path):
    """Package the skill into a .skill file."""
    
    skill_name = skill_path.name
    output_file = output_dir / f"{skill_name}.skill"
    
    # Create zip file
    with zipfile.ZipFile(output_file, 'w', zipfile.ZIP_DEFLATED) as zf:
        for file_path in skill_path.rglob('*'):
            if file_path.is_file():
                # Skip __pycache__ and .pyc files
                if '__pycache__' in str(file_path) or file_path.suffix == '.pyc':
                    continue
                
                arcname = file_path.relative_to(skill_path)
                zf.write(file_path, arcname)
                print(f"  Added: {arcname}")
    
    print(f"\n✅ Skill packaged: {output_file}")
    print(f"   Size: {output_file.stat().st_size / 1024:.1f} KB")


def main():
    parser = argparse.ArgumentParser(description="Package a skill into a .skill file")
    parser.add_argument("skill_folder", help="Path to the skill folder")
    parser.add_argument("output_dir", nargs="?", default=".", help="Output directory (default: current directory)")
    
    args = parser.parse_args()
    
    skill_path = Path(args.skill_folder).resolve()
    output_dir = Path(args.output_dir).resolve()
    
    # Validate skill path
    if not skill_path.exists():
        print(f"❌ Error: Skill folder not found: {skill_path}")
        sys.exit(1)
    
    if not skill_path.is_dir():
        print(f"❌ Error: Not a directory: {skill_path}")
        sys.exit(1)
    
    # Create output directory if needed
    output_dir.mkdir(parents=True, exist_ok=True)
    
    print(f"🔍 Validating skill: {skill_path.name}")
    print("-" * 50)
    
    # Validate
    valid, errors = validate_skill(skill_path)
    
    if not valid:
        print("❌ Validation failed:")
        for error in errors:
            print(f"   - {error}")
        sys.exit(1)
    
    print("✅ Validation passed!")
    print()
    
    # Package
    print(f"📦 Packaging skill...")
    package_skill(skill_path, output_dir)


if __name__ == "__main__":
    main()
