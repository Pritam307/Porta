#!/usr/bin/env node
const { spawn } = require("child_process");
const { program } = require("commander");
const dotenv = require("dotenv");
dotenv.config();

const SSH_USER = "ubuntu";
const HOST = "tunnel.joinmyprojects.dpdns.org";
const SERVER_PORT = 9091;


program
  .requiredOption("-l, --local-port <port>", "Local port to expose")
  .parse(process.argv);

const opts = program.opts();

console.log(`🚀 Starting tunnel...`);
console.log(`   Local:  http://localhost:${opts.localPort}`);
console.log(`   Remote: https://${HOST}`);

const ssh = spawn(
  "ssh",
  [
    "-N", // no command, just tunnel
    "-R",
    `${SERVER_PORT}:localhost:${opts.localPort}`,
    `${SSH_USER}@${HOST}`,
  ],
  { stdio: "inherit" }
);

ssh.on("exit", (code) => {
  console.log(`❌ Tunnel closed (exit code ${code})`);
});

process.on("SIGINT", () => {
  console.log("\n🛑 Closing tunnel...");
  ssh.kill("SIGINT");
  process.exit();
});
