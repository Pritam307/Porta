#!/usr/bin/env node
const { spawn } = require("child_process");
const { program } = require("commander");


program
  .requiredOption("-s, --server <server>", "SSH server (user@host)")
  .option("-l, --local-port <port>", "Local port to expose", "3000")
  .option("-r, --remote-port <port>", "Remote port on server", "9091")
  .parse(process.argv);

const opts = program.opts();
console.log(`🚀 Starting tunnel...`);
console.log(`   Local:  http://localhost:${opts.localPort}`);
console.log(`   Remote: http://${opts.server.split("@")[1]}:${opts.remotePort}`);


const ssh = spawn("ssh", [
    "-N",                        // no command, just tunnel
    "-R", `${opts.remotePort}:localhost:${opts.localPort}`,
    opts.server
  ], { stdio: "inherit" });
  
  ssh.on("exit", (code) => {
    console.log(`❌ Tunnel closed (exit code ${code})`);
  });
  
  process.on("SIGINT", () => {
    console.log("\n🛑 Closing tunnel...");
    ssh.kill("SIGINT");
    process.exit();
  });