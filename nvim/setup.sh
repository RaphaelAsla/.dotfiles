#!/bin/bash

set -e

echo "Updating system packages..."
sudo pacman -Syu --noconfirm

echo "Removing vim if installed..."
sudo pacman -R vim --noconfirm 2>/dev/null || echo "vim not installed"

echo "Installing neovim and development tools..."
sudo pacman -S --noconfirm \
    neovim \
    git \
    curl \
    wget \
    unzip \
    ripgrep \
    fd \
    fzf \
    tree \
    htop \
    tmux \
    nodejs \
    npm \
    python \
    python-pip \
    gcc \
    make \
    cmake

echo "Setting neovim as default editor..."
echo 'export EDITOR=nvim' >> ~/.bashrc
echo 'export VISUAL=nvim' >> ~/.bashrc
echo 'alias vi=nvim' >> ~/.bashrc
echo 'alias vim=nvim' >> ~/.bashrc

if [ -f ~/.zshrc ]; then
    echo 'export EDITOR=nvim' >> ~/.zshrc
    echo 'export VISUAL=nvim' >> ~/.zshrc  
    echo 'alias vi=nvim' >> ~/.zshrc
    echo 'alias vim=nvim' >> ~/.zshrc
fi

echo "Creating neovim config directory..."
mkdir -p ~/.config/nvim

echo "Installing pynvim..."
pip install pynvim

echo "Setup complete. Restart terminal or run 'source ~/.bashrc'"
