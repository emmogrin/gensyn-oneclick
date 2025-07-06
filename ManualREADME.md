# MANUAL BACKUP GUIDE.( DONT USE IF YOU DON'T UNDERSTAND)

```
screen -S gensyn
```
```
sudo apt update && sudo apt install -y python3 python3-venv python3-pip curl wget screen git lsof
```
```
python3 --version
```
```
curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash - && sudo apt update && sudo apt install -y nodejs
```
```
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list > /dev/null
```
```
sudo apt update && sudo apt install -y yarn
```
```
node -v
```
```
npm -v
```
```
yarn -v
```
```
cd $HOME && rm -rf gensyn-testnet && git clone https://github.com/zunxbt/gensyn-testnet.git && chmod +x gensyn-testnet/gensyn.sh && ./gensyn-testnet/gensyn.sh
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

# Get your swarm.pem file with this
```
  [ -f backup.sh ] && rm backup.sh; curl -sSL -O https://raw.githubusercontent.com/AbhiEBA/gensyn1/main/backup.sh && chmod +x backup.sh && ./backup.sh
```

