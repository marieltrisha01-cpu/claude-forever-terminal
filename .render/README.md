# Claude Forever Terminal

A Docker-based persistent terminal environment for running Claude Code CLI 24/7 on Render.com.

## What's This?

This directory contains the Docker configuration to deploy a "forever terminal" on Render.com that:
- Runs Ubuntu 22.04 with Node.js and Claude CLI pre-installed
- Provides SSH access for remote connections
- Uses tmux for persistent sessions
- Accessible from phone or computer
- Completely FREE on Render's free tier

## Files

- **Dockerfile** - Container image definition
- **.tmux.conf** - Tmux configuration (mouse support, vi mode, custom styling)
- **docker-entrypoint.sh** - Startup script that initializes SSH and tmux

## Quick Deploy

1. Push this repo to GitHub
2. Create Render Cron Job service
3. Point to this repository
4. Deploy!

## Usage

Once deployed, access via:
- **Render Dashboard**: Shell tab in service page
- **Phone**: Termius/JuiceSSH with Render's SSH gateway
- **Computer**: SSH through Render's gateway

### Commands

```bash
tmux a              # Attach to session
claude auth login   # Authenticate Claude
claude              # Start coding with Claude!
```

## Features

✅ Node.js 20.x pre-installed  
✅ Claude Code CLI ready to use  
✅ Tmux with mouse support  
✅ SSH server configured  
✅ Auto-creates 'claude' tmux session on startup  
✅ Persistent across disconnects
