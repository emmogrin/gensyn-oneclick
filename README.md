# 🧠 SAINT KHEN's Gensyn One-Click Node Setup

Simple one-click scripts to run [Gensyn's](https://gensyn.ai) RL-Swarm nodes via Docker — with full support for both **CPU-only** and **GPU** machines.

> ✨ *The Saints bless even the Sybils*  
> 🔱 Follow the path: [@admirkhen](https://twitter.com/admirkhen)

---

## 🚀 What's Inside?

- ✅ `gensyn-cpu.sh` — For CPU-only systems (VPS, laptops, WSL)
- ⚡ `gensyn-gpu.sh` — For NVIDIA CUDA-enabled machines

These scripts will:
- Install all dependencies
- Clone the RL-Swarm repo
- Build & run the Docker container
- Back up your Gensyn identity (`swarm.pem`)
- Optional LocalTunnel exposure for VPS users
  

---

## 📦 Requirements

- **Ubuntu 22.04+**
- **Docker** and **Docker Compose**
- **Internet connection**
- **GPU machine (for GPU version only)**
- **Create account on ( `https://dashboard.gensyn.ai/` )
- **Create huggingface account ( `https://huggingface.co/` )
---

## 🔧 How to use
---

# Step 1: Clone the repo && Run the Script

🧠 CPU-Only Systems
```
git clone https://github.com/emmogrin/gensyn-oneclick.git
cd gensyn-oneclick
chmod +x gensyn-cpu.sh
./gensyn-cpu.sh
```

🚀 GPU-Enabled Systems
```
git clone https://github.com/emmogrin/gensyn-oneclick.git
cd gensyn-oneclick
chmod +x gensyn-gpu.sh
./gensyn-gpu.sh
```

---

🌐 Accessing the Node Dashboard

👨‍💻 Local Users (PC, WSL, etc.)

Visit:
```
http://localhost:3000
```
🛰️ VPS Users

Run this in a separate terminal:
```
npx localtunnel --port 3000
```
This gives you a public URL like:
https://loose-cats-tickle.loca.lt

Paste that link in your browser to complete sign-in.
(your vps ip is your Tunnel password)
---

After login, your terminal starts installation.
Answer prompts:

Would you like to push models you train in the RL swarm to the Hugging Face Hub? [y/N] >>> Press N to join testnet
HuggingFace needs 2GB upload bandwidth for each model you train (Best if your are running on Vps), you can press Y, and enter your access-token.
Enter the name of the model you want to use in huggingface repo/name format, or press [Enter] to use the default model. >>> For default model, press Enter or choose one of these (More model parameters (B) need more vRAM):
Gensyn/Qwen2.5-0.5B-Instruct
Qwen/Qwen3-0.6B
nvidia/AceInstruct-1.5B
dnotitia/Smoothie-Qwen3-1.7B
Gensyn/Qwen2.5-1.5B-Instruct

---
# Incase of reboot or restart of Pc.
```
cd ~/gensyn-oneclick/rl-swarm
sudo docker compose run --rm --build swarm-cpu
```

🔐 How swarm.pem is Saved & Reused

Once you log in, Gensyn generates your identity file:
```
/app/rl-swarm/swarm.pem
```

✅ This script automatically backs it up to:
```
/backup/app/rl-swarm/swarm.pem
```
You can reuse this file on another machine or container by copying it back into the same path before running the node again.

To copy it out of Docker:
```
docker ps
```
```
docker cp <container_id>:/app/rl-swarm/swarm.pem .
```
To reuse it later, mount it in Docker or place it manually in the same directory.


---

📄 How to Check Logs

Inside the container, logs are stored at:
```
tail -f /app/rl-swarm/logs/latest.log
```
To check logs:

docker ps            # get container ID or name
docker exec -it <container_id_or_name> bash
cat /app/rl-swarm/logs/latest.log

You’ll see detailed events like:

Model loading

Network peer connections

Training rounds

Errors (if any)



---

🧼 Cleanup Tips

🧹 How to Delete Gensyn Files Only
To remove everything related to Gensyn (containers, repo folder, backups):
# 1. Stop any running containers (optional but safe)
```
docker ps
```
check for the container id and replace
```
docker stop <container_id>
```
# 2. Remove the RL Swarm repo and backup
```
rm -rf ~/gensyn-oneclick/rl-swarm
rm -rf ~/gensyn-oneclick/backup
```
This would remove everything in docker(not advice able)
To remove all Docker containers, images, and cache:
```
sudo docker container prune -f
sudo docker image prune -af
sudo docker volume prune -f
sudo docker builder prune -af
```

---

🙏 Credits

Created by SAINT KHEN

> Twitter: @admirkhen
GitHub: @emmogrin
Reference @0xmoei
