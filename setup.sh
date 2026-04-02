#!/bin/bash

# --- 1. Safety Gate ---
echo "---------------------------------------------------"
echo "  Ahmet's Dotfiles Setup Script                    "
echo "---------------------------------------------------"
read -p "This will overwrite existing system configs with your dotfiles. Proceed? (y/n) " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "Setup cancelled."
    exit 1
fi

# --- 2. Homebrew & Dependencies ---
if ! command -v brew &> /dev/null; then
    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

echo "Installing apps and tools from Brewfile..."
brew bundle --file=~/dotfiles/Brewfile

# --- 3. Oh My Zsh & Powerlevel10k ---
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  echo "Installing Oh My Zsh..."
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

# --- 4. Creating Symlink Portals ---
echo "Creating symlinks to ~/dotfiles..."

# Config Directories (Ghostty, Aerospace, Borders, Btop, Fastfetch)
mkdir -p ~/.config/ghostty
mkdir -p ~/.config/aerospace
mkdir -p ~/.config/borders
mkdir -p ~/.config/btop
mkdir -p ~/.config/fastfetch

ln -sf ~/dotfiles/ghostty/config ~/.config/ghostty/config
ln -sf ~/dotfiles/aerospace/aerospace.toml ~/.aerospace.toml
ln -sf ~/dotfiles/borders/bordersrc ~/.config/borders/bordersrc
ln -sf ~/dotfiles/btop/btop.conf ~/.config/btop/btop.conf
ln -sf ~/dotfiles/fastfetch/config.jsonc ~/.config/fastfetch/config.jsonc

# Shell & Git
ln -sf ~/dotfiles/zshrc ~/.zshrc
ln -sf ~/dotfiles/gitconfig ~/.gitconfig

# Tmux
ln -sf ~/dotfiles/tmux/tmux.conf ~/.tmux.conf

# --- 5. Post-Install Optimization ---
echo "Setting up terminal passthrough for images..."
# Ensure the tmux server picks up the new config
tmux kill-server 2>/dev/null || true

echo "Applying MacOS defaults..."
# Enable repeat on keys (Better for terminal navigation)
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false

# --- 6. Completion ---
echo "---------------------------------------------------"
echo "          dotfiles Applied Successfully!           "
echo "---------------------------------------------------"