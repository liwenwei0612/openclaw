---
name: windows-autohotkey
description: Windows desktop automation using AutoHotkey v2 with safety-first patterns. Use when the user wants to automate Windows apps (e.g., Alibaba Mail desktop app) for read-only extraction like copying visible email/chat text, taking screenshots, activating windows, and saving outputs to files. Avoid any send/submit actions unless the user explicitly approves.
---

# Windows AutoHotkey (AHK v2) — safe desktop automation

## Safety rules (default)

- **Read-only by default**: copy text / capture screenshots / activate windows.
- **No sending**: never press Enter in message/email compose boxes; never click Send.
- **Explicit confirmation** required before any action that might submit data.

## Prereq

- Install AutoHotkey v2 (winget id `AutoHotkey.AutoHotkey`).

## Alibaba Mail (desktop app) — copy the currently opened email

Use `scripts/alimail_copy_active_email.ahk`.

Workflow:
1) Open the email in the Alibaba Mail desktop app.
2) Click inside the email body (so the body has focus).
3) Press **F8** → script copies the email body to clipboard, saves it to a timestamped `.txt` file on Desktop.

## Troubleshooting

- If the email body is not selectable, use the app’s built-in “View original / Export” if available.
- If the wrong window is active, click the correct app window then press the hotkey again.

## Bundled scripts

- `scripts/alimail_copy_active_email.ahk`: capture active email body (copy-only)
- `scripts/win_activate_and_copy.ahk`: generic helper (copy active control)
