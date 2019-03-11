set nocompatible
filetype off

call plug#begin('~/.vim/plugged')

Plug 'altercation/vim-colors-solarized'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'airblade/vim-gitgutter'
Plug 'algotech/ultisnips-php'
Plug 'bkad/CamelCaseMotion'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'danro/rename.vim'
Plug 'davidoc/taskpaper.vim'
Plug 'dbestevez/keepcursor.vim'
Plug 'dhruvasagar/vim-table-mode'
Plug 'duggiefresh/vim-easydir'
Plug 'editorconfig/editorconfig-vim'
Plug 'easymotion/vim-easymotion'
Plug 'epmatsw/ag.vim'
Plug 'ervandew/supertab'
Plug 'flazz/vim-colorschemes'
Plug 'google/vim-searchindex'
Plug 'haya14busa/incsearch.vim'
Plug 'haya14busa/incsearch-fuzzy.vim'
Plug 'haya14busa/incsearch-easymotion.vim'
Plug 'haya14busa/vim-easyoperator-line'
Plug 'honza/vim-snippets'
Plug 'itchyny/lightline.vim'
Plug 'jeetsukumaran/vim-buffergator'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'jiangmiao/auto-pairs'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
Plug 'junegunn/vim-easy-align'
Plug 'junegunn/vim-journal'
Plug 'kana/vim-textobj-user'
Plug 'lilydjwg/colorizer'
Plug 'mattn/emmet-vim'
Plug 'matze/vim-move'
Plug 'mrtazz/simplenote.vim'
Plug 'neomake/neomake'
Plug 'pangloss/vim-javascript'
Plug 'plasticboy/vim-markdown'
Plug 'scrooloose/NERDCommenter'
Plug 'scrooloose/nerdtree'
Plug 'vim-scripts/BufOnly.vim'
Plug 'vim-scripts/SyntaxAttr.vim'
Plug 'vim-scripts/loremipsum'
Plug 'vim-scripts/nginx.vim'
Plug 'vim-scripts/po.vim--Jelenak'

if has('nvim')
    Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
elseif has('lua')
    Plug 'Shougo/neocomplete.vim'
endif

Plug 'SirVer/ultisnips'
Plug 'dbestevez/php.vim'
Plug 'ingydotnet/yaml-vim'
Plug 'terryma/vim-multiple-cursors'
Plug 'tpope/vim-cucumber'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-obsession'
Plug 'tacahiroy/ctrlp-funky'
Plug 'tkhren/vim-fake'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'wesQ3/vim-windowswap'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'Yggdroot/indentLine'
Plug 'ryanoasis/vim-devicons'
Plug 'dhruvasagar/vim-prosession'
Plug 'mhinz/vim-startify'
Plug 'kana/vim-textobj-function'
Plug 'kana/vim-textobj-line'
Plug 'kentaro/vim-textobj-function-php'
Plug 'thinca/vim-textobj-function-javascript'

call plug#end()

filetype plugin indent on

" Colors
set t_Co=256
set guicursor=n-v-c:block-Cursor/lCursor-blinkon0,i-ci:block-Cursor/lCursor-blinkon100,r-cr:hor20-Cursor/lCursor

set background=dark

syntax enable
let &colorcolumn="".join(range(81,120),",")

" Misc
let mapleader="\<Space>"
set laststatus=2
set mouse=a
set nobackup
set noswapfile
set updatetime=250

if !has('nvim')
    set encoding=utf8
    set ttymouse=xterm2
    set clipboard=unnamed,unnamedplus
endif

if has('clipboard')
    set clipboard=unnamed,unnamedplus
endif

" Spaces & Tabs
set tabstop=4
set softtabstop=4
set expandtab
set shiftwidth=4
set cindent

" UI Layout
set cursorline
set fillchars+=vert:\│
set lazyredraw
set noshowmode
set nowrap
set number
set showmatch
set splitbelow
set splitright
set ttyfast
set wildmenu
set previewheight=15

" Searching
set hlsearch
set ignorecase
set incsearch
set smartcase

" Folding
set foldenable
set foldlevelstart=20
set foldmethod=indent
set foldnestmax=20

source ~/.vim/functions.vim
source ~/.vim/mapping.vim
source ~/.vim/commands.vim

" CtrlP
let g:ctrlp_dont_split = 'nerdtree'
let g:ctrlp_extensions = ['funky']
let g:ctrlp_match_window = 'bottom,order:btt,min:1,max:20,results:40'
let g:ctrlp_max_depth = 20
let g:ctrlp_max_files = 0
let g:ctrlp_switch_buffer = 0
let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
let g:ctrlp_working_path_mode = "ra"
let g:ctrlp_status_func = {
    \ 'main': 'CtrlPStatusMain',
    \ 'prog': 'CtrlPStatusProg',
\ }

let g:ctrlp_funky_syntax_highlight = 1

