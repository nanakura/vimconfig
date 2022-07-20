" xMonody-x huanbin_xiao@163.com

call plug#begin('~/.vim/plugged')
Plug 'neoclide/coc.nvim',{'branch':'release'} "代码补全
Plug 'honza/vim-snippets'"片段

Plug 'Shougo/defx.nvim'"目录树"
Plug 'roxma/nvim-yarp'
Plug 'roxma/vim-hug-neovim-rpc'
Plug 'kristijanhusak/defx-icons'

Plug 'itchyny/lightline.vim'
Plug 'itchyny/vim-gitbranch'
Plug 'ap/vim-buftabline'
"Plug 'rakr/vim-one'"主题
Plug 'kaicataldo/material.vim', { 'branch': 'main' } "主题
Plug 'octol/vim-cpp-enhanced-highlight' "高亮

Plug 'voldikss/vim-floaterm' "终端
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } } "模糊查找
Plug 'junegunn/fzf.vim'

Plug 'jiangmiao/auto-pairs' "补全括号
Plug '907th/vim-auto-save'
Plug 'Yggdroot/indentLine' "对其线
Plug 'mg979/vim-visual-multi', {'branch': 'master'} "多光标
Plug 'preservim/nerdcommenter' "注释
Plug 'vim-autoformat/vim-autoformat'

Plug 'airblade/vim-gitgutter' "git修改
Plug 'tpope/vim-fugitive'
Plug 'junegunn/gv.vim'
call plug#end()
"------------------------------------------------------------------------------
hi PMenu              ctermfg=240 ctermbg=243
hi PMenuSel           ctermfg=240    ctermbg=243
hi MatchParen ctermbg=gray guibg=gray
set cursorline
hi CursorLine         cterm=bold ctermbg=none ctermbg=242
hi CursorLineNr       cterm=bold ctermfg=240 ctermbg=243
let mapleader=","
let g:maplocalleader=","
set numberwidth=1
set bg=dark
set filetype=glslx
set viminfo='1000,<666
set clipboard=unnamed
set fileencodings=ucs-bom,utf-8,gb18030,default
set ignorecase "搜索忽略大小写
" autocmd VimEnter * NoMatchParen "取消括号高亮匹配
set noerrorbells visualbell t_vb=
autocmd GUIEnter * set visualbell t_vb=
set belloff=all
set tm=500
set number
"set relativenumber
set autoindent
set ts=4
set shiftwidth=4
set softtabstop=4
set tabstop=4
set scrolloff=5
set cindent
"set expandtab "设置tab=space
"set noexpandtab "设置spce=tab
set mouse-=a
set nocompatible"不兼容vi模式
set cmdheight=1
set hlsearch
set backspace=indent,eol,start "设置back键
au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif
let &t_SI.="\e[6 q" "SI = INSERT mode
let &t_SR.="\e[4 q" "SR = REPLACE mode
let &t_EI.="\e[2 q" "EI = NORMAL mode (ELSE)
"setlocal list
"set listchars=tab:>-,trail:*,space:.,eol:$
"-------------------------------------------------------------------------------------
"coc-nvim 补全
set signcolumn=number
set signcolumn=yes

inoremap <silent><expr> <TAB>
            \ pumvisible() ? "\<C-n>" :
            \ CheckBackspace() ? "\<TAB>" :
            \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! CheckBackspace() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction

inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
            \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

