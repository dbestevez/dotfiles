autocmd VimEnter * call StartUp()
autocmd VimEnter * wincmd p
autocmd VimEnter * call UpdateNeomakePHPCS()
autocmd VimEnter * call UpdateNeomakePHPMD()
autocmd VimEnter * call UpdateNeomakeCssLint()
autocmd VimEnter * call UpdateNeomakeEsLint()
autocmd VimLeave * set guicursor=a:block-Cursor-blinkon100

autocmd BufWritePre * :call Preserve(":call TrimWhiteSpaces()")

autocmd User NeomakeFinished call lightline#update()

autocmd BufEnter,BufWritePost *.php let g:debug = system('rg "var_dump|VarDumper" ' . expand('%:T') . ' | wc -l') | call lightline#update()
autocmd BufEnter,BufWritePost *.js  let g:debug = system('rg console.log ' . expand('%:T') . ' | wc -l') | call lightline#update()
autocmd BufLeave *.* let g:debug = '' | call lightline#update()
autocmd BufWritePost *.less :silent !find public/themes public/assets -name main.less | xargs touch
