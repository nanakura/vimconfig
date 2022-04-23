# set vim and neovim

## vim set
1. install plug.vim
2. windows ~/vimfiles/autoload/plug.vim  linux ~/.vim/autoload/plug.vim
3. "windows ~/_vimrc linux ~/.vimrc
4. PlugInstall
## nvim set
1. install packer.nvim
2. linux     run `git clone --depth 1 https://github.com/wbthomason/packer.nvim\ ~/.local/share/nvim/site/pack/packer/start/packer.nvim`
3. windows   run `git clone https://github.com/wbthomason/packer.nvim "~\AppData\Local\nvim-data\site\pack\packer\start"`
4. windows   ~/AppData\Local\nvim\init.lua
5. linux     ~/.config/nvim/init.lua
6. PackerSync
