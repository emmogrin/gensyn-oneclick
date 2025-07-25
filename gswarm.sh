#!/bin/bash

echo "╔══════════════════════════════════════╗"
echo "║     🛠️  Saint Khen Automation Bot     ║"
echo "║        Powered by @admirkhen         ║"
echo "╚══════════════════════════════════════╝"

echo ""
echo "🔧 Installing base dependencies..."
apt update -y && apt install -y curl git jq wget tar

echo ""
echo "📦 Installing Go 1.21.5..."
cd /tmp
wget -q https://go.dev/dl/go1.21.5.linux-amd64.tar.gz
rm -rf /usr/local/go
tar -C /usr/local -xzf go1.21.5.linux-amd64.tar.gz
echo 'export PATH=$PATH:/usr/local/go/bin:$HOME/go/bin' >> ~/.bashrc
source ~/.bashrc

echo ""
echo "⚙️ Installing GSwarm CLI..."
/usr/local/go/bin/go install github.com/Deep-Commit/gswarm/cmd/gswarm@latest
export PATH=$PATH:/usr/local/go/bin:$HOME/go/bin

echo ""
echo "📮 Enter your Telegram Bot Token:"
read BOT_TOKEN

echo "👤 Fetching your Telegram Chat ID..."
echo "👉 Send a message to your bot NOW, then press ENTER"
read

CHAT_JSON=$(curl -s https://api.telegram.org/bot$BOT_TOKEN/getUpdates)
CHAT_ID=$(echo "$CHAT_JSON" | jq -r '.result[-1].message.chat.id')

if [[ "$CHAT_ID" == "null" || -z "$CHAT_ID" ]]; then
  echo "❌ Failed to fetch chat ID. Make sure you messaged the bot."
  exit 1
fi

echo "🔑 Enter your EOA Wallet Address (starts with 0x...):"
read EOA

echo "💾 Saving config to ~/.config/gswarm/telegram.json ..."
mkdir -p ~/.config/gswarm
cat <<EOF > ~/.config/gswarm/telegram.json
{
  "bot_token": "$BOT_TOKEN",
  "chat_id": "$CHAT_ID",
  "wallet": "$EOA"
}
EOF

echo ""
echo "✅ Setup complete. Launching GSwarm with Telegram monitor..."
$HOME/go/bin/gswarm start --monitor telegram

echo ""
echo "📢 Back in Discord, run: /link-telegram to complete setup."
