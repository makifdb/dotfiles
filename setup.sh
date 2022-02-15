#!/bin/bash

mkdir -p ~/.dotfiles
git clone https://github.com/makifdb/dotfiles ~/.dotfiles
cd ~/.dotfiles || exit

sudo pacman --noconfirm -Syuu

sudo pacman --noconfirm -S make alacritty yay fish go vlc gnome-boxes libreoffice-fresh bat telegram-desktop steam-manjaro htop tmux nvim discord

# env WINIT_UNIX_BACKEND=x11 alacritty

yay --save --answerclean All --answerdiff All --noconfirm -S lenopow jump visual-studio-code-bin rustup github-desktop-bin

# create config folders
mkdir -p ~/.config/alacritty
mkdir -p ~/.config/fish
mkdir -p ~/.config/fish/functions
mkdir -p ~/.config/Code/User

# sync config files
[ -f ~/.gitconfig ] || ln -s $(pwd)/gitconfig ~/.gitconfig
[ -f ~/.vimrc ] || ln -s $(pwd)/vimrc ~/.vimrc
[ -f ~/.tmux.conf ] || ln -s $(pwd)/tmux.conf ~/.tmux.conf
[ -f ~/.nanorc ] || ln -s $(pwd)/nanorc ~/.nanorc
[ -f ~/.config/nvim/init.vim ] || ln -s $(pwd)/config/nvim/init.vim ~/.config/nvim/init.vim
[ -f ~/.config/alacritty/alacritty.yml ] || ln -s $(pwd)/config/alacritty/alacritty.yml ~/.config/alacritty/alacritty.yml
[ -f ~/.config/Code/User/settings.json ] || ln -s $(pwd)/config/Code/User/settings.json ~/.config/Code/User/settings.json
[ -f ~/.config/fish/config.fish ] || ln -s $(pwd)/config/fish/config.fish ~/.config/fish/config.fish
[ -d ~/.config/fish/functions/ ] || ln -s $(pwd)/config/fish/functions ~/.config/fish/functions

# .gitconfig

shopt -s expand_aliases

# Default shell setting to fish
chsh -s "$(which fish)"
printf "My current shell - %s\n" "$SHELL"

# vim plug
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

# fish settings
gnome-terminal --tab --title="fish" -- fish -c 'fish_update_completions'

# remove and clear zsh
sudo pacman --noconfirm -Rscn zsh
sudo rm -rf ~/.zcompdump ~/.zhistory ~/.zshrc

# Rust install and configure
gnome-terminal --tab --title="rustup" -- bash -c 'rustup install stable; rustup default stable'

# Pacman color property
sudo sed -i 's/^#Color/Color/' /etc/pacman.conf
