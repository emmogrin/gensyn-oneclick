# 🐝 Set Up GSwarm Telegram Bot (Manual Guide — VPS/PC Only)

## 📌 Purpose: Monitor your Gensyn Swarm node using Telegram, and unlock The Swarm role in Discord.


---

# ⚙️ Requirements

Before you begin:

✅ Ubuntu/Debian VPS or local PC terminal 

✅ Telegram installed

✅ Discord account joined to Gensyn Discord

✅ Gensyn Swarm node already running

✅ Your EOA wallet address (from Gensyn dashboard)



---

🖥 Step 1: Create a Screen Session (Keeps It Running)
```
screen -S gswarm
```

This opens a screen session named gswarm so your monitor won’t stop even if the terminal disconnects.


---

🔧 Step 2: Install Go and GSwarm

1. Install Go (v1.22.4):
```
sudo rm -rf /usr/local/go
curl -L https://go.dev/dl/go1.22.4.linux-amd64.tar.gz | sudo tar -xzf - -C /usr/local
echo 'export PATH=$PATH:/usr/local/go/bin:$HOME/go/bin' >> ~/.bashrc
source ~/.bashrc
go version
```
2. Install GSwarm CLI:
```
go install github.com/Deep-Commit/gswarm/cmd/gswarm@latest
```
3. Confirm Installation:
```
gswarm --version
```

---

🤖 Step 3: Set Up Telegram Bot

1. Create a Bot:

Open Telegram, search @BotFather

Send /newbot, choose name + username

Save the bot token it gives you (format: 123456789:ABC...)

[![IMG-20250726-WA0001.jpg](https://i.postimg.cc/63qS0tQY/IMG-20250726-WA0001.jpg)](https://postimg.cc/Q9L0NL1T)


2. Send a Message to Your Bot:

Say “hi” to your new bot so it recognizes you( say it 5 times).

3. Get Your Telegram Chat ID:

Paste this in browser (replace YOUR_TOKEN with your actual token):
eg: https://apitelegram.org/bot83270137371:AAElazOulSi8yv8pP446euuehs2NWSVpAJS4/getUpdates
```
https://api.telegram.org/botYOUR_TOKEN/getUpdates
```
Look for:

"chat": {
  "id": 123456789
}
That id is your Telegram Chat ID ( id alone is written before the number)

[![Screenshot-20250726-034311-Chrome.jpg](https://i.postimg.cc/GtJkTs1N/Screenshot-20250726-034311-Chrome.jpg)](https://postimg.cc/T51yZ11q)


---

⚙️ Step 4: Launch GSwarm and Configure (back in your vps/pc terminal )

Run:
```
gswarm
```
Follow prompts:

Paste your Telegram Bot Token

Enter your Telegram Chat ID

Paste your EOA wallet address (from Gensyn dashboard)

[![Screenshot-4.png](https://i.postimg.cc/BQHzNhq9/Screenshot-4.png)](https://postimg.cc/8jkwzmJt)

If successful:

✅ Setup complete. Launching GSwarm with Telegram monitor...

Leave the screen session running. To detach from screen:

Ctrl + A, then press D

To re-enter later:

screen -r gswarm


---

🔗 Step 5: Link Your Telegram with Discord

1. On Gensyn [Swarm link Discord ](https://discord.com/channels/852932483691577395/1397909075685146804), type:
```
/link-telegram
```

2. You’ll be giving a code to paste in your Telegram Bot...
Looks like this:  /verify 4Q478483

You’ll receive confirmation + be assigned The Swarm role.😁


---

✅ Done

You're now fully set up — GSwarm is running in the background, and alerts will reach your Telegram!
