#!/bin/bash

echo "╔══════════════════════════════════════╗"
echo "║     🛠️  Saint Khen Automation Bot     ║"
echo "║        Powered by @admirkhen         ║"
echo "╚══════════════════════════════════════╝"

echo ""
echo "🔧 Installing dependencies..."
apt update -y && apt install -y curl git jq

echo "📦 Installing Go 1.21.5..."
cd /tmp
curl -LO https://go.dev/dl/go1.21.5.linux-amd64.tar.gz
rm -rf /usr/local/go
tar -C /usr/local -xzf go1.21.5.linux-amd64.tar.gz
export PATH=$PATH:/usr/local/go/bin
echo 'export PATH=$PATH:/usr/local/go/bin' >> ~/.bashrc

echo "⚙️ Installing GSwarm CLI..."
curl -sSfL https://raw.githubusercontent.com/gswarm-labs/cli/main/install.sh | sh

echo ""
echo "📮 Enter your Telegram Bot Token:"
read BOT_TOKEN

echo "👤 Fetching your Telegram Chat ID..."
echo "👉 Now send a message to your bot in Telegram, then press ENTER"
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
gswarm start --monitor telegram

echo ""
echo "📢 Now go back to the Discord and run: /link-telegram"
