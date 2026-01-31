FROM ubuntu:22.04

# Prevent interactive prompts during installation
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=UTC

# Install essential packages
RUN apt-get update && apt-get install -y \
    curl \
    wget \
    git \
    tmux \
    nano \
    vim \
    openssh-server \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Install Node.js 20.x (required for Claude CLI)
RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash - \
    && apt-get install -y nodejs \
    && rm -rf /var/lib/apt/lists/*

# Install AI Development CLIs
RUN npm install -g @anthropic-ai/claude-code \
    && npm install -g @atlassian/forge \
    && npm install -g opencode \
    && npm install -g minimax-cli \
    && npm install -g @google/gemini-cli \
    && npm install -g @atlassian/cli || echo "Some packages failed but continuing..."

# Setup SSH server
RUN mkdir -p /var/run/sshd /root/.ssh \
    && chmod 700 /root/.ssh \
    && sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config \
    && sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config

# Configure tmux
COPY .tmux.conf /root/.tmux.conf

# Create workspace and data directories
RUN mkdir -p /workspace /data
WORKDIR /workspace

# Symlink persistent data if needed (Render Disks)
# We will use /data for persistent storage

# Copy entrypoint script
COPY docker-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

# Expose SSH port (Render handles this internally)
EXPOSE 22

# Set entrypoint
ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]
