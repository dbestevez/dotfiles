set nocompatible
filetype off

call plug#begin('~/.vim/plugged')

Plug 'altercation/vim-colors-solarized'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'BufOnly.vim'
Plug 'airblade/vim-gitgutter'
Plug 'algotech/ultisnips-php'
Plug 'bkad/CamelCaseMotion'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'davidoc/taskpaper.vim'
Plug 'duggiefresh/vim-easydir'
Plug 'editorconfig/editorconfig-vim'
Plug 'easymotion/vim-easymotion'
Plug 'epmatsw/ag.vim'
Plug 'ervandew/supertab'
Plug 'godlygeek/tabular'
Plug 'flazz/vim-colorschemes'
Plug 'honza/vim-snippets'
Plug 'itchyny/lightline.vim'
Plug 'jeetsukumaran/vim-buffergator'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'jiangmiao/auto-pairs'
Plug 'junegunn/vim-easy-align'
Plug 'junegunn/vim-journal'
Plug 'kana/vim-textobj-user'
Plug 'lifepillar/vim-solarized8'
Plug 'loremipsum'
Plug 'mattn/emmet-vim'
Plug 'matze/vim-move'
Plug 'mhinz/vim-startify'
Plug 'mrtazz/simplenote.vim'
Plug 'plasticboy/vim-markdown'
Plug 'scrooloose/NERDCommenter'
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/syntastic'

if has('nvim')
    Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
    Plug 'Shougo/neocomplete.vim'
endif

Plug 'SirVer/ultisnips'
Plug 'stanangeloff/php.vim'
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
Plug 'kana/vim-textobj-function'
Plug 'kana/vim-textobj-line'
Plug 'kentaro/vim-textobj-function-php'
Plug 'thinca/vim-textobj-function-javascript'

call plug#end()

filetype plugin indent on

" Colors
set t_Co=256

set background=dark
colorscheme monokai-chris

syntax enable
let &colorcolumn="".join(range(81,121),",")

" Misc
set encoding=utf8
set nobackup
set noswapfile
set mouse=a
let mapleader="\<Space>"
set updatetime=250

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

if !has('nvim')
  set ttymouse=xterm2
endif


" Searching
set hlsearch
set ignorecase
set incsearch
set smartcase

" Folding
set foldenable
set foldlevelstart=10
set foldmethod=indent
set foldnestmax=10

source ~/.vim/functions.vim
source ~/.vim/bindings.vim
source ~/.vim/commands.vim

" CtrlP
let g:ctrlp_match_window = 'bottom,order:btt,min:1,max:20,results:20'
let g:ctrlp_extensions = ['funky']
let g:ctrlp_max_depth=20
let g:ctrlp_max_files=0
let g:ctrlp_switch_buffer=0
let g:ctrlp_user_command='ag %s -l --nocolor -g ""'
let g:ctrp_working_path_mode="ra"
let g:ctrlp_status_func = {
    \ 'main': 'CtrlPStatusMain',
    \ 'prog': 'CtrlPStatusProg',
\ }

let g:ctrlp_funky_syntax_highlight = 1

" Deoplete/Neocomplete
if has('nvim')
    let g:deoplete#enable_at_startup = 1
else
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
let g:user_emmet_leader_key='<C-w>'

" Lightline
let g:lightline = {
    \ 'active': {
    \   'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'filename' ], ['ctrlpmark'] ],
    \   'right': [ [ 'syntastic', 'lineinfo' ], ['percent'] ]
    \ },
    \ 'colorscheme': 'solarized_custom',
    \ 'component_function': {
    \     'ctrlpmark': 'LightlineCtrlP',
    \     'fileencoding': 'LightlineFileEncoding',
    \     'fileformat': 'LightlineFileFormat',
    \     'filename': 'LightlineFileName',
    \     'filetype': 'LightlineFileType',
    \     'fugitive': 'LightlineFugitive',
    \     'mode': 'LightlineMode',
    \ },
    \ 'component_expand': {
    \   'syntastic': 'SyntasticStatuslineFlag',
    \ },
    \ 'component_type': {
    \   'syntastic': 'error',
    \ },
    \ 'separator': { 'left': '⮀', 'right': '⮂' },
    \ 'subseparator': { 'left': '⮁', 'right': '⮃' }
\ }

" NERD Tree
let NERDTreeHighlightCursorline = 1

" Powerline
set laststatus=2

" Syntastic
let g:syntastic_php_phpmd_post_args="cleancode,codesize,controversial,design,unusedcode"
let g:syntastic_php_phpcs_args="--standard=PSR2 -n --report=csv"
let g:syntastic_javascript_checkers = [ 'jshint' ]

" UltiSnips
let g:UltiSnipsEditSplit="vertical"
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"

" Vim-fake
let g:fake_src_paths = [ '~/.vim/autoload/vim-fake' ]

" Vim-move
let g:move_map_keys = 0

" Simplenote
source ~/.simplenoterc
