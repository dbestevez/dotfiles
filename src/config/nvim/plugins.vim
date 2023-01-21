" Comfortable-motion
let g:comfortable_motion_friction = 80.0
let g:comfortable_motion_air_drag = 3.75

" CtrlP
let g:ctrlp_dont_split             = 'nerdtree'
let g:ctrlp_funky_syntax_highlight = 1
let g:ctrlp_extensions             = ['funky']
let g:ctrlp_match_window           = 'bottom,order:btt,min:1,max:20,results:40'
let g:ctrlp_max_depth              = 20
let g:ctrlp_max_files              = 0
let g:ctrlp_switch_buffer          = 0
let g:ctrlp_user_command           = 'rg %s --files --color=never --glob ""'
let g:ctrlp_usecaching             = 0
let g:ctrlp_working_path_mode      = "ra"
let g:ctrlp_status_func            = {
    \ 'main': 'CtrlPStatusMain',
    \ 'prog': 'CtrlPStatusProg',
\ }

" Deoplete
call deoplete#custom#option({
    \ 'enable_at_startup': 1,
    \ 'max_list': 10,
    \ 'num_processes': 1,
\ })

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

let g:neomake_php_phpstan_maker = {
    \ 'args': [ 'analyze', '--error-format', 'raw', '--no-progress', '--level', 'max' ],
    \ 'errorformat': '%f:%l:%m'
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

" Neosnippet
let g:neosnippet#snippets_directory='~/.config/nvim/snippets'

" PHP
let PHP_noArrowMatching = 1

" Ripgrep
let g:rg_command = 'rg --vimgrep --sort path'

" Smarty
let g:smarty_indent_block = 1

" Suda
let g:suda_smart_edit = 1

" Supertab
let g:SuperTabDefaultCompletionType = "<c-n>"

" Vim-fake
let g:fake_src_paths = [ '~/.config/nvim/autoload/vim-fake', '~/.config/nvim/plugged/vim-fake/src' ]

" Vim-move
let g:move_map_keys = 0

function! s:on_lsp_buffer_enabled() abort
    setlocal omnifunc=lsp#complete
    setlocal signcolumn=yes
    if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif

    "nmap <buffer> gd :tab <plug>(lsp-definition)
    nmap <buffer> gd :tab :LspDefinition<cr>
    nmap <buffer> gs <plug>(lsp-document-symbol-search)
    nmap <buffer> gS <plug>(lsp-workspace-symbol-search)
    nmap <buffer> gr <plug>(lsp-references)
    nmap <buffer> gi <plug>(lsp-implementation)
    "nmap <buffer> gt <plug>(lsp-type-definition)
    nmap <buffer> <leader>rn <plug>(lsp-rename)
    nmap <buffer> [g <plug>(lsp-previous-diagnostic)
    nmap <buffer> ]g <plug>(lsp-next-diagnostic)
    nmap <buffer> K <plug>(lsp-hover)
    inoremap <buffer> <expr><c-f> lsp#scroll(+4)
    inoremap <buffer> <expr><c-d> lsp#scroll(-4)

    let g:lsp_format_sync_timeout = 1000
    autocmd! BufWritePre *.rs,*.go call execute('LspDocumentFormatSync')

    " refer to doc to add more commands
endfunction

let g:lsp_diagnostics_enabled = 0
let g:lsp_document_highlight_enabled = 0

augroup lsp_install
    au!
    " call s:on_lsp_buffer_enabled only for languages that has the server registered.
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END

let g:vdebug_options = {
    \ 'port': 9003,
    \ 'path_maps': {
    \     '/var/www/playmister.com': '/home/diego/Projects/mister/playmister.com'
    \ }
\}
