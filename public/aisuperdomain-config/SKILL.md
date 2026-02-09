---
name: aisuperdomain-config
description: Maintain and extend the win4r/AISuperDomain (AI超元域/Aila) desktop app configuration, especially config.json AiConfig entries that define embedded web-AI tabs (name/url/script/iniScript). Use when adding a new AI provider, fixing a broken automation script after a site UI change, validating config.json structure/IDs/placeholders, or extracting/updating the JavaScript DOM automation snippets.
---

# AISuperDomain config.json workflow

## What to edit

- Primary file: `config.json`
- Key list: `AiConfig` array
- Each entry typically includes:
  - `id` (number; must be unique)
  - `name` (string shown in UI)
  - `url` (tab URL)
  - `script` (JS snippet that injects the message and triggers “send”; uses `[message]` placeholder)
  - `iniScript` (optional JS run on init)

## Safe editing loop (recommended)

1. Make a backup copy of `config.json` (or rely on git).
2. Edit JSON (keep it valid; double quotes, commas, no trailing commas).
3. Validate quickly:
   - Run `node scripts/validate_config.mjs <path-to-config.json>`.
4. If you are adding a new provider, generate a starter entry:
   - Run `node scripts/gen_aiconfig.mjs --id <id> --name "..." --url "..." --input "..." --send "..."`.
5. If you changed a `script`, sanity-check it in a real browser:
   - Open the `url`.
   - Paste the JS into DevTools Console.
   - Ensure it finds the input element, injects text, dispatches `input`, then triggers the correct send button.

## Adding a new AI entry (template)

- Start from the closest existing provider (same UI framework).
- Keep the placeholder exactly: `[message]`.
- Prefer robust selectors:
  - `aria-label`, `data-testid`, stable ids
  - Avoid brittle nth-child selectors

Minimal example shape:

```json
{
  "id": 999,
  "name": "New AI",
  "url": "https://example.com/chat",
  "script": "(function(){ /* find textbox, set value to '[message]', dispatch input, click send */ })();",
  "iniScript": ""
}
```

## Common failure modes

- Site moved input into Shadow DOM / iframe → selector must traverse `shadowRoot` or target iframe.
- React-controlled input ignores `element.value = ...` → must use native setter:
  - `Object.getOwnPropertyDescriptor(HTMLTextAreaElement.prototype, 'value').set.call(el, text)`
  - then dispatch `new Event('input', { bubbles:true })`
- Send button disabled until input event fires.

## Repo notes

- Repo: https://github.com/win4r/AISuperDomain
- Config examples live in the repo root `config.json`.

## When to read bundled resources

- Read `scripts/validate_config.mjs` when you need to extend validations (schema changes, new required fields).
- Read `scripts/gen_aiconfig.mjs` when you want a fast, consistent starter `AiConfig` entry from selectors.
- Read `references/config-schema.md` when you need a quick checklist of invariants (unique ids, required keys, placeholder rules).
