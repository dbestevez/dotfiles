set nocompatible
filetype off

call plug#begin('~/.vim/plugged')

Plug 'airblade/vim-gitgutter'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'bkad/CamelCaseMotion'
Plug 'danro/rename.vim'
Plug 'dhruvasagar/vim-table-mode'
Plug 'duggiefresh/vim-easydir'
Plug 'easymotion/vim-easymotion'
Plug 'editorconfig/editorconfig-vim'
Plug 'ervandew/supertab'
Plug 'google/vim-searchindex'
Plug 'haya14busa/incsearch-easymotion.vim'
Plug 'haya14busa/incsearch.vim'
Plug 'haya14busa/vim-easyoperator-line'
Plug 'itchyny/lightline.vim'
Plug 'jremmen/vim-ripgrep'
Plug 'jiangmiao/auto-pairs'
Plug 'junegunn/vim-easy-align'
Plug 'lambdalisue/suda.vim'
Plug 'lilydjwg/colorizer'
Plug 'mattn/emmet-vim'
Plug 'matze/vim-move'
Plug 'mrtazz/simplenote.vim'
Plug 'neomake/neomake'
Plug 'scrooloose/NERDCommenter'
Plug 'tkhren/vim-fake'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'vim-scripts/BufOnly.vim'
Plug 'vim-scripts/po.vim--Jelenak'
Plug 'vim-scripts/SyntaxAttr.vim'
Plug 'wesQ3/vim-windowswap'
Plug 'Yggdroot/indentLine'
Plug 'vim-vdebug/vdebug'

" Autocompletion
if has('nvim')
    Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
    Plug 'Shougo/deoplete.nvim'
    Plug 'roxma/nvim-yarp'
    Plug 'roxma/vim-hug-neovim-rpc'
endif

" CtrlP
Plug 'ctrlpvim/ctrlp.vim'
Plug 'tacahiroy/ctrlp-funky'

" NERDTree
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'ryanoasis/vim-devicons'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'

" Obsession
Plug 'tpope/vim-obsession'
Plug 'dhruvasagar/vim-prosession'
Plug 'mhinz/vim-startify'

" Snippets
Plug 'Shougo/neosnippet.vim'
Plug 'Shougo/neosnippet-snippets'

" Syntax
Plug 'dbestevez/php.vim'
Plug 'dbestevez/smarty.vim'
Plug 'ingydotnet/yaml-vim'
Plug 'pangloss/vim-javascript'
Plug 'plasticboy/vim-markdown'
Plug 'tpope/vim-cucumber'
Plug 'vim-scripts/nginx.vim'

" Text objects
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-function'
Plug 'kana/vim-textobj-line'
Plug 'kentaro/vim-textobj-function-php'
Plug 'thinca/vim-textobj-function-javascript'

call plug#end()

filetype plugin indent on
syntax   enable

" Colors
set t_Co=256
set guicursor=n-v-c:block-Cursor/lCursor-blinkon0,i-ci:block-Cursor/lCursor-blinkon100,r-cr:hor20-Cursor/lCursor
set background=dark
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
set previewheight=15
set showmatch
set splitbelow
set splitright
set ttyfast
set wildmenu

" Fold
set foldenable
set foldlevelstart=20
set foldmethod=indent
set foldnestmax=20

" Search
set hlsearch
set ignorecase
set incsearch
set smartcase

source ~/.vim/detect.vim
source ~/.vim/plugins.vim
source ~/.vim/functions.vim
source ~/.vim/commands.vim
source ~/.vim/keys.vim

" Theme provided by themer (https://github.com/dbestevez/themer)
if filereadable(expand('~/.vim/autoload/theme.vim'))
    source ~/.vim/autoload/theme.vim
endif

" Simplenote
if filereadable(expand('~/.simplenoterc'))
    source ~/.simplenoterc
endif
