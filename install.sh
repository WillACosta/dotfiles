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

# List of required tools
REQUIRED_TOOLS=(tmux zsh git grc)

echo "🔍 Checking required tools..."
for TOOL in "${REQUIRED_TOOLS[@]}"; do
  if ! command -v "$TOOL" >/dev/null 2>&1; then
    echo "⚠️  $TOOL is not installed."

    # Try to install via Homebrew on macOS
    if [[ "$OSTYPE" == "darwin"* ]]; then
      if command -v brew >/dev/null 2>&1; then
        echo "📦 Installing $TOOL with Homebrew..."
        brew install "$TOOL"
      else
        echo "❌ Homebrew not found. Please install $TOOL manually."
      fi
    elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
      # Install using apt-get on Ubuntu/Debian
      if command -v apt-get >/dev/null 2>&1; then
        echo "📦 Installing $TOOL with apt-get..."
        sudo apt-get update -y
        sudo apt-get install -y "$TOOL"
      else
        echo "❌ apt-get not found. Please install $TOOL manually."
      fi
    else
      echo "❌ Auto-install not supported on this OS. Please install $TOOL manually."
    fi
  else
    echo "✅ $TOOL is installed."
  fi
done

echo ""
echo "🔗 Creating symbolic links..."

declare -A FILES_TO_SYMLINK=(
  ["$DOTFILES_DIR/tmux/.tmux.conf"]="$HOME/.tmux.conf"
  ["$DOTFILES_DIR/tmux/start_dev.sh"]="$HOME/start_dev.sh"
  ["$DOTFILES_DIR/zsh/.zshrc"]="$HOME/.zshrc"
  ["$DOTFILES_DIR/aerospace/aerospace.toml"]="$HOME/.config/aerospace/aerospace.toml"
  ["$DOTFILES_DIR/borders/bordersrc"]="$HOME/.config/borders/bordersrc"
  ["$DOTFILES_DIR/hyper/.hyper.js"]="$HOME/.hyper.js"
  ["$DOTFILES_DIR/vscode/settings.json"]="$HOME/Library/Application Support/Code/User/settings.json"
  ["$DOTFILES_DIR/vscode/keybinds.json"]="$HOME/Library/Application Support/Code/User/keybinds.json"
  ["$DOTFILES_DIR/vscode/snippets"]="$HOME/Library/Application Support/Code/User/snippets"
  ["$DOTFILES_DIR/grc/logs.conf"]="$HOME/.grc/logs.conf"
  ["$DOTFILES_DIR/grc/.grc.zsh"]="/etc/.grc.zsh"
  ["$DOTFILES_DIR/nvim"]="$HOME/.config/nvim"
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

# Install spaceship
git clone https://github.com/spaceship-prompt/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt" --depth=1"

ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"