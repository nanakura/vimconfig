"sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv
"export http_proxy="http://192.168.49.1:8282"
"export https_proxy="http://192.168.49.1:8282"
"add  apt-get proxy /etc/apt/apt.conf
"Acquire::http::Proxy "http://192.168.49.1:8282";
"git
"git config --global http.proxy 'http://192.168.49.1:8282'
"git config --global https.proxy 'http://192.168.49.1:8282'

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
nnoremap <C-c> :NERDTreeClose<CR>
nnoremap <C-o> :NERDTree<CR>

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
    "if a:mode != 'i'
            "hi User1 cterm=none,bold ctermfg=160 ctermbg=0
        "else
                "hi User1 cterm=none,bold ctermfg=41 ctermbg=0
        "endif
    "endfunction
"au InsertEnter * call InsertStatuslineColor(v:insertmode)
"au InsertLeave * hi User1 cterm=none,bold ctermfg=160 ctermbg=0

"set airline && airthemes 状态栏美化
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

"set indentLine 缩进线
"let g:airline#extensions#tabline#enabled = 1
"let g:airline_theme="understated"
"let g:airline_powerline_fonts = 1
let g:indentLine_char='┆'
let g:indentLine_enabled = 1
let g:indentLine_noConcealCursor = 1
let g:indentLine_color_term = 0
let g:rainbow_active = 1
"--------------------------------------------------------------------------------------"
call plug#begin('~/.vim/plugged')
"call plug#begin('~/.config/nvim/plugged')
	"Plug 'vim-airline/vim-airline'
	"Plug 'vim-airline/vim-airline-themes' "状态栏美化
	Plug 'neoclide/coc.nvim',{'branch':'release'}"代码补全
	Plug 'frazrepo/vim-rainbow'"括号高亮
	Plug 'jiangmiao/auto-pairs'"补全括号
	Plug 'bling/vim-bufferline'"buffer显示
	
	Plug 'preservim/nerdtree' "目录树
	Plug 'Yggdroot/indentLine',{'for':['c,cpp']} "缩进线
	Plug 'preservim/nerdcommenter' "注释
	Plug 'mg979/vim-visual-multi', {'branch':'master'} "多光标
	Plug 'honza/vim-snippets' "片段补全
	Plug 'ryanoasis/vim-devicons' "美化
	
	"Plug 'octol/vim-cpp-enhanced-highlight',{'for':['c,cpp']}
	Plug 'prabirshrestha/vim-lsp',{'for':['c,cpp']}
	Plug 'jackguo380/vim-lsp-cxx-highlight',{'for':['c,cpp']}
	""clangd.semanticHighlighting": true
	""clangd.disableDiagnostics": true
	
	"git
	Plug 'airblade/vim-gitgutter'
	Plug 'tpope/vim-fugitive'
	Plug 'junegunn/gv.vim'
	"nvim
	"高亮
	if has('nvim')
	Plug 'kevinhwang91/rnvimr'
	"pip3 install ranger-fm pynvim
	"pip3 install ueberzug
	"nvim +'checkhealth rnvimr'
	else
	Plug 'voldikss/vim-floaterm'
	endif
"
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
"nvim add
"-----------------------------------------------------------------------------------------------------------------"
if has('nvim')
let g:rnvimr_enable_ex = 1
let g:rnvimr_enable_picker = 1
let g:rnvimr_draw_border = 0
let g:rnvimr_hide_gitignore = 1
let g:rnvimr_border_attr = {'fg': 14, 'bg': -1}
let g:rnvimr_enable_bw = 1
let g:rnvimr_shadow_winblend = 50
let g:rnvimr_ranger_cmd = 'ranger --cmd="set draw_borders both"'
highlight link RnvimrNormal CursorLine
let g:ranger_map_keys = 0
nnoremap ,f :RnvimrToggle<CR>
let g:rnvimr_action = {
            \ '<C-t>': 'NvimEdit tabedit',
            \ '<C-x>': 'NvimEdit split',
            \ '<C-v>': 'NvimEdit vsplit',
            \ 'gw': 'JumpNvimCwd',
            \ 'yw': 'EmitRangerCwd'
            \ }
let g:rnvimr_ranger_views = [
            \ {'minwidth': 50, 'ratio': []},
            \ {'minwidth': 30, 'maxwidth': 70, 'ratio': [1,1]},
            \ {'maxwidth': 25, 'ratio': [1]}
            \ ]
let g:rnvimr_layout = {
            \ 'relative': 'editor',
            \ 'width': float2nr(round(0.7 * &columns)),
            \ 'height': float2nr(round(0.7 * &lines)),
            \ 'col': float2nr(round(0.15 * &columns)),
            \ 'row': float2nr(round(0.15 * &lines)),
            \ 'style': 'minimal'
            \ }
let g:rnvimr_presets = [
            \ {'width': 0.600, 'height': 0.600},
            \ {},
            \ {'width': 0.800, 'height': 0.800},
            \ {'width': 0.950, 'height': 0.950},
            \ {'width': 0.500, 'height': 0.500, 'col': 0, 'row': 0},
            \ {'width': 0.500, 'height': 0.500, 'col': 0, 'row': 0.5},
            \ {'width': 0.500, 'height': 0.500, 'col': 0.5, 'row': 0},
            \ {'width': 0.500, 'height': 0.500, 'col': 0.5, 'row': 0.5},
            \ {'width': 0.500, 'height': 1.000, 'col': 0, 'row': 0},
            \ {'width': 0.500, 'height': 1.000, 'col': 0.5, 'row': 0},
            \ {'width': 1.000, 'height': 0.500, 'col': 0, 'row': 0},
            \ {'width': 1.000, 'height': 0.500, 'col': 0, 'row': 0.5}
            \ ]
