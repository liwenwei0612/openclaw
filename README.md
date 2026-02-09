# OpenClaw Skills Collection

Personal collection of OpenClaw skills for AI assistant automation.

## 📁 Skills Overview

### 🔧 Core Skills

| Skill | Description | Path |
|-------|-------------|------|
| **github** | GitHub CLI integration - manage repos, PRs, issues, workflows | `/github` |
| **aisuperdomain-config** | AISuperDomain (AI超元域) desktop app configuration management | `/public/aisuperdomain-config` |
| **alibaba-message-assistant** | Alibaba International Station message handling and automation | `/public/alibaba-message-assistant` |
| **windows-autohotkey** | Windows automation with AutoHotkey scripts | `/public/windows-autohotkey` |

## 🚀 Installation

### Method 1: ClawHub CLI (Recommended)

```bash
npx clawhub@latest install <skill-name>
```

### Method 2: Manual Installation

Copy the skill folder to your OpenClaw workspace:

```bash
# Global skills
cp -r <skill-folder> ~/.openclaw/skills/

# Workspace-specific skills
cp -r <skill-folder> ./skills/
```

## 📖 Skill Details

### GitHub
- Manage GitHub repositories
- Create and merge pull requests
- Handle issues and workflows
- Requires: GitHub CLI (`gh`)

### AISuperDomain Config
- Maintain AISuperDomain `config.json`
- Add new AI providers
- Validate configuration structure
- Generate starter entries

### Alibaba Message Assistant
- Alibaba International Station automation
- Message handling workflows
- Client communication templates

### Windows AutoHotkey
- Windows GUI automation
- Hotkey scripts for repetitive tasks
- Integration with AliMail and other apps

## 🛠️ Requirements

- OpenClaw installed
- GitHub CLI (for github skill)
- AutoHotkey v2 (for windows-autohotkey skill)
- Node.js (for aisuperdomain-config scripts)

## 📝 License

Personal use collection. Individual skills may have their own licenses.

## 🤝 Contributing

These are personal skills. Feel free to fork and adapt for your own use.

---

Created with ❤️ for OpenClaw
