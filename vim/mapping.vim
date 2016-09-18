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
cmap ww w !sudo tee > /dev/null %

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
nnoremap <silent> <C-h> :call WinMove('h')<CR>
nnoremap <silent> <C-j> :call WinMove('j')<CR>
nnoremap <silent> <C-k> :call WinMove('k')<CR>
nnoremap <silent> <C-l> :call WinMove('l')<CR>
nnoremap <silent> <C-z> :call ZoomToggle()<CR>
nmap     <leader>=      :call Preserve("normal gg=G")<CR>

" CamelCaseMotion
map <silent> ,w  <Plug>CamelCaseMotion_w
map <silent> ,b  <Plug>CamelCaseMotion_b
map <silent> ,e  <Plug>CamelCaseMotion_e
map <silent> ,ge <Plug>CamelCaseMotion_ge

" CtrlP
nmap <leader>bb :CtrlPBuffer<CR>
nnoremap <Leader>fu :CtrlPFunky<CR>
nnoremap <Leader>fU :execute 'CtrlPFunky ' . expand('<cword>')<CR>

" Fugitive
nmap <leader>g :Gstatus<CR>

" Neocomplete
inoremap <expr> <C-j> ("\<C-n>")
inoremap <expr> <C-k> ("\<C-p>")

" Neomake
map <leader>tn :let g:neomake_open_list=1 \| :Neomake<CR>
map <leader>tN :let g:neomake_open_list=0 \| :Neomake<CR>

" NERDTree
noremap <F12> :NERDTreeTabsToggle<CR>

" Vim-fake
imap \foo <C-R>=fake#gen("foobar")<CR>

" Vim-move
nmap <Down> <Plug>MoveLineDown
nmap <Up>   <Plug>MoveLineUp
vmap <Down> <Plug>MoveBlockDown
vmap <Up>   <Plug>MoveBlockUp
