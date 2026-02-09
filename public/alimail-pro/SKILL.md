---
name: alimail-pro
description: Advanced Alibaba Mail (阿里邮箱) desktop automation for email extraction, batch processing, contact management, and mailbox organization. Use when user needs to extract multiple emails, batch export attachments, manage folders, or perform repetitive email tasks. Extended version with more features than basic alimail skill.
---

# Alibaba Mail Pro (阿里邮箱专业版)

## Prerequisites

- Windows 10/11
- Alibaba Mail desktop client installed
- AutoHotkey v2 installed
- Logged into Alibaba Mail

## Safety Rules

- **Read-only by default**: Extract, copy, view data only
- **No auto-send**: Never send emails automatically
- **No auto-reply**: Never reply without explicit confirmation
- **Confirm before delete**: Any deletion requires user approval
- **Window focus**: Always verify correct window before actions

## Core Workflows

### 1. Email Extraction (邮件提取)

#### Extract Single Email
Extract full content from currently opened email:
- Subject
- Sender (name + email)
- Recipients
- Date/time
- Body (text + HTML if available)
- Attachment list

**Usage**: Open email, press `F8`
**Script**: `scripts/extract_email_full.ahk`

#### Batch Extract Multiple Emails
Extract emails from inbox/sent/folder:
- Navigate through email list
- Extract each email
- Save with organized naming

**Script**: `scripts/batch_extract_emails.ahk`

#### Extract Email List Only
Quick list of emails (metadata only):
- Subject
- Sender
- Date
- Size
- Has attachment?

### 2. Attachment Management (附件管理)

#### Batch Download Attachments
Download all attachments from:
- Current email
- Selected emails
- Entire folder

**Safety**: Prompts for download location, never auto-execute files

#### Extract Attachment List
List all attachments without downloading:
- Filename
- Size
- Type

### 3. Contact Extraction (联系人提取)

#### Export Address Book
Extract contacts from address book:
- Name
- Email
- Department
- Phone (if visible)
- Groups

**Script**: `scripts/export_address_book.ahk`

#### Extract from Email Headers
Extract contacts from received emails:
- Build contact list from correspondence
- Identify frequent contacts

### 4. Mailbox Organization (邮箱整理)

#### Folder Structure Export
Export folder structure:
- Folder names
- Email counts
- Storage sizes

#### Search and Extract
Search emails by:
- Keyword
- Date range
- Sender
- Has attachment
- Size

**Output**: Search results export

### 5. Email Templates (邮件模板)

#### Quick Template Insertion
Insert pre-defined templates:
- Welcome email
- Follow-up
- Quotation request
- Sample request

**Safety**: Template inserted but NOT sent - user edits and sends manually

## Hotkey Reference

| Hotkey | Function | Script |
|--------|----------|--------|
| `F8` | Extract current email | `extract_email_full.ahk` |
| `Ctrl+F8` | Batch extract emails | `batch_extract_emails.ahk` |
| `Shift+F8` | Download attachments | `download_attachments.ahk` |
| `Win+F8` | Export address book | `export_address_book.ahk` |
| `Ctrl+Shift+F8` | Search and export | `search_and_export.ahk` |

## Advanced Features

### Email Parsing
Automatically parse email content:
- Detect quotation requests
- Extract product mentions
- Identify urgency level
- Recognize contact info

### Export Formats
Multiple export formats supported:
- **TXT**: Plain text (default)
- **CSV**: Structured data for Excel
- **JSON**: Machine-readable format
- **HTML**: Preserved formatting

### Email Statistics
Generate mailbox statistics:
- Emails per day/week/month
- Top senders
- Response times
- Attachment sizes

## Bundled Scripts

### Extraction Scripts
- `scripts/extract_email_full.ahk` - Extract complete email data
- `scripts/extract_email_list.ahk` - Quick metadata extraction
- `scripts/batch_extract_emails.ahk` - Batch processing
- `scripts/download_attachments.ahk` - Attachment downloader

### Management Scripts
- `scripts/export_address_book.ahk` - Contact export
- `scripts/search_and_export.ahk` - Search + export
- `scripts/folder_structure.ahk` - Folder organization
- `scripts/email_statistics.ahk` - Generate stats

### Template Scripts
- `scripts/insert_template.ahk` - Template insertion
- `templates/` - Pre-defined email templates

## Output Organization

### File Naming Convention
```
Desktop\
└── AliMail_Export_YYYYMMDD\
    ├── Emails\
    │   ├── 001_[Subject]_[Sender]_[Date].txt
    │   ├── 002_[Subject]_[Sender]_[Date].txt
    │   └── ...
    ├── Attachments\
    │   └── [EmailID]_[Filename]
    ├── Contacts.csv
    └── Summary.txt
```

### CSV Format
```csv
ID,Date,Subject,Sender,Recipients,Size,HasAttachment,Folder
1,2024-01-15 10:30,Inquiry about products,client@example.com,user@company.com,156KB,Yes,Inbox
...
```

## Usage Examples

### Example 1: Backup All Inbox Emails
1. Navigate to Inbox
2. Press `Ctrl+F8`
3. Select range (all or specific emails)
4. Choose export format
5. Data saved to organized folder

### Example 2: Extract Customer Contacts
1. Open customer correspondence folder
2. Press `Win+F8`
3. Export address book + extract from email headers
4. Merge and deduplicate
5. Save as CSV

### Example 3: Download All Attachments from Project
1. Search for project keyword
2. Select result emails
3. Press `Shift+F8`
4. Choose download location
5. Attachments organized by email

## Troubleshooting

### Window Not Detected
- Ensure Alibaba Mail window is not minimized
- Check window title (may vary by version)
- Try clicking inside window first

### Email Body Not Extracting
- Some emails use rich HTML rendering
- Try using screenshot + OCR as fallback
- Check if email is fully loaded

### Attachments Not Downloading
- Large attachments may timeout
- Check disk space
- Verify write permissions to output folder

### Controls Not Accessible
- Run script as Administrator if needed
- Some controls may be protected
- Use coordinate-based fallback

## Tips & Best Practices

### Before Batch Operations
1. Test on single email first
2. Verify output format
3. Check disk space
4. Close unnecessary applications

### Data Privacy
- Extracted data stays on local machine
- No cloud upload
- Delete exports when no longer needed
- Be careful with sensitive emails

### Performance
- Large mailboxes: process in batches
- Close other heavy applications
- Use SSD for better performance

## Differences from Basic AliMail Skill

| Feature | Basic Skill | Pro Version |
|---------|-------------|-------------|
| Single email extract | ✅ | ✅ |
| Batch extract | ❌ | ✅ |
| Attachment download | ❌ | ✅ |
| Address book export | ❌ | ✅ |
| Search & export | ❌ | ✅ |
| Multiple formats | TXT only | TXT/CSV/JSON/HTML |
| Email templates | ❌ | ✅ |
| Statistics | ❌ | ✅ |

## Integration

This skill works well with:
- `alibaba-message-assistant` - Combine email + chat data
- `windows-autohotkey` - General Windows automation
- `alibaba-seller-workbench` - Seller platform integration
