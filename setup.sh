#!/usr/bin/env bash

git clone https://github.com/zplug/zplug ~/.zplug
brew install neovim fd ripgrep fzf eza bat starship carapace zoxide atuin git-delta lazygit tmux tree-sitter tree-sitter-cli yazi
sudo chown -R vscode:vscode ~/.config
