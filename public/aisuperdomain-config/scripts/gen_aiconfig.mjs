#!/usr/bin/env node
/**
 * Generate an AISuperDomain AiConfig entry with a robust “set value + input event + send” script.
 *
 * Usage examples:
 *   node scripts/gen_aiconfig.mjs --id 999 --name "My AI" --url "https://example.com/chat" \
 *     --input "textarea" --send "button[aria-label='Send']"
 *
 *   node scripts/gen_aiconfig.mjs --id 1000 --name "Shadow AI" --url "https://..." \
 *     --shadow "cib-serp>#cib-action-bar-main>cib-text-input>#searchbox" \
 *     --sendShadow "cib-serp>#cib-action-bar-main>cib-text-input" --send "#submit"
 */

function arg(name) {
  const i = process.argv.indexOf(`--${name}`);
  if (i === -1) return undefined;
  return process.argv[i + 1];
}

function req(name) {
  const v = arg(name);
  if (!v) {
    console.error(`Missing --${name}`);
    process.exit(1);
  }
  return v;
}

function jsStr(s) {
  return JSON.stringify(String(s));
}

const id = Number(req('id'));
const name = req('name');
const url = req('url');

// Two modes:
// - simple DOM: --input <css> --send <css>
// - shadow DOM path for input: --shadow "host>inside>inside" and optional send traversal
const inputSelector = arg('input');
const sendSelector = arg('send');
const shadowPath = arg('shadow');
const sendShadowPath = arg('sendShadow');

if (!Number.isFinite(id)) {
  console.error('--id must be a number');
  process.exit(1);
}

if (!/^https?:\/\//.test(url)) {
  console.error('--url must start with http(s)://');
  process.exit(1);
}

if (!sendSelector) {
  console.error('Missing --send <css>');
  process.exit(1);
}

if (!inputSelector && !shadowPath) {
  console.error('Provide either --input <css> or --shadow <path>');
  process.exit(1);
}

function buildShadowTraverse(pathStr) {
  // Format: "host>inside>inside" (each token used as querySelector)
  const parts = String(pathStr)
    .split('>')
    .map(s => s.trim())
    .filter(Boolean);
  if (parts.length === 0) throw new Error('Empty shadow path');

  // host is normal querySelector; then .shadowRoot.querySelector for subsequent parts
  let expr = `document.querySelector(${jsStr(parts[0])})`;
  for (let i = 1; i < parts.length; i++) {
    expr = `${expr}?.shadowRoot?.querySelector(${jsStr(parts[i])})`;
  }
  return expr;
}

const inputExpr = shadowPath
  ? buildShadowTraverse(shadowPath)
  : `document.querySelector(${jsStr(inputSelector)})`;

const sendBaseExpr = sendShadowPath
  ? buildShadowTraverse(sendShadowPath)
  : 'document';

const sendExpr = sendShadowPath
  ? `${sendBaseExpr}?.shadowRoot?.querySelector(${jsStr(sendSelector)})`
  : `document.querySelector(${jsStr(sendSelector)})`;

const script = `(function(){
  const el = ${inputExpr};
  if(!el){ console.error('Input not found'); return; }

  const msg = '[message]';

  // Prefer native setter for React/controlled inputs
  const tag = (el.tagName||'').toLowerCase();
  const proto = tag === 'textarea' ? HTMLTextAreaElement.prototype : HTMLInputElement.prototype;
  const setter = Object.getOwnPropertyDescriptor(proto,'value')?.set;
  if(setter){ setter.call(el,msg); } else { el.value = msg; }

  el.dispatchEvent(new Event('input',{bubbles:true}));
  el.dispatchEvent(new Event('change',{bubbles:true}));

  // Try click send
  setTimeout(()=>{
    const btn = ${sendExpr};
    if(btn){ try{ btn.disabled=false; }catch(e){} btn.click(); return; }
    // Fallback: Enter
    el.dispatchEvent(new KeyboardEvent('keydown',{key:'Enter',code:'Enter',keyCode:13,which:13,bubbles:true,cancelable:true}));
  }, 300);
})();`;

const entry = {
  id,
  name,
  url,
  script,
  iniScript: ''
};

process.stdout.write(JSON.stringify(entry, null, 2) + '\n');
