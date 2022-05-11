"windows ~/_vimrc linux ~/.vimrc
"windows ~/vimfiles/autoload  linux ~/.vim/autoload

 "{clangd.semanticHighlighting": true, coc.preferences.semanticTokensHighlights": false} 
   
let mapleader=","
set guifont=SauceCodePro\ NF
"--------------------------------------------------------------------------------------"
call plug#begin('~/.vim/plugged')
   Plug 'vim-airline/vim-airline'"状态栏
   Plug 'vim-airline/vim-airline-themes'
	
    Plug 'preservim/nerdtree' "目录树
    Plug 'ryanoasis/vim-devicons'
	
    Plug 'preservim/nerdcommenter' "注释
    
    Plug 'octol/vim-cpp-enhanced-highlight' "高亮
    Plug 'jackguo380/vim-lsp-cxx-highlight'
    
    Plug 'voldikss/vim-floaterm' "终端
    
    Plug 'bling/vim-bufferline' "butter显示
    
    Plug 'neoclide/coc.nvim',{'branch':'release'}"代码补全
    
    Plug 'jiangmiao/auto-pairs'"补全括号
    
    Plug 'tyrannicaltoucan/vim-quantum'"主题
    
    Plug 'mcchrish/nnn.vim'
    Plug 'airblade/vim-gitgutter'
    
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
"nerdtree 目录树
set encoding=UTF-8
let g:NERDTreeIndicatorMapCustom = {
    \ "Modified"  : "✹",
    \ "Staged"    : "✚",
    \ "Untracked" : "✭",
    \ "Renamed"   : "➜",
    \ "Unmerged"  : "═",
    \ "Deleted"   : "✖",
    \ "Dirty"     : "✗",
    \ "Clean"     : "✔︎",
    \ "Unknown"   : "?"
    \ }
"autocmd vimenter * if !argc()|NERDTree|
"autocmd vimenter * NERDTree
let g:NERDTreeDirArrowExpandable = '+'
let g:NERDTreeDirArrowCollapsible = '-'
" 显示行号
let NERDTreeShowLineNumbers=1
let NERDTreeAutoCenter=1
" 是否显示隐藏文件
let NERDTreeShowHidden=1
" 设置宽度
let g:NERDTreeWinSize=17
let NERDTreeWinSize=25
let g:NERDTreeWinPos='left'
let g:NERDTreeSize=30
" 在终端启动vim时，共享NERDTree
let g:nerdtree_tabs_open_on_console_startup=1
" 忽略一下文件的显示
let NERDTreeIgnore=['\.pyc','\~$','\.swp']
" 显示书签列表
let NERDTreeShowBookmarks=1
autocmd bufenter * if(winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
"autocmd VimEnter * NERDTree
wincmd w
"autocmd VimEnter * wincmd w
nnoremap <leader>c :NERDTreeClose<CR>
nnoremap <leader>e :NERDTree<CR>
"----------------------------------------------------------------------------------------------------"
" vim-cpp-enhanced-highlight高亮

let g:cpp_class_scope_highlight = 1
let g:cpp_member_variable_highlight = 1
let g:cpp_posix_standard = 1
let g:cpp_experimental_simple_template_highlight = 1
let g:cpp_concepts_highlight = 1
"------------------------------------------------------------------------------------------------------"
" nerdcommenter注释插件
let g:NERDCreateDefaultMappings = 1
let g:NERDSpaceDelims = 1
let g:NERDCompactSexyComs = 1
let g:NERDDefaultAlign = 'left'
let g:NERDAltDelims_java = 1
let g:NERDCustomDelimiters = { 'c': { 'left': '/**','right': '*/' } }
let g:NERDCommentEmptyLines = 1
let g:NERDTrimTrailingWhitespace = 1
let g:NERDToggleCheckAllLines = 1
"------------------------------------------------------------------------------------------------------"
"vim-airline'"状态栏
let g:airline_theme='quantum'
"tyrannicaltoucan/vim-quantum "主题\
set background=dark
set termguicolors
colorscheme quantum
"-----------------------------------------------------------------------------------------------
"vim-floaterm终端
nnoremap <leader>t :FloatermNew<CR>
tnoremap <leader>d exit<CR><CR>
"
let g:nnn#layout="new"
let g:nnn#layout={'left':'~20'}
let g:nnn#layout={'window': {'width': 0.5,'height': 0.5, 'highlight':'comment'}}
nnoremap <leader>ff :NnnPicker<CR>

highlight GitgutterAdd guifg=#009900 ctermfg=10
highlight GitgutterChange guifg=#bbbb00 ctermfg=11
highlight GitgutterDelete guifg=#ff2222 ctermfg=9
let g:gitgutter_sign_added='|'
let g:gitgutter_sign_modified='|'
let g:gitgutter_sign_removed='|'
let g:gitgutter_sign_removed_first_line='|'
let g:gitgutter_sign_removed_above_and_below='|'
let g:gitgutter_sign_modified_removed='|'

"设置c/cpp高亮
" 
" highlight  Function                    ctermfg=155
" highlight  cppNumber                   ctermfg=123
" highlight  cNumber                     ctermfg=123
" highlight  cppBoolean                  ctermfg=123
" highlight  Constant                    ctermfg=123
" highlight  cInclude                    ctermfg=172
" highlight cStatement                   ctermfg=40
" highlight cLabl                        ctermfg=40
" highlight cConditional                 ctermfg=40
" highlight cRepeat ctermfg=40

"highlight cppSTLnamespace ctermfg=226
"highlight cppSTLconstant ctermfg=155
"highlight Comment        ctermfg=159
"


hi PMenu              ctermfg=240 ctermbg=243
hi PMenuSel           ctermfg=240    ctermbg=243

set cursorline
hi CursorLine                           ctermbg=none ctermbg=242
hi CursorLineNr       cterm=bold,italic ctermfg=240 ctermbg=243
"hi SignColumn ctermbg=none

"highlight MatchParen ctermbg=000 guibg=lightblue
"highlight Search ctermfg=000 ctermbg=33FF33
"highlight Visual ctermfg=000    ctermbg=239

set bg=dark
set viminfo='1000,<500
set clipboard=unnamed
set numberwidth=3
set fileencodings=ucs-bom,utf-8,gb18030,default
set shortmess=atI " 启动的时候不显示那个援助索马里儿童的提示
set scrolloff=2
set ignorecase "搜索忽略大小写
autocmd VimEnter * NoMatchParen "取消括号高亮匹配
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
set mouse=a
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

nnoremap <leader>y "+yy
vnoremap <leader>y "+y
vnoremap <leader>p "+p

nnoremap zh <C-w>3>
nnoremap zl <C-w>3<
