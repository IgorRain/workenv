#!/usr/bin/env bash

git clone https://github.com/zplug/zplug ~/.zplug
brew bundle --file=~/.Brewfile
sudo chown -R vscode:vscode ~/.config
