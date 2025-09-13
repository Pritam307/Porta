#!/usr/bin/env node
const fs = require("fs");
const { spawn } = require("child_process");
const { program } = require("commander");
const path = require("path");

const START_PORT = 10000;
const END_PORT = 10100;
const ACTIVE_FILE = "/tmp/active_ports.json";

// Read SSH config from environment or hardcoded
const SSH_USER = "ubuntu";
const HOST = "tunnel.joinmyprojects.dpdns.org";

// Ensure active ports file exists
if (!fs.existsSync(ACTIVE_FILE)) {
  fs.writeFileSync(ACTIVE_FILE, "{}");
}

// Load active ports
let active = JSON.parse(fs.readFileSync(ACTIVE_FILE, "utf-8"));

// Find next free port
let port = START_PORT;
while (active[port] && port <= END_PORT) port++;

if (port > END_PORT) {
  console.error("❌ No available ports!");
  process.exit(1);
}

// CLI options
program
  .requiredOption("-l, --local-port <port>", "Local port to expose")
  .parse(process.argv);

const opts = program.opts();

// Assign the port to this user
active[port] = { localPort: opts.localPort, timestamp: Date.now() };
fs.writeFileSync(ACTIVE_FILE, JSON.stringify(active, null, 2));

console.log(`🚀 Starting tunnel...`);
console.log(`   Local:  http://localhost:${opts.localPort}`);
console.log(`   Remote port on server: https://${port}.${HOST}`);


const ssh = spawn(
  "ssh",
  ["-N", "-R", `${port}:localhost:${opts.localPort}`, `${SSH_USER}@${HOST}`],
  { stdio: "inherit" }
);

// Cleanup on exit
function cleanup() {
  console.log("\n🛑 Closing tunnel...");
  ssh.kill("SIGINT");

  // Remove port from active file
  delete active[port];
  fs.writeFileSync(ACTIVE_FILE, JSON.stringify(active, null, 2));

  process.exit();
}

process.on("SIGINT", cleanup);
process.on("SIGTERM", cleanup);

ssh.on("exit", (code) => {
  console.log(`❌ Tunnel closed (exit code ${code})`);
  cleanup();
});
