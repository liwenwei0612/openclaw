#!/usr/bin/env node
/**
 * onetalk_healthcheck.mjs
 *
 * Lightweight health checks for Alibaba OneTalk / Message web (weblitePWA).
 *
 * This script does NOT drive a browser. It's a helper library you can copy/paste
 * into browser.evaluate() and to normalize “are we connected?” logic.
 */

export function detectNetworkDisconnectText(text) {
  if (!text) return false;
  const t = String(text);
  return (
    t.includes('网络连接已经断开') ||
    t.toLowerCase().includes('network') && t.toLowerCase().includes('disconnect')
  );
}

export const HEALTHCHECK_EVAL_FN = `() => {
  const bodyText = (document.body && document.body.innerText) ? document.body.innerText : '';
  const disconnected = bodyText.includes('网络连接已经断开');
  const loading = bodyText.includes('Alibaba is loading');

  // Relay indicator (best-effort): some pages show '登录账号:'
  const loggedInHint = bodyText.includes('登录账号') || bodyText.includes('Messages') || bodyText.includes('消息');

  return {
    url: location.href,
    title: document.title,
    disconnected,
    loading,
    loggedInHint,
    ts: Date.now()
  };
}`;
