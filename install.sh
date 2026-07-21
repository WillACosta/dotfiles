#!/usr/bin/env bash

# Relaunch script with bash if not already using it
if [ -z "$BASH_VERSION" ]; then
  echo "⚠️ This script must be run with Bash. Relaunching with bash..."
  exec bash "$0" "$@"
fi

set -e  # Exit on error
set -u  # Error on undefined variables
set -o pipefail

# Detect dotfiles root directory (works in Bash and Zsh)
if [[ -n "${BASH_SOURCE:-}" ]]; then
  DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
elif [[ -n "${(%):-%x}" ]]; then  # Zsh-compatible
  DOTFILES_DIR="$(cd "$(dirname "${(%):-%x}")" && pwd)"
else
  echo "❌ Unable to determine script path"
  exit 1
fi

echo "📦 Bootstrapping dotfiles from: $DOTFILES_DIR"

# --- RHEL/CentOS Specific: Enable EPEL if using dnf ---
if command -v dnf >/dev/null 2>&1; then
    if ! dnf list installed epel-release >/dev/null 2>&1; then
        echo "Configure: Enabling EPEL repository..."
        sudo dnf install -y epel-release || echo "⚠️ Could not install epel-release. Some tools might fail to install."
    fi
fi

# List of required tools
REQUIRED_TOOLS=(tmux zsh git grc neovim bat gemini zk zoxide eza wezterm powerlevel10k codex unzip zip vim-enhanced)

echo "🔍 Checking required tools..."
for TOOL in "${REQUIRED_TOOLS[@]}"; do
  if ! command -v "$TOOL" >/dev/null 2>&1; then
    echo "⚠️  $TOOL is not installed."

    # 1. macOS (Homebrew)
    if [[ "$OSTYPE" == "darwin"* ]]; then
      if command -v brew >/dev/null 2>&1; then
        echo "📦 Installing $TOOL with Homebrew..."
        brew install "$TOOL"
      fi
    # 2. Linux
    elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
      # RHEL/Fedora (dnf)
      if command -v dnf >/dev/null 2>&1; then
        echo "📦 Installing $TOOL with dnf..."
        sudo dnf install -y "$TOOL"
      # Ubuntu/Debian (apt)
      elif command -v apt-get >/dev/null 2>&1; then
        echo "📦 Installing $TOOL with apt-get..."
        sudo apt-get update -y
        sudo apt-get install -y "$TOOL"
      else
        echo "❌ No supported package manager found."
      fi
    fi
  else
    echo "✅ $TOOL is installed."
  fi
done

echo ""
echo "🔗 Creating symbolic links..."

declare -A FILES_TO_SYMLINK=(
  ["$DOTFILES_DIR/tmux/.tmux.conf"]="$HOME/.tmux.con"
  ["$DOTFILES_DIR/tmux/start_dev.sh"]="$HOME/start_dev.sh"
  ["$DOTFILES_DIR/zsh/.zshrc"]="$HOME/.zshrc"
  ["$DOTFILES_DIR/aerospace/aerospace.toml"]="$HOME/.config/aerospace/aerospace.toml"
  ["$DOTFILES_DIR/borders/bordersrc"]="$HOME/.config/borders/bordersrc"
  ["$DOTFILES_DIR/hyper/.hyper.js"]="$HOME/.hyper.js"
  ["$DOTFILES_DIR/vscode/settings.json"]="$HOME/Library/Application Support/Code/User/settings.json"
  ["$DOTFILES_DIR/vscode/keybindings.json"]="$HOME/Library/Application Support/Code/User/keybindings.json"
  ["$DOTFILES_DIR/vscode/snippets"]="$HOME/Library/Application Support/Code/User/snippets"
  ["$DOTFILES_DIR/grc/logs.conf"]="$HOME/.grc/logs.conf"
  ["$DOTFILES_DIR/grc/.grc.zsh"]="/etc/.grc.zsh"
  ["$DOTFILES_DIR/nvim"]="$HOME/.config/nvim"
  ["$DOTFILES_DIR/vim/.vimrc"]="$HOME/.vimrc"
  ["$DOTFILES_DIR/gemini/settings.json"]="$HOME/.gemini/settings.json"
  ["$DOTFILES_DIR/skhd/.skhdrc"]="$HOME/.skhdrc"
  ["$DOTFILES_DIR/skhd/.skhdrc/switch_display.sh"]="/usr/local/bin/sd"
  ["$DOTFILES_DIR/eza/theme.yml"]="~/.config/eza/theme.yml"
  ["$DOTFILES_DIR/wezterm/.wezterm.lua"]="~/.wezterm.lua"
  ["$DOTFILES_DIR/p10k/.p10k.zsh"]="~/.p10k.zsh"
  ["$DOTFILES_DIR/codex/config.toml"]="~/.codex/config.toml"
)

for SRC in "${!FILES_TO_SYMLINK[@]}"; do
  DEST="${FILES_TO_SYMLINK[$SRC]}"
  DEST_DIR=$(dirname "$DEST")

  if [ ! -d "$DEST_DIR" ]; then
    echo "📁 Creating directory: $DEST_DIR"
    mkdir -p "$DEST_DIR"
  fi

  if [ -L "$DEST" ] || [ -f "$DEST" ]; then
    echo "🧹 Removing existing file: $DEST"
    rm -f "$DEST"
  fi

  echo "🔗 Linking $SRC → $DEST"
  ln -sf "$SRC" "$DEST"
done

echo ""
echo "✅ Dotfiles installed with success!"

# Give permissions to the start_dev script
chmod +x ~/start_dev.sh
chmod +x /usr/local/bin/sd

# Install Oh My Zsh (if not already installed)
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

ZSH_CUSTOM="$HOME/$OMZ_DIR/custom"

# Helper for git clones to avoid "already exists" errors
safe_clone() {
    if [ ! -d "$2" ]; then
        git clone "$1" "$2" --depth=1
    else
        echo "✅ $(basename "$2") already exists, skipping clone."
    fi
}

safe_clone "https://github.com/zsh-users/zsh-syntax-highlighting.git" "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
safe_clone "https://github.com/Pilaton/OhMyZsh-full-autoupdate.git" "$ZSH_CUSTOM/plugins/ohmyzsh-full-autoupdate"
safe_clone "https://github.com/zsh-users/zsh-autosuggestions" "$ZSH_CUSTOM/plugins/zsh-autosuggestions"

## ZSH installation end

## Run default git config preferences
git config --global core.editor "vim"
git config --global core.pager bat

# Define where NVM should live
export NVM_DIR="$HOME/.nvm"

# Check if NVM is already installed
if [ ! -d "$NVM_DIR" ]; then
    echo "📦 Downloading and installing NVM..."
    # -k is used here to bypass corporate SSL issues we encountered
    curl -fsSLk https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash

    # IMPORTANT: Load NVM into the current shell session so the script can use it
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

    echo "✅ NVM installed. Installing Node.js LTS..."
    nvm install --lts
    nvm use --lts
else
    echo "✅ NVM already exists. Loading it..."
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
fi

# Verify Node installation
if command -v node >/dev/null 2>&1; then
    echo "🟢 Node.js $(node -v) is ready to go!"
fi

# Choose ZSH as default shell
chsh -s $(which zsh)

echo "\n\n🎉✅ You're all set!"
source ~/.zshrc
