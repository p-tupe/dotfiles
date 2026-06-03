#!/opt/homebrew/bin/node
/**
 * backup-servers.mts is a simple script that pulls up config from a .json file
 * for form ConfigItem[] and (assuming ssh config is set) uses rsync to pull
 * corresponding dirs from "from" into "to".
 *
 * Usage: ./backup-servers.mts /path/to/config.json
 *
 * Config: [{from: "", to: "", exclude: ["", ""]}, ...]
 */

import { exec, execSync } from "node:child_process";
import { existsSync, mkdirSync, readFileSync } from "node:fs";
import { resolve } from "node:path";
import { argv, exit } from "node:process";

if (!argv[2]) {
  console.error("Please pass a config.json!");
  console.error("Usage: ./backup-servers.mts /path/to/config.json");
  exit(1);
}

type ConfigItem = { from: string; to: string; exclude: string[] };

console.log(`${new Date().toLocaleString()} Server backup started...`);
if (process.env.NOTIFY) {
  execSync(`${process.env.NOTIFY} 'Server backup started...'`);
}

const rawCfg = readFileSync(argv[2], "utf8");
const cfg = JSON.parse(rawCfg) as ConfigItem[];

for (let { from, to, exclude } of cfg) {
  to = resolve(to);
  if (!existsSync(to)) mkdirSync(to, { recursive: true });

  await (async () =>
    new Promise((res, rej) => {
      exec(
        `rsync -azrq --partial ${exclude.map((f) => `--exclude '${f}'`).join(" ")} --delete --ignore-errors ${from} ${to}`,
        (err) => (err ? rej(err.message) : res("")),
      );
    }))().catch(console.error);
}

console.log(`${new Date().toLocaleString()} Server backup complete!`);
if (process.env.NOTIFY) {
  execSync(`${process.env.NOTIFY} 'Server backup complete!'`);
}
