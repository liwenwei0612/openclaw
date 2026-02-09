# config.json (AISuperDomain) — schema checklist

## Top-level

- JSON object
- Contains key: `AiConfig` (Array)

## AiConfig[] entry

Required keys (recommended):

- `id`: number (integer); **unique across AiConfig**
- `name`: string; non-empty
- `url`: string; starts with `http://` or `https://`
- `script`: string; must include the placeholder **`[message]`** exactly
- `iniScript`: string (may be empty)

Notes:

- Some entries in the wild may omit `iniScript`; validator can treat missing as OK.
- `script` is executed as-is; keep it self-invoking `(function(){ ... })();` to avoid leaking vars.

## Robust script patterns

### React/controlled textarea

Use native setter + input event:

```js
const el = document.querySelector('textarea');
const set = Object.getOwnPropertyDescriptor(HTMLTextAreaElement.prototype, 'value').set;
set.call(el, '[message]');
el.dispatchEvent(new Event('input', { bubbles: true }));
```

### Press Enter

```js
el.dispatchEvent(new KeyboardEvent('keydown', { key: 'Enter', code: 'Enter', keyCode: 13, which: 13, bubbles: true }));
```

### Shadow DOM traversal

```js
const host = document.querySelector('cib-serp');
const inside = host.shadowRoot.querySelector('#something').shadowRoot.querySelector('textarea');
```

## Invariants

- ids unique
- no empty name/url/script
- script contains `[message]`
- config is valid JSON (no trailing commas)
