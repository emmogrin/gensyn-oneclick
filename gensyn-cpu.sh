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

       🕊️  The Saints bless Gensyn – CPU only
          🔱 Follow the path: @admirkhen
EOF
echo -e "${NC}"

echo "📦 Updating packages..."
sudo apt update && sudo apt upgrade -y

echo "🛠 Installing essential tools and dependencies..."
sudo apt install screen curl iptables build-essential git wget lz4 jq make gcc nano \
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
npm install -g yarn --force

echo "🧵 Installing Yarn (alt path)..."
curl -o- -L https://yarnpkg.com/install.sh | bash
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
source ~/.bashrc

# 🔧 Install docker-buildx if missing
echo "🔧 Ensuring docker-buildx is available..."
if ! command -v docker-buildx &> /dev/null && [ ! -f "$HOME/.docker/cli-plugins/docker-buildx" ]; then
  echo "📦 Installing docker-buildx plugin..."
  mkdir -p ~/.docker/cli-plugins
  curl -sSL https://github.com/docker/buildx/releases/download/v0.12.1/buildx-v0.12.1.linux-amd64 -o ~/.docker/cli-plugins/docker-buildx
  chmod +x ~/.docker/cli-plugins/docker-buildx
fi

# 🔧 Clone RL-Swarm
if [ ! -d "rl-swarm" ]; then
  echo "📥 Cloning Gensyn RL-Swarm repo..."
  git clone https://github.com/gensyn-ai/rl-swarm.git
else
  echo "📁 RL-Swarm already exists, skipping clone."
fi

cd rl-swarm || exit 1

# 🐳 Run container directly
echo "🚀 Launching Gensyn CPU container..."
docker compose run --rm --build -it swarm-cpu
