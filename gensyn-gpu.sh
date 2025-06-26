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

echo "⚔️ Removing conflicting Yarn binaries..."
sudo rm -f /usr/bin/yarn /usr/bin/yarnpkg

echo "🧵 Installing Yarn (safe method)..."
npm install -g yarn --force
yarn -v

# 🔧 Clone RL-Swarm
if [ ! -d "rl-swarm" ]; then
  echo "📥 Cloning Gensyn RL-Swarm repo..."
  git clone https://github.com/gensyn-ai/rl-swarm.git
else
  echo "📁 RL-Swarm already exists, skipping clone."
fi

cd rl-swarm || exit 1

# 🛠️ Check docker buildx plugin
if ! command -v docker-buildx &> /dev/null && [ ! -f "/usr/local/lib/docker/cli-plugins/docker-buildx" ]; then
  echo "⚠️  docker-buildx plugin is missing. Attempting to install..."
  mkdir -p ~/.docker/cli-plugins
  curl -sSL https://github.com/docker/buildx/releases/download/v0.11.2/buildx-v0.11.2.linux-amd64 -o ~/.docker/cli-plugins/docker-buildx
  chmod +x ~/.docker/cli-plugins/docker-buildx
fi

# 🐳 Launch GPU node
echo "⚡ Launching Gensyn GPU container..."
docker compose run --rm --build -it swarm-gpu
