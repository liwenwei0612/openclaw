#!/usr/bin/env node
import fs from 'node:fs';
import path from 'node:path';

function fail(msg) {
  console.error(`ERROR: ${msg}`);
  process.exitCode = 1;
}

const file = process.argv[2] || 'config.json';
const p = path.resolve(process.cwd(), file);

let raw;
try {
  raw = fs.readFileSync(p, 'utf8');
} catch (e) {
  console.error(`Cannot read: ${p}`);
  throw e;
}

let json;
try {
  json = JSON.parse(raw);
} catch (e) {
  console.error(`Invalid JSON in ${p}`);
  throw e;
}

if (!json || typeof json !== 'object' || Array.isArray(json)) {
  fail('Top-level must be an object');
}

const list = json.AiConfig;
if (!Array.isArray(list)) {
  fail('Missing/invalid AiConfig array');
}

const ids = new Map();

for (let i = 0; i < list.length; i++) {
  const e = list[i];
  const where = `AiConfig[${i}]`;

  if (!e || typeof e !== 'object' || Array.isArray(e)) {
    fail(`${where} must be an object`);
    continue;
  }

  // id
  if (typeof e.id !== 'number' || !Number.isFinite(e.id)) {
    fail(`${where}.id must be a finite number`);
  } else {
    if (ids.has(e.id)) {
      fail(`${where}.id duplicate: ${e.id} (also used at ${ids.get(e.id)})`);
    } else {
      ids.set(e.id, where);
    }
  }

  // name
  if (typeof e.name !== 'string' || e.name.trim() === '') {
    fail(`${where}.name must be a non-empty string`);
  }

  // url
  if (typeof e.url !== 'string' || !/^https?:\/\//.test(e.url)) {
    fail(`${where}.url must be an http(s) URL`);
  }

  // script
  if (typeof e.script !== 'string' || e.script.trim() === '') {
    fail(`${where}.script must be a non-empty string`);
  } else if (!e.script.includes('[message]')) {
    console.warn(`WARN: ${where}.script missing [message] placeholder`);
  }

  // iniScript optional
  if ('iniScript' in e && typeof e.iniScript !== 'string') {
    fail(`${where}.iniScript must be a string when present`);
  }
}

if (process.exitCode) {
  console.error('\nValidation failed.');
  process.exit(1);
} else {
  console.log(`OK: ${p}`);
  console.log(`Entries: ${list.length}`);
  console.log(`Unique ids: ${ids.size}`);
}
