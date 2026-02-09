---
name: github
description: Interact with GitHub using the `gh` CLI. Use this skill when you need to create repositories, manage issues, pull requests, workflows, or any GitHub operations.
---

# GitHub Skill

This skill enables interaction with GitHub through the official GitHub CLI (`gh`).

## Prerequisites

- GitHub CLI (`gh`) must be installed on your system
- You must be authenticated with GitHub (`gh auth login`)

## Installation

### Windows (via winget)
```powershell
winget install --id GitHub.cli
```

### Or download from
https://github.com/cli/cli/releases

## Common Operations

### Repository Management
- `gh repo create <name>` - Create a new repository
- `gh repo clone <owner>/<repo>` - Clone a repository
- `gh repo view <owner>/<repo>` - View repository details
- `gh repo list` - List your repositories

### Issue Management
- `gh issue create` - Create a new issue
- `gh issue list` - List open issues
- `gh issue view <number>` - View issue details
- `gh issue close <number>` - Close an issue

### Pull Request Management
- `gh pr create` - Create a pull request
- `gh pr list` - List pull requests
- `gh pr checkout <number>` - Checkout a PR locally
- `gh pr merge <number>` - Merge a pull request
- `gh pr view <number>` - View PR details

### Workflow Actions
- `gh workflow list` - List workflows
- `gh workflow run <workflow>` - Run a workflow
- `gh run list` - List workflow runs
- `gh run view <run-id>` - View workflow run details

### Other Useful Commands
- `gh status` - Check GitHub status
- `gh auth status` - Check authentication status
- `gh gist create <file>` - Create a gist
- `gh release create <tag>` - Create a release
- `gh api <endpoint>` - Make API calls

## Best Practices

1. Always check authentication status before operations
2. Use `--web` flag to open GitHub in browser when needed
3. Use `--json` flag for programmatic output
4. Check for rate limits with `gh api /rate_limit`

## Security Notes

- Store tokens securely
- Use `gh auth logout` when done on shared machines
- Prefer SSH authentication for git operations
- Review scopes when authenticating

## Windows-Specific Tips

- Use PowerShell or Command Prompt
- For admin operations, run as Administrator
- Use Windows Terminal for better experience
- GitHub Desktop can complement CLI usage
