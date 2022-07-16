vim.cmd [[
"------------------------------------------------------------------------------"
"----- todo setup, refer to https://www.python.org/dev/peps/pep-0350/ ---------"
"------------------------------------------------------------------------------"
let s:codetags = 'FIXME\|BUG\|NOBUG\|HACK\|NOTE\|IDEA\|TODO\|XXX'

" Make vim highlight the code tags in every file
augroup HiglightTodo
    autocmd!
    autocmd WinEnter,VimEnter * :silent! call matchadd('Todo', s:codetags, -1)
augroup END

command! -nargs=1 -bang Ack exec 'AsyncRun' . '<bang>' . ' ack ' . <f-args>
command! -nargs=1 -bang Grep exec 'AsyncRun' . '<bang>' . ' grep ' . <f-args>

function! ListTodo(current)
    if a:current
        " Using async search for one file would be overkill, just use vimgrep
        exec 'silent! vimgrep /' . s:codetags . '/j ' . @%
        if len(filter(getqflist(), 'v:val.valid')) == 0
            echo 'Nothing found.'
            return
        endif
    else
        " FIXME: AsyncRun inserts a start and a finish line, try to remove
        " those, while having another way to determine whether it finished
        if executable('ack')
            exec 'Ack! --ignore-file=is:DONE --ignore-file=ext:ipynb --ignore-dir=.ipynb_checkpoints ' . s:codetags . ' ' . ProjectRootGuess()
        else
            exec 'Grep! -nIr --exclude=DONE --exclude="*.ipynb" --exclude-dir=.git --exclude-dir=.ipynb_checkpoints "' . s:codetags . '" ' . ProjectRootGuess() . '/*'
        endif
    endif
    botright copen 8
endfunction

function! s:write_line(line, path)
    new
    setlocal buftype=nofile bufhidden=hide noswapfile nobuflisted
    exec 'normal! a' . a:line . "\<ESC>"
    exec 'w >>' a:path
    bd
endfunction

function! FinishTodo() range
    let path = ProjectRootGuess() . '/DONE'
    if filewritable(path)
        for linenumber in range(a:firstline, a:lastline)
            let line = getline(linenumber)
            call s:write_line(line, path)
            exec linenumber . 'd _'
        endfor
        call s:write_line('[' . strftime('%Y-%m-%d') . ']' . "\n", path)
        exec a:firstline
    else
        echo 'No DONE file in root directory'
    endif
endfunction


function! MakeNoEnter()
    " Set cmdheigt two 2 and reset to 1 to avoid the "Press Enter" screen
    set cmdheight=2
    make
    if len(filter(getqflist(), 'v:val.valid')) > 1
        botright cw 8
    endif
    set cmdheight=1
endfunction

"nnoremap <leader>tt :call ListTodo(0)<CR>
"nnoremap <leader>tc :call ListTodo(1)<CR>
"nnoremap <leader>td :call FinishTodo()<CR>
"vnoremap <leader>td :call FinishTodo()<CR>
]]
