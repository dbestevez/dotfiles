" Vundle ----------------------------------------------------------------------
set nocompatible
filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'

Bundle 'airblade/vim-gitgutter'
Bundle 'davidoc/taskpaper.vim'
Bundle 'duggiefresh/vim-easydir'
Bundle 'editorconfig/editorconfig-vim'
Bundle 'godlygeek/tabular'
Bundle 'jeetsukumaran/vim-buffergator'
Bundle 'kien/ctrlp.vim'
Bundle 'mattn/emmet-vim'
Bundle 'powerline/powerline', {'rtp': 'powerline/bindings/vim/'}
Bundle 'scrooloose/nerdtree'
Bundle 'scrooloose/syntastic'
Bundle 'Shougo/neocomplete.vim'
Bundle 'sickill/vim-monokai'
Bundle 'terryma/vim-multiple-cursors'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-surround'
Bundle 'Yggdroot/indentLine'

filetype plugin indent on

" Colors -----------------------------------------------------------------------
set t_Co=256
colorscheme seti-monokai
syntax enable
let &colorcolumn="".join(range(81,121),",")

" Misc -------------------------------------------------------------------------
set nobackup
set noswapfile

" Spaces & Tabs ----------------------------------------------------------------
set tabstop=4
set softtabstop=4
set expandtab
set shiftwidth=4
set smartindent

" UI Layout --------------------------------------------------------------------
set cursorline
set lazyredraw
set noshowmode
set nowrap
set number
set showmatch
set splitbelow
set splitright
set wildmenu

" Searching --------------------------------------------------------------------
set hlsearch
set ignorecase
set incsearch
set smartcase

" Folding ----------------------------------------------------------------------
set foldenable
set foldlevelstart=10
set foldmethod=indent
set foldnestmax=10

" CtrlP ------------------------------------------------------------------------
let g:ctrp_max_depth=20
let g:ctrlp_max_files=0
let g:ctrlp_switch_buffer=0
let g:ctrlp_user_command='ag %s -l --nocolor -g ""'
let g:ctrp_working_path_mode="ra"

" Editorconfig -----------------------------------------------------------------
let g:EditorConfig_exec_path = '/usr/bin/editorconfig'

" Emmet ------------------------------------------------------------------------
let g:user_emmet_leader_key='<C-w>'

" Neocomplete ------------------------------------------------------------------
let g:neocomplete#enable_at_startup = 1

" NERD Tree --------------------------------------------------------------------
let NERDTreeHighlightCursorline=1

" Powerline --------------------------------------------------------------------
set laststatus=2

" Syntastic --------------------------------------------------------------------
let g:syntastic_php_phpcs_args="--standard=PSR2 -n --report=csv"

" Command shortcuts ------------------------------------------------------------
cmap w!! w !sudo tee > /dev/null %
cmap reload source ~/.vimrc

" Leader shortcuts -------------------------------------------------------------
nmap <leader>= :call Preserve("normal gg=G")<CR>
nmap <leader>a= :Tabularize /=<CR>
nmap <leader>a=> :Tabularize /=><CR>
nmap <leader>a: :Tabularize /:<CR>

" Line shortcuts ---------------------------------------------------------------
nmap <C-w>- :rightb new<CR>
nmap <C-w>\| :vnew<CR>
nmap <C-w>c :tabnew<CR>
nmap <C-w><C-h> :tabprevious<CR>
nmap <C-w><C-l> :tabnext<CR>
nmap <C-w><S-h> :vertical res -5<CR>
nmap <C-w><S-j> :res +5<CR>
nmap <C-w><S-k> :res -5<CR>
nmap <C-w><S-l> :vertical res +5<CR>

nnoremap ; :
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l

noremap <F12> :NERDTreeToggle<CR>
noremap <C-F12> :NERDTreeFocus<CR>

inoremap <expr> <c-j> ("\<C-n>")
inoremap <expr> <c-k> ("\<C-p>")

" Autocommands -----------------------------------------------------------------
autocmd BufWritePre * :call Preserve("%s/\\s\\+$//e")
autocmd VimEnter * NERDTree
autocmd VimEnter * wincmd p
autocmd WinEnter * call s:CloseIfOnlyNerdTreeLeft()

" Custom functions -------------------------------------------------------------
" Closes vim if the only buffer that's left is the NERDTree buffer
function! s:CloseIfOnlyNerdTreeLeft()
    if exists("t:NERDTreeBufName")
        if bufwinnr(t:NERDTreeBufName) != -1
            if winnr("$") == 1
                q
            endif
        endif
    endif
endfunction

" Executes a command keeping the cursor position
function! Preserve(command)
    "Save last search, and cursor position
    let _s=@/
    let l = line(".")
    let c = col(".")

    " Do the business:
    execute a:command

    " Clean up: restore previous search history, and cursor position
    let @/=_s
    call cursor(l, c)
endfunction
