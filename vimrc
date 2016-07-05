" Vundle
set nocompatible
filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Plugin 'gmarik/vundle'

Plugin 'altercation/vim-colors-solarized'
Plugin 'AndrewRadev/splitjoin.vim'
Plugin 'BufOnly.vim'
Plugin 'airblade/vim-gitgutter'
Plugin 'algotech/ultisnips-php'
Plugin 'bkad/CamelCaseMotion'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'davidoc/taskpaper.vim'
Plugin 'duggiefresh/vim-easydir'
Plugin 'editorconfig/editorconfig-vim'
Plugin 'easymotion/vim-easymotion'
Plugin 'epmatsw/ag.vim'
Plugin 'ervandew/supertab'
Plugin 'godlygeek/tabular'
Plugin 'honza/vim-snippets'
Plugin 'itchyny/lightline.vim'
Plugin 'jeetsukumaran/vim-buffergator'
Plugin 'jistr/vim-nerdtree-tabs'
Plugin 'jiangmiao/auto-pairs'
Plugin 'junegunn/vim-easy-align'
Plugin 'kana/vim-textobj-user'
Plugin 'loremipsum'
Plugin 'mattn/emmet-vim'
Plugin 'matze/vim-move'
Plugin 'mhinz/vim-startify'
Plugin 'scrooloose/NERDCommenter'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/syntastic'
Plugin 'Shougo/neocomplete.vim'
Plugin 'SirVer/ultisnips'
Plugin 'stanangeloff/php.vim'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'tpope/vim-cucumber'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-obsession'
Plugin 'tacahiroy/ctrlp-funky'
Plugin 'tkhren/vim-fake'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-surround'
Plugin 'wesQ3/vim-windowswap'
Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'Yggdroot/indentLine'
Plugin 'ryanoasis/vim-devicons'

Plugin 'dhruvasagar/vim-prosession'
Plugin 'kana/vim-textobj-function'
Plugin 'kana/vim-textobj-line'
Plugin 'kentaro/vim-textobj-function-php'
Plugin 'thinca/vim-textobj-function-javascript'

filetype plugin indent on

" Colors
set t_Co=256

set background=dark
colorscheme solarized

syntax enable
let &colorcolumn="".join(range(81,121),",")

" Misc
set encoding=utf8
set nobackup
set noswapfile
set mouse=a
let mapleader="\<Space>"

if has('unnamedplus')
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
set ttymouse=xterm2
set wildmenu
set previewheight=15

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

" Neocomplete
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#max_list = 10

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
