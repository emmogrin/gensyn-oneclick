#!/bin/bash

# 🌿 Colors
GREEN='\033[0;32m'
NC='\033[0m'

# 🌟 SAINT KHEN BANNER
echo -e "${GREEN}"
cat << "EOF"
███████╗ █████╗ ██╗███╗   ██╗████████╗    ██╗  ██╗██╗  ██╗███████╗███╗   ██╗
██╔════╝██╔══██╗██║████╗  ██║╚══██╔══╝    ██║ ██╔╝██║  ██║██╔════╝████╗  ██║
███████╗███████║██║██╔██╗ ██║   ██║       █████╔╝ ███████║█████╗  ██╔██╗ ██║
╚════██║██╔══██║██║██║╚██╗██║   ██║       ██╔═██╗ ██╔══██║██╔══╝  ██║╚██╗██║
███████║██║  ██║██║██║ ╚████║   ██║       ██║  ██╗██║  ██║███████╗██║ ╚████║
╚══════╝╚═╝  ╚═╝╚═╝╚═╝  ╚═══╝   ╚═╝       ╚═╝  ╚═╝╚═╝  ╚═╝╚══════╝╚═╝  ╚═══╝

       🕊️  The Saints bless Gensyn – GPU edition
          🔱 Follow the path: @admirkhen
EOF
echo -e "${NC}"

echo "📦 Updating packages..."
sudo apt update && sudo apt upgrade -y

echo "🛠 Installing essential tools and dependencies..."
sudo apt install curl iptables build-essential git wget lz4 jq make gcc nano \
automake autoconf tmux htop nvme-cli libgbm1 pkg-config libssl-dev libleveldb-dev \
tar clang bsdmainutils ncdu unzip -y

echo "🐍 Installing Python..."
sudo apt install python3 python3-pip python3-venv python3-dev -y

echo "🌐 Installing Node.js 22..."
curl -fsSL https://deb.nodesource.com/setup_22.x | sudo bash -
sudo apt install -y nodejs
node -v

echo "📦 Fixing yarn install (npm EEXIST)..."
sudo rm -f /usr/bin/yarn /usr/bin/yarnpkg
sudo npm install -g yarn --force

echo "🧵 Installing Yarn (alt path)..."
curl -o- -L https://yarnpkg.com/install.sh | bash
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
source ~/.bashrc

# 🐳 Check and install Docker if not present
if ! command -v docker &> /dev/null; then
  echo "🐋 Docker not found! Installing Docker..."
  curl -fsSL https://get.docker.com | sudo bash
  sudo usermod -aG docker $USER
  echo "✅ Docker installed. Please restart your terminal or run 'newgrp docker' to refresh permissions."
fi

# 🧱 Check and install Docker Compose V2 if not available
if ! docker compose version &> /dev/null; then
  echo "🧱 Docker Compose V2 not found! Installing manually..."
  DOCKER_COMPOSE_VERSION="v2.20.2"
  mkdir -p ~/.docker/cli-plugins
  curl -SL https://github.com/docker/compose/releases/download/$DOCKER_COMPOSE_VERSION/docker-compose-linux-x86_64 -o ~/.docker/cli-plugins/docker-compose
  chmod +x ~/.docker/cli-plugins/docker-compose
  echo "✅ Docker Compose V2 installed!"
fi

# 🔧 Check and install docker-buildx plugin if missing
echo "🔧 Ensuring docker-buildx is available..."
if [ ! -f "$HOME/.docker/cli-plugins/docker-buildx" ]; then
  echo "📦 Installing docker-buildx plugin..."
  mkdir -p ~/.docker/cli-plugins
  curl -sSL https://github.com/docker/buildx/releases/download/v0.12.1/buildx-v0.12.1.linux-amd64 -o ~/.docker/cli-plugins/docker-buildx
  chmod +x ~/.docker/cli-plugins/docker-buildx
fi

# 🔧 Clone RL-Swarm repo
if [ ! -d "rl-swarm" ]; then
  echo "📥 Cloning Gensyn RL-Swarm repo..."
  git clone https://github.com/gensyn-ai/rl-swarm.git
else
  echo "📁 RL-Swarm already exists, skipping clone."
fi

cd rl-swarm || exit 1

# ⚡ Launch GPU container
echo "⚡ Launching Gensyn GPU container..."
docker compose run --rm --build -it -p 3000:3000 swarm-gpu
