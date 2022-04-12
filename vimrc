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

"set statusline=%1*\%<%.50F\             "显示文件名和文件路径 (%<应该可以去掉)
"set statusline+=%=%2*\%y%m%r%h%w\ %*        "显示文件类型及文件状态
"set statusline+=%3*\%{&ff}\[%{&fenc}]\ %*   "显示文件编码类型
"set statusline+=%4*\Row:%l/%L:Col:%c\ %*  "显示光标所在行和列
"set statusline+=%5*\%3p%%\%*            "显示光标前文本所占总文本的比例
"hi User1 cterm=none,bold ctermfg=160 ctermbg=0
"hi User2 cterm=none,bold ctermfg=119 ctermbg=0
"hi User3 cterm=none,bold ctermfg=169 ctermbg=0
"hi User4 cterm=none,bold ctermfg=14 ctermbg=0
"hi User5 cterm=none,bold ctermfg=226 ctermbg=0
"function! InsertStatuslineColor(mode)
"    if a:mode != 'i'
"            hi User1 cterm=none,bold ctermfg=160 ctermbg=0
"        else
"                hi User1 cterm=none,bold ctermfg=41 ctermbg=0
"        endif
"    endfunction
"au InsertEnter * call InsertStatuslineColor(v:insertmode)
"au InsertLeave * hi User1 cterm=none,bold ctermfg=160 ctermbg=0

"set airline && airthemes 状态栏美化
"
"let g:airline_theme="bubblegum"


let g:rainbow_active = 1
let g:rainbow_load_separately = [
    \ [ '*' , [['(', ')'], ['\[', '\]'], ['{', '}']] ],
    \ [ '*.tex' , [['(', ')'], ['\[', '\]']] ],
    \ [ '*.cpp' , [['(', ')'], ['\[', '\]'], ['{', '}']] ],
    \ [ '*.{html,htm}' , [['(', ')'], ['\[', '\]'], ['{', '}'], ['<\a[^>]*>', '</[^>]*>']] ],
    \ ]
let g:rainbow_guifgs = ['RoyalBlue3', 'DarkOrange3', 'DarkOrchid3', 'FireBrick']
let g:rainbow_ctermfgs = ['lightblue', 'lightgreen', 'yellow', 'red', 'magenta']

"--------------------------------------------------------------------------------------"
if has('nvim')
call plug#begin('~/.config/nvim/plugged')
else
call plug#begin('~/.vim/plugged')
endif
"call plug#begin('~/.config/nvim/plugged')
	Plug 'vim-airline/vim-airline'
	Plug 'neoclide/coc.nvim',{'branch':'release'}"代码补全
	Plug 'jiangmiao/auto-pairs'"补全括号
	Plug 'preservim/nerdtree' "目录树
	Plug 'preservim/nerdcommenter' "注释
	Plug 'octol/vim-cpp-enhanced-highlight',{'for':['c,cpp']}
    Plug 'voldikss/vim-floaterm'
call plug#end()
"-------------------------------------------------------------------------------------------"
"coc

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


"-------------------------------------------------------------------------------------------"

"设置c/cpp高亮
highlight  LspCxxHlSymTypedef          ctermfg=226
highlight  LspCxxHlSymPrimitive        ctermfg=226
highlight  LspCxxHlSymConcept          ctermfg=226

highlight  LspCxxHlSymFunction  cterm=none ctermfg=155
highlight  LspCxxHlSymNamespace        ctermfg=226
highlight  LspCxxHlGroupMemberVariable ctermfg=155
highlight  LspCxxHlSymDependentType    ctermfg=226
highlight  LspCxxHlSymClass            ctermfg=226
highlight  LspCxxHlSymMethod           ctermfg=155

highlight  Function                    ctermfg=155
highlight  cppNumber                   ctermfg=123
highlight  cNumber                     ctermfg=123
highlight  cppString                   ctermfg=172
highlight  cString                     ctermfg=172
highlight  cppBoolean                  ctermfg=123
highlight  Constant                    ctermfg=123
highlight  cInclude                    ctermfg=172
highlight cStatement                   ctermfg=40
highlight cLabl                        ctermfg=40
highlight cConditional                 ctermfg=40
highlight cRepeat ctermfg=40

highlight cppSTLnamespace ctermfg=226
highlight cppSTLconstant ctermfg=155
highlight Comment        ctermfg=159



highlight PMenu              cterm=bold ctermfg=255 ctermbg=239
highlight PMenuSel           ctermfg=255 ctermbg=235
set cursorline
highlight CursorLine         cterm=none ctermbg=235
highlight CursorLineNr       cterm=bold,italic ctermfg=255 ctermbg=235
highlight SignColumn ctermbg=none

highlight MatchParen ctermbg=000 guibg=lightblue
highlight Search ctermfg=000 ctermbg=33FF33
highlight Visual ctermfg=000    ctermbg=239

let mapleader=","
set viminfo='1000,<500
set clipboard=unnamed
set numberwidth=3
set fileencodings=ucs-bom,utf-8,gb18030,default
set shortmess=atI " 启动的时候不显示那个援助索马里儿童的提示
set scrolloff=2
set ignorecase "搜索忽略大小写
"autocmd VimEnter * NoMatchParen "取消括号高亮匹配
set noerrorbells "关闭提示音
set novisualbell
set t_vb=
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

nnoremap <leader>w :w<CR>
inoremap <C-l> <Right>
inoremap <> <><Left>
inoremap << <<

nnoremap <C-c> :NERDTreeClose<CR>
nnoremap <C-o> :NERDTree<CR>

nnoremap <leader>t :FloatermNew<CR>
tnoremap <leader>c exit<CR><CR>

nnoremap x "_x
nnoremap X "_X
vnoremap x "_x
vnoremap X "_X
nnoremap d "_d
vnoremap d "_d

vnoremap q <Esc>
nnoremap <C-l> :bn<CR>
nnoremap <C-h> :bp<CR>

nnoremap E ge
nnoremap s gd

nnoremap zh <C-w>3>
nnoremap zl <C-w>3<
nnoremap q :nohl<CR>
nnoremap <expr>m col(".")+1==col("$")?"^":"$"
