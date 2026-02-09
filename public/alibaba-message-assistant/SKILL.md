---
name: alibaba-message-assistant
description: Automate and assist Alibaba Message (Alibaba International / TradeManager-like) workflows on Windows: draft inquiry replies (confirm-before-send), extract/organize chat history, generate daily 17:00 summaries with next-action reminders, and maintain a lightweight CRM-style log. Use when the user wants to handle Alibaba inquiries/messages faster, create English replies from Chinese intent, or turn message threads into structured leads + follow-ups.
---

# Alibaba Message Assistant (Windows-first)

## Operating mode (recommended)

- **Confirm-before-send**: always generate a draft reply first; user confirms; only then send.
- **Browser fallback**: if the Windows client is hard to automate reliably, open the same conversation in **Alibaba Message web** in Chrome and automate there.

## What I need from the user (once)

1) Which app exactly?
   - “Alibaba Message” desktop client (screenshot of title bar)
2) Login status: already logged in.
3) If using web fallback: attach the tab via OpenClaw Browser Relay (badge ON).

## Core workflows

### 1) Draft reply to a new message / inquiry

Ask for or capture:
- product / size / thickness / material
- quantity + target price (if any)
- destination country/port
- required lead time
- sample needed? printing/artwork?

Output:
- 3 English options (steady / friendly / firmer)
- 3 short questions to qualify the lead
- suggested next step (quote, sample, call, catalog, MOQ)

### 2) Convert chat thread → structured lead card

Produce a compact lead card:
- Company/person (if known)
- Country / channel
- Product interest
- Qty/MOQ sensitivity
- Price signal (high/medium/low)
- Timeline
- Risk flags
- Next action + due date

### 3) Daily digest at 17:00

At 17:00 (Asia/Shanghai), compile:
- Top 5 hottest leads
- Threads that need follow-up
- Open questions from customers
- Draft follow-up messages

## Data capture options (choose what’s available)

A) **Best**: Web Alibaba Message + browser tool
- I can read the conversation DOM and summarize reliably.
- If reliability issues happen, follow `references/stability-playbook.md`.
- Use `scripts/onetalk_healthcheck.mjs` eval snippet to detect disconnects early.

B) **OK**: Desktop client manual export/copy
- User copies last N messages (or exports) and pastes into chat.

C) **Fallback**: screenshots
- User sends screenshots; I extract key info and summarize.

## Where to store notes

- Write daily summaries to `memory/YYYY-MM-DD.md`.
- Keep a rolling pipeline list in `memory/alibaba-pipeline.md` (create if missing).

## Safety rules

- Never send automatically without explicit user confirmation.
- Don’t promise price/lead time; always ask user if uncertain.
- Don’t store sensitive info beyond what’s needed for follow-up.
