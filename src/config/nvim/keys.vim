" Disable arrow keys
noremap      <Up>        <NOP>
noremap      <Down>      <NOP>
noremap      <Left>      <NOP>
noremap      <Right>     <NOP>

" Vim shortcuts
nnoremap     ;           :
nnoremap     <CR>        :nohl<CR><CR>
nnoremap     +           <C-a>
nnoremap     -           <C-x>
nmap         <leader>php :set filetype=php<CR>
nmap         <leader>r   :source $MYVIMRC<CR>
nmap         <leader>e   :tabedit $MYVIMRC<CR>

" Split shortcuts
nmap         <C-w>-      :rightb new<CR>
nmap         <C-w>\|     :vnew<CR>
nmap         <C-w>t      :tabnew<CR>
nmap         <C-w><C-h>  :tabprevious<CR>
nmap         <C-w><C-l>  :tabnext<CR>
nmap         <C-w><S-h>  :vertical res -5<CR>
nmap         <C-w><S-j>  :res +5<CR>
nmap         <C-w><S-k>  :res -5<CR>
nmap         <C-w><S-l>  :vertical res +5<CR>

" Terminal
if has("nvim")
    tnoremap <Esc> <C-\><C-n>
end

" Function shortcuts
nnoremap     <silent>    <C-h> :call WinMove('h')<CR>
nnoremap     <silent>    <C-j> :call WinMove('j')<CR>
nnoremap     <silent>    <C-k> :call WinMove('k')<CR>
nnoremap     <silent>    <C-l> :call WinMove('l')<CR>
nnoremap     <silent>    <C-z> :call ZoomToggle()<CR>
nmap         <leader>=   :call Preserve("normal gg=G")<CR>

" CamelCaseMotion
map          <silent>    ,w  <Plug>CamelCaseMotion_w
map          <silent>    ,b  <Plug>CamelCaseMotion_b
map          <silent>    ,e  <Plug>CamelCaseMotion_e
map          <silent>    ,ge <Plug>CamelCaseMotion_ge

" Colorize
map          <Leader>co  <Plug>Colorizer

" CtrlP
nmap         <leader>bb  :CtrlPBuffer<CR>
nnoremap     <Leader>fu  :CtrlPFunky<CR>
nnoremap     <Leader>fU  :execute 'CtrlPFunky ' . expand('<cword>')<CR>

" Easymotion
map          s           <Plug>(easymotion-s)
map          S           <Plug>(easymotion-overwin-f)
map          <Leader>h   <Plug>(easymotion-linebackward)
map          <Leader>j   <Plug>(easymotion-j)
map          <Leader>k   <Plug>(easymotion-k)
map          <Leader>l   <Plug>(easymotion-lineforward)

" Incsearch
map          /           <Plug>(incsearch-forward)
map          ?           <Plug>(incsearch-backward)
map          g/          <Plug>(incsearch-stay)
map          <leader>/   <Plug>(incsearch-easymotion-/)
map          <leader>?   <Plug>(incsearch-easymotion-?)
map          <leader>g/  <Plug>(incsearch-easymotion-stay

" Fugitive
nmap         <leader>g   :Gstatus<CR>

" Neocomplete
inoremap     <expr><C-j> ("\<C-n>")
inoremap     <expr><C-k> ("\<C-p>")

" Neomake
map          <leader>tn  :let g:neomake_open_list=1 \| :Neomake<CR>
map          <leader>tN  :let g:neomake_open_list=0 \| :Neomake<CR>

" Neosnippet
imap         <C-l>       <Plug>(neosnippet_expand_or_jump)
smap         <C-l>       <Plug>(neosnippet_expand_or_jump)
xmap         <C-l>       <Plug>(neosnippet_expand_target)

" NERDTree
noremap      <F12>       :NERDTreeTabsToggle<CR>

" SyntaxAttr
map          -a          :call SyntaxAttr()<CR>

" Vim-move
nmap         <Down>      <Plug>MoveLineDown
nmap         <Up>        <Plug>MoveLineUp
vmap         <Down>      <Plug>MoveBlockDown
vmap         <Up>        <Plug>MoveBlockUp

" Use <TAB> to select the popup menu:
inoremap <expr> <Tab> coc#pum#visible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> coc#pum#visible() ? "\<C-p>" : "\<Tab>"
inoremap <expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<CR>"

" Phpactor
map         gdt     :PhpactorGotoDefinition tabnew<CR>
map         gdv     :PhpactorGotoDefinition vsplit<CR>
map         gh      :call CocAction('doHover')<CR>
