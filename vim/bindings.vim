" Disable arrow keys
noremap <Up>    <NOP>
noremap <Down>  <NOP>
noremap <Left>  <NOP>
noremap <Right> <NOP>

" Vim shortcuts
nnoremap ; :
nnoremap <CR> :nohl<CR><CR>
nmap <leader>r :source $MYVIMRC<CR>
nmap <leader>e :tabedit $MYVIMRC<CR>
nmap <leader>w :w!<CR>

" Split shortcuts
nmap <C-w>- :rightb new<CR>
nmap <C-w>\| :vnew<CR>
nmap <C-w>t :tabnew<CR>
nmap <C-w><C-h> :tabprevious<CR>
nmap <C-w><C-l> :tabnext<CR>
nmap <C-w><S-h> :vertical res -5<CR>
nmap <C-w><S-j> :res +5<CR>
nmap <C-w><S-k> :res -5<CR>
nmap <C-w><S-l> :vertical res +5<CR>

" Function shortcuts
nnoremap <silent> <C-h> :call WinMove('h')<cr>
nnoremap <silent> <C-j> :call WinMove('j')<cr>
nnoremap <silent> <C-k> :call WinMove('k')<cr>
nnoremap <silent> <C-l> :call WinMove('l')<cr>
nnoremap <silent> <C-z> :call ZoomToggle()<CR>

" Plugin shortcuts
nmap <leader>= :call Preserve("normal gg=G")<CR>
nmap <leader>a= :Tabularize /=<CR>
nmap <leader>a=> :Tabularize /=><CR>
nmap <leader>a: :Tabularize /:<CR>
nmap <leader>bb :CtrlPBuffer<CR>
nmap <leader>g :Gstatus<CR>
imap \foo <C-R>=fake#gen("foobar")<CR>

nnoremap <Leader>fu :CtrlPFunky<Cr>
nnoremap <Leader>fU :execute 'CtrlPFunky ' . expand('<cword>')<Cr>
noremap <F12> :NERDTreeTabsToggle<CR>

" CamelCaseMotion
map <silent> ,w <Plug>CamelCaseMotion_w
map <silent> ,b <Plug>CamelCaseMotion_b
map <silent> ,e <Plug>CamelCaseMotion_e
map <silent> ,ge <Plug>CamelCaseMotion_ge

" Neocomplete
inoremap <expr> <C-j> ("\<C-n>")
inoremap <expr> <C-k> ("\<C-p>")

" Vim-move
map <Down> <Plug>MoveLineDown
nmap <Up> <Plug>MoveLineUp
vmap <Down> <Plug>MoveBlockDown
vmap <Up> <Plug>MoveBlockUp
