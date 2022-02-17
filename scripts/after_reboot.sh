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

# Start and Enable Docker Servies
sudo systemctl enable --now docker
sudo usermod -aG docker $USER

# Pacman color property
sudo sed -i 's/^#Color/Color/' /etc/pacman.conf