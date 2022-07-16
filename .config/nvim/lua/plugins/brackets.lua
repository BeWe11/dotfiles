vim.cmd [[
" Activate rainbow parantheses
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces

" AutoPair Settings
let g:AutoPairsMultilineClose = 0

" vim-closetag settings
let g:closetag_filenames = '*.html,*.xhtml,*.phtml,*.vue'

function! s:init()
    nmap [q <Plug>unimpairedQPreviouszz
    nmap ]q <Plug>unimpairedQNextzz
endfunction
augroup vimrc_enter
    au!
    au VimEnter * call s:init()
augroup END
]]
