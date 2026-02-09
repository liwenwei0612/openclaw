# Alibaba Message (OneTalk) stability playbook

Goal: make reading/summarizing workflows resilient when:
- OpenClaw Chrome Relay loses attachment (tab not found / no tab connected)
- OneTalk shows `网络连接已经断开` (websocket disconnect)

## Hard rules

1. **Never rely on tokenized URLs**
   - Do not paste/share URLs containing `chatToken`, `activeAccountIdEncrypt`, etc.
   - Always open clean entry URL and login normally.

2. **Confirm attachment before every run**
   - User must see: `🟢 Linked: <tab title>`
   - If not attached: ask user to click the Relay extension on the target tab.

3. **Detect OneTalk disconnect before extracting**
   - If page contains `网络连接已经断开`, stop and ask user to refresh (Ctrl+R) when available.

## Recommended operator workflow

### Start of day
- Open OneTalk web in Chrome.
- Attach Relay on that tab.
- Keep the tab open (avoid closing / sleeping the browser).

### When disconnected happens
1) Try **Ctrl+R** refresh
2) If still disconnected: logout → login
3) If still disconnected: switch network (Wi‑Fi ↔ hotspot)

## Automation design patterns

- **Checkpointing**: process conversations in batches (e.g., 10 at a time), persist progress to a file.
- **Idempotency**: do not send messages automatically; drafts only.
- **Fail fast**: if not attached or disconnected, do not attempt deep extraction.

## Minimal healthcheck

Use browser.evaluate() with this function:

```js
() => {
  const t = document.body?.innerText || '';
  return {
    disconnected: t.includes('网络连接已经断开'),
    loading: t.includes('Alibaba is loading'),
    url: location.href,
    ts: Date.now()
  };
}
```
