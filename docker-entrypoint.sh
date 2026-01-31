#!/bin/bash
set -e

echo "=========================================="
echo "🚀 Claude Forever Terminal Starting..."
echo "=========================================="

# Start SSH daemon
echo "📡 Starting SSH server..."
/usr/sbin/sshd

# Display system information
echo ""
echo "✅ System Ready!"
echo "Node.js: $(node --version)"
echo "NPM: $(npm --version)"
echo ""

# Check if Claude CLI is installed
if command -v claude &> /dev/null; then
    echo "✅ Claude CLI: $(claude --version)"
else
    echo "⚠️  Claude CLI not found. Install with: npm install -g @anthropic-ai/claude-code"
fi

echo ""
echo "=========================================="
echo "📱 Quick Start Commands:"
echo "=========================================="
echo "  tmux               - Start new tmux session"
echo "  tmux a             - Attach to existing session"
echo "  claude             - Launch Claude Code CLI"
echo "  claude auth login  - Authenticate Claude"
echo ""
echo "🎨 Tmux Shortcuts:"
echo "  Ctrl+B, D          - Detach from session"
echo "  Ctrl+B, C          - Create new window"
echo "  Ctrl+B, [          - Scroll mode (Q to exit)"
echo "=========================================="
echo ""

# Create initial tmux session if it doesn't exist
if ! tmux has-session -t claude 2>/dev/null; then
    echo "Creating initial 'claude' tmux session..."
    tmux new-session -d -s claude
    echo "✅ Session 'claude' created! Run 'tmux a' to attach."
fi

echo ""
echo "💡 Terminal is ready! Connect from your phone using Render Shell."
echo "🌟 This container will stay alive. Your tmux sessions persist!"
echo ""

# Start a dummy web server to keep Render health checks happy
echo "🌐 Starting health check server on port ${PORT:-80}..."
node -e "const http = require('http'); http.createServer((req, res) => { res.writeHead(200); res.end('ASTRAL Terminal is Online'); }).listen(process.env.PORT || 80);" &

# Keep container running
echo "♾️  Running indefinitely... (Ctrl+C to stop)"
sleep infinity
