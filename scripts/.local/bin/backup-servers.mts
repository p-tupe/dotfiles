#!/usr/bin/env node
/**
 * backup-servers.mts is a simple script that pulls up config from a .json file
 * for form ConfigItem[] and (assuming ssh config is set) uses rsync to pull
 * corresponding dirs from "from" into "to".
 */

import { exec, execSync } from "node:child_process";
import { existsSync, mkdirSync, readFileSync } from "node:fs";
import { resolve } from "node:path";

type ConfigItem = { from: string; to: string; exclude: string[] };

if (process.env.NOTIFY) {
  execSync(`${process.env.NOTIFY} 'Server backup started!'`);
} else {
  console.log("Server backup started!");
}

const rawCfg = readFileSync("./backup-servers-config.json", "utf8");
const cfg = JSON.parse(rawCfg) as ConfigItem[];

for (let { from, to, exclude } of cfg) {
  to = resolve(to);
  if (!existsSync(to)) mkdirSync(to, { recursive: true });

  exec(
    `rsync -azrq --partial ${exclude.map((f) => `--exclude '${f}'`).join(" ")} --delete --ignore-errors ${from} ${to}`,
    console.log,
  );
}

if (process.env.NOTIFY) {
  execSync(`${process.env.NOTIFY} 'Server backup complete!'`);
} else {
  console.log("Server backup complete!");
}
