



<div align="center">

# 🐝 Gensyn RL-Swarm Node Setup

_High-performance compute from anywhere — Setup Guide by [@admirkhen](https://github.com/emmogrin)_

</div>

---

## ✅ Recommended System Requirements

> From official Gensyn suggestions:
- **OS:** Ubuntu 20.04 / 22.04
- **CPU:** 4–8 cores (CPU-only works!)
- **RAM:** 8 GB minimum
- **Python:** 3.8+
- **Node.js:** v20.x
- **Internet:** Stable connection

---

## ⚙️ Option 1: Basic Node Setup (Recommended for Beginners)

### Step 1: Install Essentials

```bash
sudo apt update && sudo apt install -y python3 python3-venv python3-pip \
git curl wget screen lsof build-essential
```

Step 2: Install Node.js & Yarn
```
curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
sudo apt install -y nodejs
```
```
echo "deb https://dl.yarnpkg.com/debian/ stable main" | \
sudo tee /etc/apt/sources.list.d/yarn.list > /dev/null
sudo apt update && sudo apt install -y yarn
```
Check versions:
```
node -v && npm -v && yarn -v
```

---

Step 3: Start a Screen Session
```
screen -S gensyn
```
> This keeps your node running even if terminal is closed.

Step 4: Clone & Run the Swarm Node
```
git clone https://github.com/gensyn-ai/rl-swarm.git
cd rl-swarm
python3 -m venv .venv
source .venv/bin/activate
./run_rl_swarm.sh
```

# now in another terminal.
copy the link you see and paste in your browser to login.
```
sudo apt install ufw -y
sudo ufw allow 22
sudo ufw allow 3000/tcp
```
```
sudo ufw enable
```
```
wget -q https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64.deb
```
```
sudo dpkg -i cloudflared-linux-amd64.deb
```
```
cloudflared --version
```
```
cloudflared tunnel --url http://localhost:3000
```

When prompted:

Push model to HuggingFace? → Type: N (consumes 2gb per push, if you have the capacity enter y)

Model name? → Just press Enter (leave default if using a cpu)



---

🧠 Screen Controls

Detach: Ctrl + A, then D

Reconnect: screen -r gensyn

Kill session: screen -S gensyn -X quit


# Get your swarm.pem file with this (use it inside rl-swarm to copy and export swarm.pem)
```
  [ -f backup.sh ] && rm backup.sh; curl -sSL -O https://raw.githubusercontent.com/AbhiEBA/gensyn1/main/backup.sh && chmod +x backup.sh && ./backup.sh
```

