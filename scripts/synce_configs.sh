mkdir -p ~/.config/alacritty
mkdir -p ~/.config/nvim
mkdir -p ~/.config/fish
mkdir -p ~/.config/fish/functions
mkdir -p ~/.config/Code/User


[ -f ~/.gitconfig ] || ln -sf $(pwd)/configs/gitconfig ~/.gitconfig
[ -f ~/.vimrc ] || ln -sf $(pwd)/configs/vimrc ~/.vimrc
[ -f ~/.tmux.conf ] || ln -sf $(pwd)/configs/tmux.conf ~/.tmux.conf
[ -f ~/.nanorc ] || ln -sf $(pwd)/configs/nanorc ~/.nanorc
[ -f ~/.config/nvim/init.vim ] || ln -sf $(pwd)/configs/config/nvim/init.vim ~/.config/nvim/init.vim
[ -f ~/.config/alacritty/alacritty.yml ] || ln -sf $(pwd)/configs/config/alacritty/alacritty.yml ~/.config/alacritty/alacritty.yml
[ -f ~/.config/Code/User/settings.json ] || ln -sf $(pwd)/configs/config/Code/User/settings.json ~/.config/Code/User/settings.json
[ -f ~/.config/fish/config.fish ] || ln -sf $(pwd)/configs/config/fish/config.fish ~/.config/fish/config.fish
[ -d ~/.config/fish/functions/ ] || ln -sf $(pwd)/configs/config/fish/functions ~/.config/fish/functions
