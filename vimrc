"windows ~/_vimrc linux ~/.vimrc
"windows ~/vimfiles/autoload  linux ~/.vim/autoload

 "{clangd.semanticHighlighting": true, coc.preferences.semanticTokensHighlights": false} 
 "--with-features=huge --enable-python3interp --enable-luainterp --enable-multibyte --enable-cscope --prefix=/usr/local/vim8
   
let mapleader=","
let g:maplocalleader=","
set guifont=SauceCodePro\ NF
"--------------------------------------------------------------------------------------"
call plug#begin('~/.vim/plugged')
    Plug 'vim-airline/vim-airline'"状态栏
    Plug 'vim-airline/vim-airline-themes'
	
    Plug 'Shougo/defx.nvim'"目录树"
    Plug 'roxma/nvim-yarp'
    Plug 'roxma/vim-hug-neovim-rpc'
    Plug 'kristijanhusak/defx-icons'
	
    Plug 'preservim/nerdcommenter' "注释
    
    Plug 'octol/vim-cpp-enhanced-highlight' "高亮
    Plug 'jackguo380/vim-lsp-cxx-highlight'
    
    Plug 'voldikss/vim-floaterm' "终端
    
    Plug 'bling/vim-bufferline' "butter显示
    
    Plug 'neoclide/coc.nvim',{'branch':'release'}"代码补全
    
    Plug 'jiangmiao/auto-pairs'"补全括号
    
    Plug 'tyrannicaltoucan/vim-quantum'"主题
    Plug 'rakr/vim-one'
    Plug 'dracula/vim'
    
    "Plug 'mcchrish/nnn.vim'
    Plug 'airblade/vim-gitgutter'
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'
call plug#end()
"-------------------------------------------------------------------------------------------"
"coc-nvim 补全
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
nmap <silent> m <Plug>(coc-definition)
"-------------------------------------------------------------------------------------------"
"auto-pairs 括号补全
let g:rainbow_active = 1
let g:rainbow_load_separately = [
    \ [ '*' , [['(', ')'], ['\[', '\]'], ['{', '}']] ],
    \ [ '*.tex' , [['(', ')'], ['\[', '\]']] ],
    \ [ '*.cpp' , [['(', ')'], ['\[', '\]'], ['{', '}']] ],
    \ [ '*.{html,htm}' , [['(', ')'], ['\[', '\]'], ['{', '}'], ['<\a[^>]*>', '</[^>]*>']] ],
    \ ]
let g:rainbow_guifgs = ['RoyalBlue3', 'DarkOrange3', 'DarkOrchid3', 'FireBrick']
let g:rainbow_ctermfgs = ['lightblue', 'lightgreen', 'yellow', 'red', 'magenta']
"------------------------------------------------------------------------------------------------------------"
"Defx 目录树
let g:defx_icons_enable_syntax_highlight = 1
let g:defx_icons_column_length = 1
let g:defx_icons_directory_icon = ''
let g:defx_icons_mark_icon = '*'
let g:defx_icons_copy_icon = ''
let g:defx_icons_link_icon = ''
let g:defx_icons_move_icon = ''
let g:defx_icons_parent_icon = ''
let g:defx_icons_default_icon = ''
let g:defx_icons_directory_symlink_icon = ''
" Options below are applicable only when using "tree" feature
let g:defx_icons_root_opened_tree_icon = ''
let g:defx_icons_nested_opened_tree_icon = ''
let g:defx_icons_nested_closed_tree_icon = ''

	call defx#custom#column('icon', {
	      \ 'directory_icon': '▸ ',
	      \ 'file_icon': '  ',
	      \ 'opened_icon': '▾ ',
	      \ 'root_icon': '  ',
	      \ })

	call defx#custom#column('mark', {
	      \ 'readonly_icon': '✗',
	      \ 'selected_icon': '✓',
	      \ })

    call defx#custom#option('_', {
            \ 'columns': 'indent:git:icons:filename',
            \ 'winwidth': 25,
            \ 'split': 'vertical',
            \ 'direction': 'topleft',
            \ 'show_ignored_files': 0,
            \ 'root_marker': '≡ ',
            \ 'ignored_files':
            \     '.mypy_cache,.pytest_cache,.git,.hg,.svn,.stversions'
            \   . ',__pycache__,.sass-cache,*.egg-info,.DS_Store,*.pyc,*.swp'
            \ })

    nnoremap <silent> <LocalLeader>e
            \ :<C-u>Defx -resume -toggle -buffer-name=tab`tabpagenr()` <CR>

