function! CtrlPStatusMain(focus, byfname, regex, prev, item, next, marked)
    let g:lightline.ctrlp_regex = a:regex
    let g:lightline.ctrlp_prev = a:prev
    let g:lightline.ctrlp_item = a:item
    let g:lightline.ctrlp_next = a:next
    return lightline#statusline(0)
endfunction

function! CtrlPStatusProg(str)
    return lightline#statusline(0)
endfunction

function! GoyoEnter()
  set noshowmode
  set noshowcmd
  set scrolloff=999
  call lightline#disable()
  Limelight
endfunction

function! GoyoLeave()
  set showmode
  set showcmd
  set scrolloff=5
  call lightline#enable()
  Limelight!
endfunction

function! LightlineCtrlP()
    if expand('%:t') =~ 'ControlP'
        call lightline#link('iR'[g:lightline.ctrlp_regex])
        return lightline#concatenate([g:lightline.ctrlp_prev, g:lightline.ctrlp_item
                    \ , g:lightline.ctrlp_next], 0)
    else
        return ''
    endif
endfunction

function! LightlineDebug()
    if g:debug != 0
        return 'D:' . substitute(g:debug, "\n", "", "")
    endif

    return ''
endfunction

function! LightlineFileEncoding()
    return winwidth(0) > 83 ? (strlen(&fenc) ? &fenc : &enc) : ''
endfunction

function! LightlineFileFormat()
    return winwidth(0) > 80 ? &fileformat . ' ' . WebDevIconsGetFileFormatSymbol() : ''
endfunction

function! LightlineFileName()
    let sname = expand('%:t')
    let fname = expand('%:T')
    return fname == 'ControlP' ? g:lightline.ctrlp_item :
        \ fname == '__Tagbar__' ? g:lightline.fname :
        \ fname =~ '__Gundo\' ? '' :
        \ fname =~ 'NERD_tree' ? 'NERDTree' :
        \ &ft == 'vimfiler' ? vimfiler#get_status_string() :
        \ &ft == 'unite' ? unite#get_status_string() :
        \ &ft == 'vimshell' ? vimshell#get_status_string() :
        \ WebDevIconsGetFileTypeSymbol() . ' ' .
        \ ('' != fname ? (winwidth(0) > 100 ? fname : sname) : '[No Name]') .
        \ ('' != LightlineReadonly() ? ' ' . LightlineReadonly() : '') .
        \ ('' != LightlineModified() ? ' ' . LightlineModified() : '')
endfunction

function! LightlineFileType()
    return winwidth(0) > 60 ? (strlen(&filetype) ? &filetype : 'no ft') : ''
endfunction

function! LightlineFugitive()
    try
        if expand('%:t') !~? 'Tagbar\|Gundo\|NERD' && &ft !~? 'vimfiler' && exists('*fugitive#head')
            let mark = ' '  " edit here for cool mark
            let _ = fugitive#head()
            return strlen(_) ? mark._ : ''
        endif
    catch
    endtry

    return ''
endfunction

function! LightlineMode()
    let fname = expand('%:t')
    let mode  = lightline#mode()

    return fname == '__Tagbar__' ? 'Tagbar' :
        \ fname == 'ControlP' ? 'CtrlP' :
        \ fname == '__Gundo__' ? 'Gundo' :
        \ fname == '__Gundo_Preview__' ? 'Gundo Preview' :
        \ fname =~ 'NERD_tree' ? '' :
        \ &ft == 'unite' ? 'Unite' :
        \ &ft == 'vimfiler' ? 'VimFiler' :
        \ &ft == 'vimshell' ? 'VimShell' :
        \ ''
endfunction

function! LightlineModified()
    return &ft =~ 'help' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! LightlineReadonly()
    return &ft !~? 'help' && &readonly ? '' : ''
endfunction

function! LightlineNeomake()
    return neomake#statusline#LoclistStatus()
endfunction

" Called once right before you start selecting multiple cursors
function! Multiple_cursors_before()
    call keepcursor#disable()
endfunction

" Called once only when the multiple selection is canceled (default <Esc>)
function! Multiple_cursors_after()
    call keepcursor#enable()
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

" Opens NERDTree on stat up when no arguments
function! StartUp()
    if 0 == argc()
        NERDTree
    end
endfunction

" Removes whitespaces at the end of the line
function! TrimWhiteSpaces()
    " Ignore vmail buffer list
    if &filetype == 'vmailMessageList'
        return
    endif

    %s/\s\+$//e
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

" Zooms in/out the current split
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

function! s:find_jshintrc(dir)
    let l:found = globpath(a:dir, '.jshintrc')
    if filereadable(l:found)
        return l:found
    endif

    let l:parent = fnamemodify(a:dir, ':h')
    if l:parent != a:dir
        return s:find_jshintrc(l:parent)
    endif

    return "~/.jshintrc"
endfunction

function! s:find_phpcs_xml(dir)
    let l:found = globpath(a:dir, 'phpcs.xml')
    if filereadable(l:found)
        return l:found
    endif

    let l:parent = fnamemodify(a:dir, ':h')
    if l:parent != a:dir
        return s:find_phpcs_xml(l:parent)
    endif

    return "PSR2"
endfunction

function! UpdateNeomakeJsHint()
    let l:dir = expand('%:p:h')
    let l:jshintrc = s:find_jshintrc(l:dir)
    call add(g:neomake_javascript_jshint_maker.args, '--config=' . l:jshintrc)
endfunction

function! UpdateNeomakePHPCS()
    let l:dir = expand('%:p:h')
    let l:phpcs_xml = s:find_phpcs_xml(l:dir)
    call add(g:neomake_php_phpcs_maker.args, '--standard=' . l:phpcs_xml)
endfunction