else
let g:floaterm_width=0.6
let g:floaterm_height=0.6
au BufEnter * if &buftype == 'terminal' | :call timer_start(50, { -> execute('startinsert!') }, { 'repeat': 5 }) | endif
let g:floaterm_title = ''
let g:floaterm_autoclose = 1
nnoremap <leader>f :FloatermNew<CR>
tnoremap <leader>q exit<CR>

endif
"------------------------------------------------------------------------------------------

"函数高亮
"syn match cFunctions "\<[a-zA-Z_][a-zA-Z_0-9]*\>[^()]*)("me=e-2 
"syn match cFunctions "\<[a-zA-Z_][a-zA-Z_0-9]*\>\s*("me=e-1
"hi cFunctions term=underline cterm=bold ctermfg=14
"syn match cClass "\<[a-zA-Z_][a-zA-Z_0-9]*\>::"me=e-2
"hi cClass term=underline cterm=bold ctermfg=14
"设置c/cpp高亮
highlight  LspCxxHlSymFunction  cterm=none ctermfg=47
highlight  LspCxxHlSymNamespace        ctermfg=226
highlight  LspCxxHlGroupMemberVariable ctermfg=47
highlight  LspCxxHlSymDependentType    ctermfg=226
"highlight  LspCxxHlSymTypedef          ctermfg=226
"highlight  LspCxxHlSymPrimitive        ctermfg=226
"highlight  LspCxxHlSymConcept          ctermfg=226
highlight  LspCxxHlSymClass            ctermfg=226
highlight  LspCxxHlSymMethod           ctermfg=47
highlight  Function                    ctermfg=47
highlight  cppNumber                   ctermfg=123
highlight  cNumber                     ctermfg=123
highlight  cppString                   ctermfg=172
highlight  cString                     ctermfg=172
highlight  cppBoolean                  ctermfg=123
"hi cppSTLnamespace ctermfg=5
"hi cppSTLconstant ctermfg=44
"hi       cppString ctermfg=80
"hi       cString ctermfg=80
"hi       cppNumber ctermfg=80
"hi       cNumber ctermfg=80
"hi      cppBoolean ctermfg=80
"hi       cIncluded ctermfg=44


highlight GitGutterAdd    guifg=#009900 ctermfg=46
highlight GitGutterChange guifg=#bbbb00 ctermfg=214
highlight GitGutterDelete guifg=#ff2222 ctermfg=196
let g:gitgutter_sign_added = '+'
let g:gitgutter_sign_modified = '~'
let g:gitgutter_sign_removed = '-'
let g:gitgutter_sign_removed_first_line = '^'
let g:gitgutter_sign_removed_above_and_below = '-'
let g:gitgutter_sign_modified_removed = 'v'

highlight PMenu              cterm=bold ctermfg=255 ctermbg=239
highlight PMenuSel           ctermfg=255 ctermbg=235
set cursorline
highlight CursorLine         cterm=bold ctermbg=237
highlight CursorLineNr       cterm=bold,italic ctermfg=255 ctermbg=237
hi SignColumn ctermbg=none

"nvim
"~/.config/nvim/autoload/plug.vim   
"~/.config/nvim/init.vim   // ~/.config/nvim/plugged 


set numberwidth=3
set fileencodings=ucs-bom,utf-8,gb18030,default
set shortmess=atI " 启动的时候不显示那个援助索马里儿童的提示
set scrolloff=2
set ignorecase "搜索忽略大小写
autocmd VimEnter * NoMatchParen "取消括号高亮匹配
set noerrorbells "关闭提示音
set novisualbell
set t_vb=
set tm=500
set number
set relativenumber
set autoindent
set ts=4
set shiftwidth=4
set softtabstop=4
set tabstop=4
set cindent
set expandtab "设置tab=space
"set noexpandtab "设置spce=tab
"browsedir=buffer  "用当前文件所在目录；
"browsedir=current "用当前工作目录    
set mouse-=a
set nocompatible"不兼容vi模式
set cmdheight=1
set hlsearch
set backspace=indent,eol,start "设置back键
au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif 
let mapleader=","

let &t_SI.="\e[5 q" "SI = INSERT mode
let &t_SR.="\e[4 q" "SR = REPLACE mode
let &t_EI.="\e[1 q" "EI = NORMAL mode (ELSE)

inoremap <leader>f <Esc>
inoremap <leader>w <Esc>:w<CR>
inoremap <C-v> <Esc>v
inoremap <C-h> <Left>
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-l> <Right>

inoremap <> <><Left>
inoremap << <<

nnoremap <leader>w :w<CR>
nnoremap <leader>q :wq<CR>
nnoremap x "_x
nnoremap X "_X
nnoremap d "_d
nnoremap dd "_dd
nnoremap D "_D
nnoremap dh "_d^
 nnoremap dl "_d$
vnoremap d "_d
vnoremap dd "_dd

nnoremap <leader>x ""x
nnoremap <leader>X ""X
nnoremap <leader>d ""d
nnoremap <leader>dd ""dd
nnoremap <leader>D ""D
vnoremap <leader>d ""d
vnoremap <leader>dd ""dd

vnoremap q <Esc>
nnoremap yl y$
nnoremap yh y^
nnoremap <C-l> :bn<CR>
nnoremap <C-h> :bp<CR>
nnoremap <C-c> :bd<CR>

nnoremap <C-y> "+yy
nnoremap <C-p> "+p

nnoremap K 3k
nnoremap H J
nnoremap J 3j
nnoremap z. <C-w>3>
nnoremap z, <C-w>3
nnoremap <C-q> :nohl<CR>

nnoremap <expr>m col(".")+1==col("$")?"^":"$"


