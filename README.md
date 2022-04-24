# vim and neovim settings
# SauceCodePro NF || Sauce Code Pro
## vim settings
1. install plug.vim
file pos windows ~/vimfiles/autoload/plug.vim  linux ~/.vim/autoload/plug.vim
linux
``` shell
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```
windows
``` shell
iwr -useb https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim |`
    ni $HOME/vimfiles/autoload/plug.vim -Force
```
2. windows file pos ~/_vimrc 
linux file pos ~/.vimrc
3. PlugInstall

## nvim setsettings
1. install packer.nvim
2. linux     run `git clone --depth 1 https://github.com/wbthomason/packer.nvim\ ~/.local/share/nvim/site/pack/packer/start/packer.nvim`
3. windows   run `git clone https://github.com/wbthomason/packer.nvim "~\AppData\Local\nvim-data\site\pack\packer\start"`
4. windows   ~/AppData\Local\nvim\init.lua
5. linux     ~/.config/nvim/init.lua
6. PackerSync
## screenshot
### vim
![vim](https://github.com/Monody-x/vimconfig/blob/main/vim.png)
### nvim
![nvim](https://github.com/Monody-x/vimconfig/blob/main/nvim1.png)
