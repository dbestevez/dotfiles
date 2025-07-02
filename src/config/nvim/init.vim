set nocompatible
filetype off

call plug#begin('~/.config/nvim/plugged')

Plug 'neoclide/coc.nvim', {'branch': 'release'}
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
Plug 'jeetsukumaran/vim-buffergator'
Plug 'jiangmiao/auto-pairs'
Plug 'jremmen/vim-ripgrep'
Plug 'junegunn/vim-easy-align'
Plug 'junegunn/goyo.vim'
Plug 'lambdalisue/suda.vim'
Plug 'lilydjwg/colorizer'
Plug 'luochen1990/rainbow'
Plug 'mattn/emmet-vim'
Plug 'matze/vim-move'
Plug 'nelsyeung/twig.vim'
Plug 'neomake/neomake'
Plug 'phpactor/phpactor', {'for': 'php', 'tag': '*', 'do': 'composer install --no-dev -o'}
Plug 'scrooloose/NERDCommenter'
Plug 'simplenote-vim/simplenote.vim'
Plug 'tkhren/vim-fake'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'vim-scripts/BufOnly.vim'
Plug 'vim-scripts/po.vim--Jelenak'
Plug 'vim-scripts/SyntaxAttr.vim'
Plug 'wesQ3/vim-windowswap'
Plug 'Yggdroot/indentLine'
Plug 'yssl/qfenter'
Plug 'yuttie/comfortable-motion.vim'
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
set background=dark
let &colorcolumn="".join(range(81,120),",")
set guicursor=n-v-c:block-blinkon0,i-ci-r-cr:block-blinkwait100-blinkon100-blinkon100
set t_Co=256

" Misc
set encoding=utf-8
let mapleader="\<Space>"
set laststatus=2
set mouse=a
set nobackup
set noswapfile
set updatetime=250

if !has('nvim')
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
set lazyredraw
set noshowmode
set nowrap
set number
set previewheight=15
set showmatch
set splitbelow
set splitright
set switchbuf+=usetab,newtab
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

source ~/.config/nvim/detect.vim
source ~/.config/nvim/plugins.vim
source ~/.config/nvim/functions.vim
source ~/.config/nvim/commands.vim
source ~/.config/nvim/keys.vim

" Theme provided by themer (https://github.com/dbestevez/themer)
if filereadable(expand('~/.config/nvim/themer.vim'))
    source ~/.config/nvim/themer.vim

    let g:rainbow_conf = {
    \	'guifgs': [ g:color13[0],  g:color14[0], g:color10[0], g:color11[0], g:color9[0] ],
    \	'ctermfgs': [ g:color13[1],  g:color14[1], g:color10[1], g:color11[1], g:color9[1] ],
    \	'operators': '_,_',
    \	'contains_prefix': 'TOP',
    \	'parentheses_options': '',
    \	'parentheses': ['start=/(/ end=/)/ fold', 'start=/\[/ end=/\]/ fold', 'start=/{/ end=/}/ fold'],
    \}
endif

" Simplenote
if filereadable(expand('~/.simplenoterc'))
    source ~/.simplenoterc
endif
