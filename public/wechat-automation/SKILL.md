---
name: wechat-automation
description: Automate WeChat (微信) Windows desktop client for message extraction, contact management, and read-only data capture. Use when user needs to extract chat history, backup messages, organize contacts, or capture WeChat data. Safety-first: never send messages without explicit confirmation.
---

# WeChat Automation (微信桌面版)

## Prerequisites

- Windows 10/11
- WeChat for Windows desktop client installed
- AutoHotkey v2 installed
- WeChat logged in

## Safety Rules

- **Read-only by default**: Extract, copy, backup data only
- **No auto-send**: Never send messages automatically
- **No auto-reply**: Never reply without explicit user confirmation
- **Confirm before any write**: Any modification requires user approval
- **Respect privacy**: Only process data user has access to

## Core Workflows

### 1. Chat History Extraction (聊天记录提取)

#### Extract Current Chat
Extract messages from the currently open chat window:
- Contact/Group name
- Message text
- Timestamp (if available)
- Message type (text/image/file/link)

**Usage**: Open chat window, press `F8`
**Script**: `scripts/extract_current_chat.ahk`

#### Batch Export Multiple Chats
Export multiple chat histories:
- Navigate through chat list
- Extract each chat
- Save to organized folder structure

### 2. Contact Management (联系人管理)

#### Export Contact List
Extract contact information:
- Contact name
- Alias/Remark name
- Tags/Groups
- Region (if visible)

**Script**: `scripts/export_contacts.ahk`

#### Extract Group Members
For group chats:
- Group name
- Member count
- Member list (if accessible)
- Group announcement

### 3. Message Search & Filter (消息搜索)

#### Search and Extract
Search for specific messages:
- By keyword
- By date range
- By contact
- By message type

**Output**: Filtered message list

### 4. Backup & Archive (备份归档)

#### Daily Chat Backup
Automated daily backup:
- Important chats
- Work-related messages
- Media files (images, files)

**Output**: `Desktop\WeChat_Backup_YYYYMMDD\`

## Hotkey Reference

| Hotkey | Function | Confirmation |
|--------|----------|--------------|
| `F8` | Extract current chat | No |
| `Ctrl+F8` | Export contacts | No |
| `Win+F8` | Backup all visible chats | No (read-only) |
| `Ctrl+Shift+F8` | Search and extract | Prompt for keyword |

## Technical Limitations

### WeChat Security
- WeChat uses custom UI controls
- Some data may not be accessible via standard Windows APIs
- May require OCR for image-based text
- Messages may be truncated in UI

### Workarounds
1. **Manual copy method**: Use Ctrl+C to copy selected messages
2. **Screenshot + OCR**: Capture and use OCR for image text
3. **Export from phone**: Use WeChat's built-in backup to PC feature
4. **Web WeChat**: Use web.wechat.com for easier automation (limited features)

## Bundled Scripts

### Extraction Scripts
- `scripts/extract_current_chat.ahk` - Extract active chat window
- `scripts/export_contacts.ahk` - Export contact list
- `scripts/search_messages.ahk` - Search and extract by keyword
- `scripts/backup_chats.ahk` - Batch backup multiple chats

### Utility Scripts
- `scripts/wechat_window_helper.ahk` - Window management utilities
- `scripts/ocr_helper.ahk` - OCR for image-based text

## Output Format

### Chat Export Format
```
Chat with: [Contact Name]
Date: [Export Date]
================================================

[Timestamp] [Sender]: Message text
[Timestamp] [Sender]: [Image/File]
...
```

### Contact Export Format
```
Name	Alias	Tags	Region
================================================
张三	张三(工作)	客户,重要	上海
...
```

## Usage Examples

### Example 1: Backup Important Work Chat
1. Open the work group chat in WeChat
2. Press `F8`
3. Data saved to Desktop with timestamp

### Example 2: Export All Contacts
1. Navigate to contacts page
2. Press `Ctrl+F8`
3. Contact list saved to file

### Example 3: Search for Specific Messages
1. Run `scripts/search_messages.ahk`
2. Enter search keyword when prompted
3. Review found messages
4. Confirm export

## Troubleshooting

### Window Not Detected
- Ensure WeChat window is not minimized
- Try clicking inside WeChat window first
- Check if WeChat version is compatible

### Text Extraction Empty
- WeChat may use custom rendering
- Try selecting text manually first
- Use screenshot + OCR as fallback

### Permission Denied
- Run script as Administrator if needed
- Check Windows Defender/antivirus
- Some WeChat versions block automation

## Privacy & Security

- All data stays on local machine
- No cloud upload or transmission
- User has full control over what gets extracted
- Recommended to delete exports after use

## Alternatives

If WeChat automation is limited:
1. **WeChat Web** (web.wechat.com) - Easier to automate but limited features
2. **Phone Export** - Use WeChat built-in backup feature
3. **Manual Export** - WeChat's official export tools
