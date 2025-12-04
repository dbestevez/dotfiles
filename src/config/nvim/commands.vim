autocmd VimEnter * call StartUp()
autocmd VimEnter * wincmd p
autocmd VimLeave * set guicursor=a:block-Cursor-blinkon100

autocmd BufWritePre * :call Preserve(":call TrimWhiteSpaces()")

autocmd User NeomakeFinished call lightline#update()

augroup PHPFiles
    autocmd!
    autocmd BufEnter * call UpdateNeomakePHPCS()
    autocmd BufEnter * call UpdateNeomakePHPMD()
    autocmd BufEnter * call UpdateNeomakeCssLint()
    autocmd BufEnter * call UpdateNeomakeEsLint()
    autocmd BufEnter * call UpdateNeomakePHPStan()
augroup END

augroup DebugFiles
    autocmd!
    autocmd BufEnter,BufWritePost *.php let g:debug = system('rg "var_dump|VarDumper" ' . expand('%:T') . ' | wc -l') | call lightline#update()
    autocmd BufEnter,BufWritePost *.js  let g:debug = system('rg console.log ' . expand('%:T') . ' | wc -l') | call lightline#update()
    autocmd BufLeave *.* let g:debug = '' | call lightline#update()
augroup END

autocmd BufWritePost *.less :silent !find public/themes public/assets -name main.less | xargs touch
autocmd FileType nerdtree RainbowToggleOff
