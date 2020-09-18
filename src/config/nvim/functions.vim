" CtrlP
function! CtrlPStatusMain(focus, byfname, regex, prev, item, next, marked)
    let g:lightline.ctrlp_regex = a:regex
    let g:lightline.ctrlp_prev  = a:prev
    let g:lightline.ctrlp_item  = a:item
    let g:lightline.ctrlp_next  = a:next
    return lightline#statusline(0)
endfunction

function! CtrlPStatusProg(str)
    return lightline#statusline(0)
endfunction

" Goyo
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

" Lightline
function! LightlineCtrlP()
    if expand('%:t') =~ 'ControlP'
        call lightline#link('iR'[g:lightline.ctrlp_regex])
        return lightline#concatenate([ g:lightline.ctrlp_prev,
                    \ g:lightline.ctrlp_item, g:lightline.ctrlp_next ], 0)
    else
        return ''
    endif
endfunction

function! LightlineCtrlPItem()
    if expand('%:t') =~ 'ControlP'
        call lightline#link('iR'[g:lightline.ctrlp_regex])
        return g:lightline.ctrlp_item
    else
        return ''
    endif
endfunction

function! LightlineCtrlPNext()
    if expand('%:t') =~ 'ControlP'
        call lightline#link('iR'[g:lightline.ctrlp_regex])
        return lightline#concatenate([ '',  g:lightline.ctrlp_next ], 0)
    else
        return ''
    endif
endfunction

function! LightlineCtrlPPrev()
    if expand('%:t') =~ 'ControlP'
        call lightline#link('iR'[g:lightline.ctrlp_regex])
        return g:lightline.ctrlp_prev . ' '
    else
        return ''
    endif
endfunction

function! LightlineDebug()
    if g:debug != 0
        return ' ' . substitute(g:debug, "\n", "", "")
    endif

    return ''
endfunction

function! LightlineFileName()
    let sname = expand('%:t')
    let fname = expand('%:T')
    return fname == 'ControlP' ? '' :
        \ fname =~ 'NERD_tree' ? '' :
        \ WebDevIconsGetFileTypeSymbol() . ' ' .
        \ ('' != fname ? (winwidth(0) > 100 ? fname : sname) : '[No Name]') .
        \ ('' != LightlineReadonly() ? ' ' . LightlineReadonly() : '') .
        \ ('' != LightlineModified() ? ' ' . LightlineModified() : '')
endfunction

function! LightlineFugitive()
    try
        if expand('%:t') !~? 'ControlP\|NERD' && &ft !~? 'vimfiler'
            let mark = ' '  " edit here for cool mark
            let branch = fugitive#head()
            return strlen(branch) ? mark . branch : ''
        endif
    catch
    endtry

    return ''
endfunction

function! LightlineMode()
    let fname = expand('%:t')
    let mode  = lightline#mode()

    return fname == '__Tagbar__'        ? '' :
        \ fname  == 'ControlP'          ? '' :
        \ fname  == '__Gundo__'         ? '' :
        \ fname  == '__Gundo_Preview__' ? '' :
        \ fname  =~ 'NERD_tree'         ? 'פּ' :
        \ mode   == 'COMMAND'           ? '' :
        \ mode   == 'INSERT'            ? '' :
        \ mode   == 'REPLACE'           ? '' :
        \ mode   == 'NORMAL'            ? '' :
        \ mode   == 'VISUAL'            ? '' :
        \ mode   == 'V-BLOCK'           ? '' : mode
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

function! LightlineNeomakeErrors()
    return substitute(
        \ substitute(neomake#statusline#LoclistStatus(), 'W:.*', '', ''),
        \ 'E:\([0-9]\+\).*',
        \ ' \1',
        \ ''
    \ )
endfunction

function! LightlineNeomakeWarnings()
    return substitute(
        \ substitute(neomake#statusline#LoclistStatus(), 'E:\([0-9]\+\)', '', ''),
        \ '.*W:\([0-9]\+\)',
        \ ' \1',
        \ ''
    \ )
endfunction

function! LightlinePaste()
    return &paste != 0 ? '' : ''
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
    if &filetype == 'vmailMessageList' || &filetype == 'mail'
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

function! s:find_file(dir, file, default)
    let l:found = globpath(a:dir, a:file)
    if filereadable(l:found)
        return l:found
    endif

    let l:parent = fnamemodify(a:dir, ':h')
    if l:parent != a:dir
        return s:find_file(l:parent, a:file, a:default)
    endif

    return a:default
endfunction

function! UpdateNeomakeCssLint()
    let l:dir = expand('%:p:h')
    let l:jshintrc = s:find_file(l:dir, '.csslintrc', '~/.csslintrc')
    call add(g:neomake_css_csslint_maker.args, '--config=' . l:jshintrc)
endfunction

function! UpdateNeomakeEsLint()
    let l:dir = expand('%:p:h')
    let l:eslintrc = s:find_file(l:dir, '.eslintrc', '~/.eslintrc')
    call add(g:neomake_javascript_eslint_maker.args, '--config=' . l:eslintrc)
endfunction

function! UpdateNeomakePHPCS()
    let l:dir = expand('%:p:h')
    let l:phpcs_xml = s:find_file(l:dir, 'phpcs.xml', 'PSR2')
    call add(g:neomake_php_phpcs_maker.args, '--standard=' . l:phpcs_xml)
endfunction

function! UpdateNeomakePHPMD()
    let l:dir = expand('%:p:h')
    let l:phpmd_xml = s:find_file(l:dir, 'phpmd.xml', 'codesize,design,unusedcode,naming')
    call add(g:neomake_php_phpmd_maker.args, l:phpmd_xml)
endfunction

" Get an age weighted by generation distribution
call fake#define('age', 'float2nr(floor(110 * fake#betapdf(1.0, 1.45)))')

call fake#define('domain', 'tolower(substitute(printf("%s.%s",'
    \ . 'fake#gen("surname"),'
    \ . 'fake#gen("tld")), "\\s", "-", "g"))')

call fake#define('email', 'tolower(substitute(printf("%s@%s.%s",'
    \ . 'fake#gen("name"),'
    \ . 'fake#gen("surname"),'
    \ . 'fake#gen("tld")), "\\s", "-", "g"))')

" Get a full name
call fake#define('fullname', 'fake#gen("name") . " " . fake#gen("surname")')

" Choose a random element from a list
call fake#define('sex', 'fake#choice(["male", "female"])')

" Get a name of male or female
call fake#define('name', 'fake#int(1) ? fake#gen("male_name")'
  \ . ' : fake#gen("female_name")')

call fake#define('paragraph', 'join(map(range(fake#int(3,10)),"fake#gen(\"sentence\")"))')

" Get a nonsense text like Lorem ipsum
call fake#define('sentence', 'fake#capitalize('
    \ . 'join(map(range(fake#int(3,15)),"fake#gen(\"nonsense\")"))'
    \ . ' . fake#chars(1,"..............!?"))')

call fake#define('text', 'join(map(range(fake#int(3,6)),"fake#gen(\"paragraph\")"), "--")')

" Get a TLD (ordered by number of websites)
call fake#define('tld', 'fake#get(fake#load("gtld"),'
    \ . 'fake#betapdf(0.2, 3.0))')
