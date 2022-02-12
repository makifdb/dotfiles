#!/bin/bash

mkdir -p ~/.dotfiles
git clone https://github.com/makifdb/dotfiles ~/.dotfiles
cd ~/.dotfiles

sudo pacman -S base-devel alacritty yay fish go vlc gnome-boxes libreoffice-fresh bat

# env WINIT_UNIX_BACKEND=x11 alacritty

yay -S lenopow jump visual-studio-code-bin rustup github-desktop-bin

# create config folders
mkdir -p ~/.config/alacritty
mkdir -p ~/.config/fish
mkdir -p ~/.config/fish/functions
mkdir -p ~/.config/Code/User

# sync config files
[ -f ~/.gitconfig ] || ln -s $(PWD)/gitconfig ~/.gitconfig
[ -f ~/.nanorc ] || ln -s $(PWD)/nanorc ~/.nanorc
[ -f ~/.config/alacritty/alacritty.yml ] || ln -s $(PWD)/config/alacritty/alacritty.yml ~/.config/alacritty/alacritty.yml
[ -f ~/.config/Code/User/settings.json ] || ln -s $(PWD)/config/Code/User/settings.json ~/.config/Code/User/settings.json
[ -f ~/.config/fish/config.fish ] || ln -s $(PWD)/config/fish/config.fish ~/.config/fish/config.fish
[ -d ~/.config/fish/functions/ ] || ln -s $(PWD)/config/fish/functions ~/.config/fish/functions

# .gitconfig

# Default shell setting to fish
chsh -s $(which fish)
printf "My current shell - %s\n" "$SHELL"

# fish settings
fish_update_completions 

# remove and clear zsh
sudo pacman -Rscn zsh
sudo rm -rf ~/.zcompdump ~/.zhistory ~/.zshrc

# Rust install and configure
rustup install stable
rustup default stable

sudo nano /etc/pacman.conf # Color property
