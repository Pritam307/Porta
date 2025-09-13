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
porta -l <local-port>
```

### Parameters

- `-l, --local-port <port>`: Local port to expose (required)

### Examples

```bash
# Expose local port 3000 with auto-assigned remote port
porta -l 3000

# Expose local port 8080 with auto-assigned remote port
porta -l 8080

# Expose local port 5000 with auto-assigned remote port
porta -l 5000
```

### How It Works

Porta automatically:
- Connects to the tunnel server at `tunnel.joinmyprojects.dpdns.org`
- Assigns an available remote port (10000-10100 range)
- Creates a secure SSH tunnel between your local port and the remote port
- Provides a public URL for accessing your local service

## 📋 What Happens When You Run Porta

When you start Porta, you'll see output like this:

```
🚀 Starting tunnel...
   Local:  http://localhost:3000
   Remote port on server: https://10001.tunnel.joinmyprojects.dpdns.org
```

### What This Means

- **Local URL**: Your service running on `localhost:3000` is now accessible
- **Remote URL**: Anyone can access your local service via `https://10001.tunnel.joinmyprojects.dpdns.org` (port number will vary)
- **Tunnel Status**: The connection stays active until you stop it (Ctrl+C)
- **Port Management**: Porta automatically assigns an available port (10000-10100) and tracks it

### Stopping the Tunnel

Press `Ctrl+C` to gracefully close the tunnel:

```
🛑 Closing tunnel...
❌ Tunnel closed (exit code 0)
```

## 🔧 Prerequisites

- SSH access to the tunnel server
- Your local service running on the specified port
- No additional server setup required - Porta handles everything automatically!

## 🔍 Troubleshooting

### Common Issues

**"No available ports!"**
- All ports in the 10000-10100 range are currently in use
- Wait for other users to free up ports or try again later

**"Connection refused"**
- Verify your local service is running on the specified port
- Check if the local port is correct

**"Permission denied"**
- Ensure SSH key is properly configured for the tunnel server
- Check if password authentication is enabled

**"Port already in use"**
- Porta automatically manages port assignment, so this shouldn't happen
- If it occurs, try running Porta again - it will find the next available port

### Debug Mode

For verbose SSH output, you can run SSH directly:
```bash
ssh -N -R 10001:localhost:3000 ubuntu@tunnel.joinmyprojects.dpdns.org -v
```

## 📄 License

MIT License - see [LICENSE](LICENSE) file for details.

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## 👨‍💻 Author

**Pritam Kundilya** - [GitHub](https://github.com/yourusername)

---

Made with ❤️ for developers who need simple, reliable tunneling
