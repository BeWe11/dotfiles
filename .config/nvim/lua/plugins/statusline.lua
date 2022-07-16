vim.cmd [[
" Vim-Airline settings
function! LspStatus() abort
    if luaeval('#vim.lsp.buf_get_clients() > 0')
        return luaeval("require('lsp-status').status()")
    endif
    return ''
endfunction
let g:airline_powerline_fonts = 1
call airline#parts#define_function('lsp', 'LspStatus')
let g:airline_section_y = airline#section#create_right(['ffenc', 'lsp'])
]]
