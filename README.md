# 🚀 Porta

> A friendly SSH tunneling application for exposing local services to the internet

Porta is a simple, command-line tool that creates secure SSH tunnels to expose your local development servers to the internet through a remote server. Perfect for testing webhooks, sharing local development work, or accessing your local services from anywhere.

## ✨ Features

- 🔒 **Secure**: Uses SSH for encrypted tunneling
- 🎯 **Simple**: One command to create tunnels
- 🌐 **Flexible**: Customizable local and remote ports
- 🚀 **Fast**: Lightweight and efficient
- 💻 **Cross-platform**: Works on Linux, macOS, and Windows

## 📦 Installation

### Quick Install

Install Porta with a single command:

```bash
curl -s https://raw.githubusercontent.com/Pritam307/Porta/main/install.sh | bash
```

This script will automatically:
- Detect your operating system and architecture
- Download the appropriate binary
- Verify checksums for security
- Install the binary to `/usr/local/bin/porta`
- Make it executable and available system-wide

### Manual Installation

If you prefer manual installation, download the appropriate binary for your system:
- `porta-linux-x64.zip` - Linux 64-bit
- `porta-linux-arm64.zip` - Linux ARM64
- `porta-macos-x64.zip` - macOS Intel
- `porta-macos-arm64.zip` - macOS Apple Silicon
- `porta-win-x64.zip` - Windows 64-bit

Then extract and install:
```bash
# Linux/macOS
unzip porta-linux-x64.zip
chmod +x porta
sudo mv porta /usr/local/bin/

# Windows
# Extract porta-win-x64.zip and add to PATH
```

### Binary Location

After installation, the `porta` binary will be stored at:
- **Linux/macOS**: `/usr/local/bin/porta`
- **Windows**: Wherever you extracted it (add to PATH)

## 🚀 Usage

### Basic Syntax

```bash
porta -s <user@host> -l <local-port> -r <remote-port>
```

### Parameters

- `-s, --server <server>`: SSH server in format `user@host` (required)
- `-l, --local-port <port>`: Local port to expose (default: 3000)
- `-r, --remote-port <port>`: Remote port on server (default: 9091)

### Examples

```bash
# Expose local port 3000 to remote port 9091
porta -s ubuntu@155.248.255.247 -l 3000 -r 9091

# Expose local port 8080 to remote port 80
porta -s user@example.com -l 8080 -r 80

# Expose local port 5000 to default remote port 9091
porta -s developer@myserver.com -l 5000
```

## 📋 What Happens When You Run Porta

When you start Porta, you'll see output like this:

```
🚀 Starting tunnel...
   Local:  http://localhost:3000
   Remote: http://155.248.255.247:9091
```

### What This Means

- **Local URL**: Your service running on `localhost:3000` is now accessible
- **Remote URL**: Anyone can access your local service via `http://155.248.255.247:9091`
- **Tunnel Status**: The connection stays active until you stop it (Ctrl+C)

### Stopping the Tunnel

Press `Ctrl+C` to gracefully close the tunnel:

```
🛑 Closing tunnel...
❌ Tunnel closed (exit code 0)
```

## 🔧 Prerequisites

- SSH access to your remote server
- SSH key authentication (recommended) or password access
- Your local service running on the specified port

## 🛠️ Setup Your Remote Server

Make sure your remote server allows SSH port forwarding:

1. Edit `/etc/ssh/sshd_config` on your server
2. Ensure these settings are enabled:
   ```
   GatewayPorts yes
   AllowTcpForwarding yes
   ```
3. Restart SSH service: `sudo systemctl restart ssh`

## 🔍 Troubleshooting

### Common Issues

**"Permission denied"**
- Ensure SSH key is properly configured
- Check if password authentication is enabled

**"Connection refused"**
- Verify your local service is running
- Check if the local port is correct

**"Port already in use"**
- Choose a different remote port
- Check if another tunnel is using the same port

### Debug Mode

For verbose output, you can run SSH directly:
```bash
ssh -N -R 9091:localhost:3000 ubuntu@155.248.255.247 -v
```

## 📄 License

MIT License - see [LICENSE](LICENSE) file for details.

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## 👨‍💻 Author

**Pritam Kundilya** - [GitHub](https://github.com/yourusername)

---

Made with ❤️ for developers who need simple, reliable tunneling
