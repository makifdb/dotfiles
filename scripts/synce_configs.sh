#!/bin/bash

mkdir -p ~/.config/nvim
mkdir -p ~/.config/nvim/lua
mkdir -p ~/.config/fish
mkdir -p ~/.config/fish/functions
mkdir -p ~/.config/ghostty

ln -sf $(pwd)/configs/gitconfig ~/.gitconfig
ln -sf $(pwd)/configs/tmux.conf ~/.tmux.conf
ln -sf $(pwd)/configs/config/nvim/init.lua ~/.config/nvim/init.lua
ln -sf $(pwd)/configs/config/nvim/lazy-lock.json ~/.config/nvim/lazy-lock.json
ln -sf $(pwd)/configs/config/nvim/lua/daily.lua ~/.config/nvim/lua/daily.lua
ln -sf $(pwd)/configs/config/ghostty/config ~/.config/ghostty/config
ln -sf $(pwd)/configs/config/fish/config.fish ~/.config/fish/config.fish
ln -sf $(pwd)/configs/config/fish/functions/fish_prompt.fish ~/.config/fish/functions/fish_prompt.fish