nnoremap <silent> <LocalLeader>a
            \ :<C-u>Defx -resume -buffer-name=tab`tabpagenr()` -search=`expand('%:p')`<CR>

autocmd FileType defx call s:defx_my_settings()
function! s:defx_my_settings() abort
    nnoremap <silent><buffer><expr> <CR>
                \ defx#is_directory() ?
                \ defx#do_action('open_tree') :
                \ defx#do_action('multi', ['drop']) 

   nnoremap <silent><buffer><expr> l
                \ defx#is_directory() ?
                \ defx#do_action('open_or_close_tree') :
                \ defx#do_action('multi', ['drop'])

    nnoremap <silent><buffer><expr> a
                \ defx#do_action('new_file')

    nnoremap <silent><buffer><expr> d
                \ defx#do_action('remove')

    nnoremap <silent><buffer><expr> r
                \ defx#do_action('rename')

    nnoremap <silent><buffer><expr> c
            \ defx#do_action('close_tree')
endfunction

"------------------------------------------------------------------------------------------------------"
"vim-airline'"状态栏
let b:airline_whitespace_disabled = 1
let g:airline_powerline_fonts = 1
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_buffers = 0
let g:airline#extensions#tabline#show_tab_nr = 0
let g:airline#extensions#tabline#tabs_label = ''
let g:airline#extensions#tabline#show_tab_type = 0
let g:airline_theme='solarized'
"let g:airline_theme='dracula'
"-------------------------------------------------------------------------------------------------------
"tyrannicaltoucan/vim-quantum "主题\
set background=dark
set termguicolors
colorscheme one
 "colorscheme dracula
"-----------------------------------------------------------------------------------------------
"vim-floaterm终端
nnoremap <leader>t :FloatermNew<CR>
tnoremap <leader>d exit<CR><CR>
"--------------------------------------------------------------------------------------------------------
"fzf
let g:fzf_layout = { 'window': { 'width': 0.5, 'height': 0.6, 'relative': v:true } }
nnoremap <leader>ff :Files<CR>
nnoremap <leader>fg :Rg<CR>
nnoremap <leader>fb :Buffers<CR>
nnoremap <leader>fl :BLines<CR>
"-----------------------------------------------------------------------------------------------------------------------
"git setting
highlight GitgutterAdd guifg=#009900 ctermfg=10
highlight GitgutterChange guifg=#bbbb00 ctermfg=11
highlight GitgutterDelete guifg=#ff2222 ctermfg=9
let g:gitgutter_sign_added='|'
let g:gitgutter_sign_modified='|'
let g:gitgutter_sign_removed='|'
let g:gitgutter_sign_removed_first_line='|'
let g:gitgutter_sign_removed_above_and_below='|'
let g:gitgutter_sign_modified_removed='|'


hi PMenu              ctermfg=240 ctermbg=243
hi PMenuSel           ctermfg=240    ctermbg=243
set cursorline
hi CursorLine                           ctermbg=none ctermbg=242
hi CursorLineNr       cterm=bold,italic ctermfg=240 ctermbg=243

set bg=dark
set viminfo='1000,<666
set clipboard=unnamed
set numberwidth=5
set fileencodings=ucs-bom,utf-8,gb18030,default
set shortmess=atI " 启动的时候不显示那个援助索马里儿童的提示
set scrolloff=2
set ignorecase "搜索忽略大小写
" autocmd VimEnter * NoMatchParen "取消括号高亮匹配
" set noeb
" set vb
" set vb t_vb=
set tm=500
set number
"set relativenumber
set autoindent
set ts=4
set shiftwidth=4
set softtabstop=4
set tabstop=4
set cindent
set expandtab "设置tab=space
"set noexpandtab "设置spce=tab
set mouse-=a
set nocompatible"不兼容vi模式
set cmdheight=1
set hlsearch
set backspace=indent,eol,start "设置back键
au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif 
let &t_SI.="\e[5 q" "SI = INSERT mode
let &t_SR.="\e[4 q" "SR = REPLACE mode
let &t_EI.="\e[1 q" "EI = NORMAL mode (ELSE)

inoremap <C-l> <Right>

nnoremap q :nohl<CR>
vnoremap q <Esc>

nnoremap <leader>f :bn<CR>
nnoremap <leader>b :bp<CR>
nnoremap <leader>d :bd<CR>

nnoremap <leader>yy "+yy
vnoremap <leader>y "+y
vnoremap <leader>p "+p

nnoremap zh <C-w>3>
nnoremap zl <C-w>3<