nnoremap <silent> ]r <Plug>(coc-diagnostic-prev)
nnoremap <silent> [r <Plug>(coc-diagnostic-next)
nnoremap <silent> gd <Plug>(coc-definition)
nnoremap <silent> gr <Plug>(coc-rename)
nnoremap <silent> K :call ShowDocumentation()<CR>

let g:coc_global_extensions = [
            \ 'coc-json',
            \ 'coc-glslx',
            \ 'coc-snippets',
            \ 'coc-go', ]
"-----------------------------------------------------------------------------------

"Defx 目录树
let g:defx_icons_enable_syntax_highlight = 1
let g:defx_icons_column_length = 2
let g:defx_icons_directory_icon = ''
let g:defx_icons_mark_icon = '*'
let g:defx_icons_copy_icon = ''
let g:defx_icons_link_icon = ''
let g:defx_icons_move_icon = ''
let g:defx_icons_parent_icon = ''
let g:defx_icons_default_icon = ''
let g:defx_icons_directory_symlink_icon = ''
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
            \ 'winwidth': 20,
            \ 'split': 'vertical',
            \ 'direction': 'topleft',
            \ 'show_ignored_files': 0,
            \ 'root_marker': '≡ ',
            \ 'ignored_files':
            \     '.mypy_cache,.pytest_cache,.git,.hg,.svn,.*,.stversions'
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

    nnoremap <silent><buffer><expr> .
                \ defx#do_action('toggle_ignored_files')
endfunction
let g:python3_host_prog=('python3')

"-----------------------------------------------------------------------------------
"主题 material
set background=dark
set termguicolors 
" 'default-community' | 'palenight-community' | 'ocean-community' | 'lighter-community' | 'darker-community'
let g:material_theme_style ='palenight-community'
let ayucolor="light"
colorscheme material

"------------------------------------------------------------------------------------
"状态栏

set laststatus=2
set hidden
set noshowmode
let g:lightline = {
            \ 'colorscheme': 'material_vim',
            \ 'active': {
            \   'left': [ [ 'mode', 'paste' ],
            \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
            \ },
            \ 'component_function': {
            \   'gitbranch': 'gitbranch#name'
            \ },
            \ }
let g:lightline.separator = { 'left': '', 'right': '' }
let g:lightline.subseparator = { 'left': '', 'right': '' }
let g:lightline.tabline_separator = g:lightline.separator
let g:lightline.tabline_subseparator = g:lightline.subseparator

"------------------------------------------------------------------------------------
"高亮
let g:cpp_class_scope_highlight = 1
let g:cpp_member_variable_highlight = 1
let g:cpp_class_decl_highlight = 1
let g:cpp_posix_standard = 1
let g:cpp_experimental_simple_template_highlight = 1
let g:cpp_experimental_template_highlight = 1
let g:cpp_concepts_highlight = 1
let g:cpp_no_function_highlight = 1

"------------------------------------------------------------------------------------
"fzf
let g:fzf_layout = { 'window': { 'width': 0.8, 'height': 0.9, 'relative': v:true, 'border':'sharp'} }
nnoremap <leader>ff :Files<CR>
nnoremap <leader>fg :Rg<CR>
nnoremap <leader>fb :Buffers<CR>
nnoremap <leader>fl :BLines<CR>
nnoremap <leader>fa :Ag<CR>
"------------------------------------------------------------------------------------
"vim-floaterm终端
let g:floaterm_title='xMonody'
let g:floaterm_width=0.8
let g:floaterm_height=0.9
nnoremap <silent><leader>t :FloatermNew --height=0.9 --width=0.8<CR>
nnoremap <silent><leader>g :FloatermNew lazygit<CR>
tnoremap <silent><leader>d exit<CR>
"-----------------------------------------------------------------------------------
"indentLine
let g:indentLine_color_term = 111
let g:indentLine_char = '┆'
let g:indentLine_char_list = ['┆']
set listchars=tab:\┆\ ",trail:■,extends:>,precedes:<,nbsp:+
set list
"------------------------------------------------------------------------------------
"vim-visual-multi
let g:AutoPairsShortcutFastWrap = '<C-e>'
"------------------------------------------------------------------------------------
"nerdcommenter
let g:auto_save = 1
"------------------------------------------------------------------------------------
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
let g:AutoPairsShortcutFastWrap = '<C-e>'
"------------------------------------------------------------------------------------
"git setting
set updatetime=150
let g:gitgutter_max_signs = 500
let g:gitgutter_max_signs = -1
highlight GitgutterAdd guifg=#009900 ctermfg=10
highlight GitgutterChange guifg=#bbbb00 ctermfg=9
highlight GitgutterDelete guifg=#ff2222 ctermfg=9
let g:gitgutter_sign_added='|'
let g:gitgutter_sign_modified='|'
let g:gitgutter_sign_removed='|'
let g:gitgutter_sign_removed_first_line='|'
let g:gitgutter_sign_removed_above_and_below='|'
let g:gitgutter_sign_modified_removed='|'
nmap [c <Plug>(GitGutterNextHunk)
nmap ]c <Plug>(GitGutterPrevHunk)

nnoremap <silent><leader>hd :Gvdiffsplit<CR>
nnoremap <silent><leader>hb :Git blame<CR>

"--------------------------------------------------------------------------------

inoremap <silent><C-l> <Right>
nnoremap <silent><C-j> :bn<CR>
nnoremap <silent><C-k> :bp<CR>
nnoremap <silent><leader>d :bd<CR>

nnoremap <leader>a :%s/<C-r><C-w>//g<left><left>

nnoremap <silent>q :nohl<CR>
nnoremap <silent><leader>q <C-w>q
nnoremap <silent><leader>o :vsp<CR>
vnoremap <silent>q <Esc>

nnoremap <silent><leader>yy "+yy
nnoremap <silent><leader>p "+p
vnoremap <silent><leader>y "+y

nnoremap <silent><C-w>j <C-w>t<C-w>K
nnoremap <silent><C-w>k <C-w>t<C-w>H
nnoremap <silent>zh <C-w>3>
nnoremap <silent>zl <C-w>3<

nnoremap <expr>m col(".")==col("$")-1 ? "^" : "$"

autocmd vimenter * :call Myhi()
nnoremap <silent><leader>h :call Myhi()<CR>
def Myhi()
    syn match cFunctions "\<[a-zA-Z_][a-zA-Z_0-9]*\>[^()]*)("me=e-2
    syn match cFunctions "\<[a-zA-Z_][a-zA-Z_0-9]*\>\s*("me=e-1
    hi cFunctions ctermfg=75
set numberwidth=1
enddef

