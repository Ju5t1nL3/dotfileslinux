#!/bin/bash
set -e # Exit immediately if a command fails

echo "🚀 Starting Setup..."

# 1. Update & Basics
echo "📦 Updating repositories and installing base tools..."
sudo apt update
sudo apt install -y git curl wget unzip build-essential stow

# 2. Fish Shell (Simple Install)
echo "🐟 Installing Fish Shell..."
sudo apt install -y fish

# 3. Starship Prompt (Detected in your config)
echo "🚀 Installing Starship..."
curl -sS https://starship.rs/install.sh | sh -s -- -y

# 4. Eza (Modern ls)
echo "📂 Installing Eza..."
sudo mkdir -p /etc/apt/keyrings
wget -qO- https://raw.githubusercontent.com/eza-community/eza/main/deb.asc | sudo gpg --dearmor -o /etc/apt/keyrings/gierens.gpg
echo "deb [signed-by=/etc/apt/keyrings/gierens.gpg] http://deb.gierens.de stable main" | sudo tee /etc/apt/sources.list.d/gierens.list
sudo chmod 644 /etc/apt/keyrings/gierens.gpg /etc/apt/sources.list.d/gierens.list
sudo apt update
sudo apt install -y eza

# 5. Bat (Modern cat)
echo "🦇 Installing Bat..."
sudo apt install -y bat
# Ubuntu names it 'batcat', rebuild cache for themes
if command -v batcat &> /dev/null; then
    batcat cache --build
fi

# 6. Lazygit (Binary Install)
echo "📦 Installing Lazygit..."
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/download/v${LAZYGIT_VERSION}/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar xf lazygit.tar.gz lazygit
sudo install lazygit /usr/local/bin
rm lazygit lazygit.tar.gz

# 7. Mise (Language & Tool Manager)
echo "🔧 Installing Mise..."
curl https://mise.run | sh
export PATH="$HOME/.local/bin:$PATH"
eval "$(mise activate bash)"

# 8. Install Tools via Mise (Node, Python, Neovim, GitHub CLI)
echo "🛠️ Installing Tools via Mise..."
mise use --global node@lts
mise use --global python@3.12
mise use --global neovim@latest
mise use --global github-cli

# 9. Stow Dotfiles (The Safe Way)
echo "🔗 Linking Dotfiles..."
cd ~/dotfileslinux

# CRITICAL: Create .config manually so Stow doesn't link the whole folder
mkdir -p ~/.config

# Remove default configs if they exist (to avoid Stow conflicts)
rm -rf ~/.config/fish ~/.config/nvim ~/.config/lazygit ~/.config/tmux ~/.config/mise
rm -f ~/.bashrc

# Stow everything
stow .

# 10. Set Default Shell
echo "🐚 Changing default shell to Fish..."
if [[ $SHELL != */fish ]]; then
    sudo chsh -s $(which fish) $USER
fi

echo "✅ Setup Complete! Please restart your terminal."
