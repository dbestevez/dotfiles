" Vundle ----------------------------------------------------------------------
set nocompatible
filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Plugin 'gmarik/vundle'

Plugin 'airblade/vim-gitgutter'
Plugin 'algotech/ultisnips-php'
Plugin 'bkad/CamelCaseMotion'
Plugin 'davidoc/taskpaper.vim'
Plugin 'duggiefresh/vim-easydir'
Plugin 'editorconfig/editorconfig-vim'
Plugin 'easymotion/vim-easymotion'
Plugin 'epmatsw/ag.vim'
Plugin 'ervandew/supertab'
Plugin 'godlygeek/tabular'
Plugin 'honza/vim-snippets'
Plugin 'jeetsukumaran/vim-buffergator'
Plugin 'jistr/vim-nerdtree-tabs'
Plugin 'kien/ctrlp.vim'
Plugin 'mattn/emmet-vim'
Plugin 'mhinz/vim-startify'
Plugin 'powerline/powerline', {'rtp': 'powerline/bindings/vim/'}
Plugin 'scrooloose/NERDCommenter'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/syntastic'
Plugin 'Shougo/neocomplete.vim'
Plugin 'sickill/vim-monokai'
Plugin 'SirVer/ultisnips'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-surround'
Plugin 'wesQ3/vim-windowswap'
Plugin 'Yggdroot/indentLine'

filetype plugin indent on

" Colors -----------------------------------------------------------------------
set t_Co=256
colorscheme seti-monokai
syntax enable
let &colorcolumn="".join(range(81,121),",")

" Misc -------------------------------------------------------------------------
set nobackup
set noswapfile
set mouse=a
let mapleader="\<Space>"

if has('unnamedplus')
    set clipboard=unnamed,unnamedplus
endif

" Spaces & Tabs ----------------------------------------------------------------
set tabstop=4
set softtabstop=4
set expandtab
set shiftwidth=4
set cindent

" UI Layout --------------------------------------------------------------------
set cursorline
set lazyredraw
set noshowmode
set nowrap
set number
set showmatch
set splitbelow
set splitright
set ttyfast
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

" Easymotion -------------------------------------------------------------------
nmap s <Plug>(easymotion-s)
nmap ss <Plug>(easymotion-s2)
nmap t <Plug>(easymotion-t)
nmap tt <Plug>(easymotion-t2)

" Editorconfig -----------------------------------------------------------------
let g:EditorConfig_exec_path = '/usr/bin/editorconfig'

" Emmet ------------------------------------------------------------------------
let g:user_emmet_leader_key='<C-w>'

" Neocomplete ------------------------------------------------------------------
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#max_list = 10

" NERD Tree --------------------------------------------------------------------
let NERDTreeHighlightCursorline = 1

" Powerline --------------------------------------------------------------------
set laststatus=2

" Syntastic --------------------------------------------------------------------
let g:syntastic_php_phpcs_args="--standard=PSR2 -n --report=csv"
let g:syntastic_javascript_checkers = [ 'jshint' ]

" UltiSnips --------------------------------------------------------------------
let g:UltiSnipsEditSplit="vertical"
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"

" Command shortcuts ------------------------------------------------------------
cmap w!! w !sudo tee > /dev/null %
cmap reload source ~/.vimrc

" Leader shortcuts -------------------------------------------------------------
nmap <leader>= :call Preserve("normal gg=G")<CR>
nmap <leader>a= :Tabularize /=<CR>
nmap <leader>a=> :Tabularize /=><CR>
nmap <leader>a: :Tabularize /:<CR>
nmap <leader>bb :CtrlPBuffer<CR>

" Line shortcuts ---------------------------------------------------------------
nmap <C-w>- :rightb new<CR>
nmap <C-w>\| :vnew<CR>
nmap <C-w>t :tabnew<CR>
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

nnoremap <silent> <C-h> :call WinMove('h')<cr>
nnoremap <silent> <C-j> :call WinMove('j')<cr>
nnoremap <silent> <C-k> :call WinMove('k')<cr>
nnoremap <silent> <C-l> :call WinMove('l')<cr>

nnoremap <silent> <C-z> :call ZoomToggle()<CR>

noremap <F12> :NERDTreeToggle<CR>
noremap <C-F12> :NERDTreeFocus<CR>

inoremap <expr> <C-j> ("\<C-n>")
inoremap <expr> <C-k> ("\<C-p>")

" Autocommands -----------------------------------------------------------------
autocmd BufWritePre * :call Preserve("%s/\\s\\+$//e")
autocmd VimEnter * call StartUp()
autocmd VimEnter * wincmd p
autocmd BufRead,BufNewFile *.done,*.todo,*.task set filetype=taskpaper
autocmd BufRead,BufNewFile *.tpl set filetype=html

" Keep cursor on column when leaving INSERT mode
let CursorColumnI = 0
autocmd InsertEnter * let CursorColumnI = col('.')
autocmd CursorMovedI * let CursorColumnI = col('.')
autocmd InsertLeave * if col('.') != CursorColumnI | call cursor(0, col('.')+1) | endif

" Custom functions -------------------------------------------------------------
" Open NERDTree on stat up when no arguments
function! StartUp()
    if 0 == argc()
        NERDTree
    end
endfunction

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

" Create a split if no movement
function! WinMove(key)
    let t:curwin = winnr()
    exec "wincmd ".a:key
    if (t:curwin == winnr())
        if (match(a:key,'[jk]'))
            vnew
        else
            new
        endif
        exec "wincmd ".a:key
    endif
endfunction

" Zoom / Restore window.
function! ZoomToggle()
    if exists('t:zoomed') && t:zoomed
        execute t:zoom_winrestcmd
        let t:zoomed = 0
    else
        let t:zoom_winrestcmd = winrestcmd()
        resize
        vertical resize
        let t:zoomed = 1
    endif
endfunction

function! CtrlPMark()
    if expand('%:t') =~ 'ControlP'
        call lightline#link('iR'[g:lightline.ctrlp_regex])
        return lightline#concatenate([g:lightline.ctrlp_prev, g:lightline.ctrlp_item
                    \ , g:lightline.ctrlp_next], 0)
    else
        return ''
    endif
endfunction

augroup AutoSyntastic
    autocmd!
    autocmd BufWritePost *.c,*.cpp call s:syntastic()
augroup END

function! s:syntastic()
    SyntasticCheck
    call lightline#update()
endfunction
