#!/usr/bin/env bash

# Relaunch script with bash if not already using it
if [ -z "${BASH_VERSION:-}" ]; then
  echo "⚠️ This script must be run with Bash. Relaunching with bash..."
  exec bash "$0" "$@"
fi

set -e  # Exit on error
set -u  # Error on undefined variables
set -o pipefail

# Ensure ~/.local/bin is in PATH for this session
export PATH="$HOME/.local/bin:$PATH"

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
REQUIRED_TOOLS=(tmux zsh git grc neovim bat gemini zk zoxide eza powerlevel10k codex unzip zip agy font-meslo-lg-nerd-font)

is_installed() {
  local tool="$1"
  case "$tool" in
    neovim)
      command -v nvim >/dev/null 2>&1
      ;;
    powerlevel10k)
      brew list powerlevel10k >/dev/null 2>&1 || [ -d "$HOME/.oh-my-zsh/custom/themes/powerlevel10k" ]
      ;;
    gemini)
      command -v gemini >/dev/null 2>&1 || brew list gemini >/dev/null 2>&1
      ;;
    agy)
      command -v agy >/dev/null 2>&1 || [ -f "$HOME/.local/bin/agy" ]
      ;;
    *)
      command -v "$tool" >/dev/null 2>&1
      ;;
  esac
}

echo "🔍 Checking required tools..."
for TOOL in "${REQUIRED_TOOLS[@]}"; do
  if ! is_installed "$TOOL"; then
    echo "⚠️  $TOOL is not installed."

    # Custom installation for tools not standard in package managers
    if [[ "$TOOL" == "agy" ]]; then
      echo "📦 Installing agy (antigravity cli)..."
      curl -fsSL https://antigravity.google/cli/install.sh | bash
      continue
    elif [[ "$TOOL" == "codex" ]]; then
      if [[ "$OSTYPE" == "darwin"* ]] && command -v brew >/dev/null 2>&1; then
        echo "📦 Installing codex with Homebrew..."
        if brew install --cask codex; then
          continue
        fi
        echo "⚠️ Homebrew installation of codex failed. Trying official script..."
      fi
      echo "📦 Installing codex cli..."
      CODEX_NON_INTERACTIVE=true curl -fsSL https://chatgpt.com/codex/install.sh | sh
      continue
    fi

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
echo "🐚 Setting up Oh My Zsh..."

# Install Oh My Zsh (if not already installed)
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    KEEP_ZSHRC=yes sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"
mkdir -p "$ZSH_CUSTOM/plugins"

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

echo ""
echo "🔗 Creating symbolic links..."

FILES_TO_SYMLINK=(
  "$DOTFILES_DIR/tmux/.tmux.conf:$HOME/.tmux.conf"
  "$DOTFILES_DIR/tmux/start_dev.sh:$HOME/start_dev.sh"
  "$DOTFILES_DIR/zsh/.zshrc:$HOME/.zshrc"
  "$DOTFILES_DIR/aerospace/aerospace.toml:$HOME/.config/aerospace/aerospace.toml"
  "$DOTFILES_DIR/borders/bordersrc:$HOME/.config/borders/bordersrc"
  "$DOTFILES_DIR/hyper/.hyper.js:$HOME/.hyper.js"
  "$DOTFILES_DIR/vscode/settings.json:$HOME/Library/Application Support/Code/User/settings.json"
  "$DOTFILES_DIR/vscode/keybindings.json:$HOME/Library/Application Support/Code/User/keybindings.json"
  "$DOTFILES_DIR/vscode/snippets:$HOME/Library/Application Support/Code/User/snippets"
  "$DOTFILES_DIR/grc/logs.conf:$HOME/.grc/logs.conf"
  "$DOTFILES_DIR/grc/.grc.zsh:/etc/.grc.zsh"
  "$DOTFILES_DIR/nvim:$HOME/.config/nvim"
  "$DOTFILES_DIR/vim/.vimrc:$HOME/.vimrc"
  "$DOTFILES_DIR/gemini/settings.json:$HOME/.gemini/settings.json"
  "$DOTFILES_DIR/skhd/.skhdrc:$HOME/.skhdrc"
  "$DOTFILES_DIR/skhd/switch_display.sh:/usr/local/bin/sd"
  "$DOTFILES_DIR/eza/theme.yml:$HOME/.config/eza/theme.yml"
  "$DOTFILES_DIR/wezterm/.wezterm.lua:$HOME/.wezterm.lua"
  "$DOTFILES_DIR/p10k/.p10k.zsh:$HOME/.p10k.zsh"
  "$DOTFILES_DIR/codex/config.toml:$HOME/.codex/config.toml"
)

for entry in "${FILES_TO_SYMLINK[@]}"; do
  SRC="${entry%%:*}"
  DEST="${entry#*:}"
  DEST_DIR=$(dirname "$DEST")

  if [ ! -d "$DEST_DIR" ]; then
    echo "📁 Creating directory: $DEST_DIR"
    mkdir -p "$DEST_DIR" 2>/dev/null || sudo -n mkdir -p "$DEST_DIR" 2>/dev/null || echo "⚠️ Could not create directory $DEST_DIR (permission denied)"
  fi

  if [ -L "$DEST" ] || [ -f "$DEST" ] || [ -d "$DEST" ]; then
    echo "🧹 Removing existing file: $DEST"
    rm -rf "$DEST" 2>/dev/null || sudo -n rm -rf "$DEST" 2>/dev/null || echo "⚠️ Could not remove $DEST (permission denied)"
  fi

  echo "🔗 Linking $SRC → $DEST"
  ln -sf "$SRC" "$DEST" 2>/dev/null || sudo -n ln -sf "$SRC" "$DEST" 2>/dev/null || echo "⚠️ Could not link $SRC → $DEST (permission denied)"
done

echo ""
echo "✅ Dotfiles installed with success!"

# Give permissions to executable scripts
chmod +x "$DOTFILES_DIR/tmux/start_dev.sh"
chmod +x "$DOTFILES_DIR/skhd/switch_display.sh"
chmod +x "$HOME/start_dev.sh" 2>/dev/null || true
chmod +x /usr/local/bin/sd 2>/dev/null || sudo -n chmod +x /usr/local/bin/sd 2>/dev/null || true

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

# Check default shell
CURRENT_SHELL="$(dscl . -read "/Users/$USER" UserShell 2>/dev/null | awk '{print $2}' || echo "${SHELL:-}")"
if [[ "$CURRENT_SHELL" != *"zsh"* ]]; then
    echo "💡 Default shell is currently $CURRENT_SHELL. To change to ZSH, run: chsh -s \$(which zsh)"
else
    echo "✅ Default shell is already ZSH ($CURRENT_SHELL)."
fi

echo ""
echo "🎉✅ You're all set!"
if [ -n "${ZSH_VERSION:-}" ]; then
    source "$HOME/.zshrc"
else
    echo "💡 Run 'source ~/.zshrc' in your zsh session or restart your shell to apply changes."
fi