" Deoplete/Neocomplete
if has('nvim')
    let g:deoplete#num_processes = 1
    let g:deoplete#enable_at_startup = 1
    let g:deoplete#max_list = 10
elseif has ('lua')
    let g:neocomplete#enable_at_startup = 1
    let g:neocomplete#max_list = 10
endif

" Easy-align
nmap ga <Plug>(EasyAlign)
vmap <Enter> <Plug>(EasyAlign)

" Easy-motion
nmap <leader>s <Plug>(easymotion-s)
nmap <leader>ss <Plug>(easymotion-s2)

" Editorconfig
let g:EditorConfig_exec_path = '/usr/bin/editorconfig'

" Emmet
let g:user_emmet_leader_key = '<C-w>'

" Lightline
let g:lightline = {
    \ 'active': {
    \   'left':  [ [ 'mode', 'paste', 'ctrlpprev' ], [ 'fugitive', 'ctrlpitem' ], [ 'filename', 'ctrlpnext' ] ],
    \   'right': [ [ 'lineinfo' ], [ 'percent', 'debug', 'neomake' ] ]
    \ },
    \ 'colorscheme': 'default',
    \ 'component_function': {
    \     'ctrlp':     'LightlineCtrlP',
    \     'ctrlpitem': 'LightlineCtrlPItem',
    \     'ctrlpprev': 'LightlineCtrlPPrev',
    \     'ctrlpnext': 'LightlineCtrlPNext',
    \     'filename':  'LightlineFileName',
    \     'fugitive':  'LightlineFugitive',
    \     'mode':      'LightlineMode',
    \     'paste':     'LightlinePaste',
    \ },
    \ 'component_expand': {
    \     'debug':    'LightlineDebug',
    \     'errors':   'LightlineNeomakeErrors',
    \     'neomake':  'LightlineNeomake',
    \     'warnings': 'LightlineNeomakeWarnings',
    \ },
    \ 'component_type': {
    \   'warnings': 'warning',
    \   'errors':  'error',
    \   'debug':   'info',
    \   'neomake': 'error',
    \ },
    \ 'separator': { 'left': '', 'right': '' },
    \ 'subseparator': { 'left': '', 'right': '' }
\ }

" Limelight
let g:limelight_conceal_ctermfg = 7

" NERD Tree
let NERDTreeHighlightCursorline = 1

" Neomake
call neomake#configure#automake('w')

let g:neomake_error_sign = { 'text': "\uf00d", 'texthl': 'NeomakeError' }
let g:neomake_warning_sign = { 'text': "\uf071", 'texthl': 'NeomakeWarning' }
let g:neomake_informational_sign = { 'text': "\uf05a", 'texthl': 'NeomakeInfo' }
let g:neomake_message_sign = { 'text': "\uf09a", 'texthl': 'NeomakeInfo' }

let g:neomake_css_csslint_maker = {
    \ 'args': [ '--format=compact' ],
    \ 'errorformat':
    \   '%-G,'.
    \   '%-G%f: lint free!,'.
    \   '%f: line %l\, col %c\, %trror - %m,'.
    \   '%f: line %l\, col %c\, %tarning - %m,'.
    \   '%f: line %l\, col %c\, %m,'.
    \   '%f: %tarning - %m'
\ }

let g:neomake_php_phpcs_maker = {
    \ 'args': [ '--report=csv' ],
    \ 'errorformat':
        \ '%-GFile\,Line\,Column\,Type\,Message\,Source\,Severity%.%#,'.
        \ '"%f"\,%l\,%c\,%t%*[a-zA-Z]\,"%m"\,%*[a-zA-Z0-9_.-]\,%*[0-9]%.%#',
\ }

let g:neomake_php_phpmd_maker = {
    \ 'args': [ '%:p', 'text' ],
    \ 'errorformat': '%W%f:%l%\s%\s%#%m'
    \ }

let g:neomake_javascript_eslint_maker = {
    \ 'args': [ '--format=compact' ],
    \ 'errorformat':
    \   '%-G,'.
    \   '%-G%f: lint free!,'.
    \   '%f: line %l\, col %c\, %trror - %m,'.
    \   '%f: line %l\, col %c\, %tarning - %m,'.
    \   '%f: line %l\, col %c\, %m,'.
    \   '%f: %tarning - %m'
    \ }

let g:neomake_javascript_enabled_makers = [ 'eslint' ]

" PHP
let PHP_noArrowMatching = 1

" UltiSnips
let g:UltiSnipsEditSplit = "vertical"
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"

" Vim-fake
let g:fake_src_paths = [ '~/.vim/autoload/vim-fake' ]

" Vim-move
let g:move_map_keys = 0

" Simplenote
if filereadable(expand('~/.simplenoterc'))
    source ~/.simplenoterc
endif

if filereadable(expand('~/.vim/autoload/theme.vim'))
    source ~/.vim/autoload/theme.vim
endif
