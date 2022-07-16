vim.cmd [[
" Neoformat options
let g:neoformat_python_black = {
                \ 'exe': 'black',
                \ 'stdin': 1,
                \ 'args': ['-q', '-'],
                \ }
let g:neoformat_enabled_python = ['isort', 'black']
let g:neoformat_enabled_javascript = ['prettier']
let g:neoformat_enabled_typescript = ['prettier']
let g:neoformat_enabled_html = ['prettier']
let g:neoformat_htmldjango_jsbeautify = {
            \ 'exe': 'js-beautify',
            \ 'args': [
            \    '--type html',
            \    '--indent-size 2',
            \    '--templating django',
            \],
            \ 'stdin': 1,
            \ }
let g:neoformat_enabled_htmldjango = ['jsbeautify']
let g:neoformat_cpp_clangformat = {
            \ 'exe': 'clang-format',
            \ 'args': ['-assume-filename=file.cpp', '-style=google'],
            \ 'stdin': 1,
            \ }
" XXX: This format command does not work reliably right now
let g:neoformat_enabled_sql = ['sqlfluff']
let g:neoformat_sql_sqlfluff = {
            \ 'exe': 'sqlfluff',
            \ 'args': ['fix', '--force', '--nocolor', '-'],
            \ 'stdin': 1,
            \ }
let g:neoformat_run_all_formatters = 1

function! FormatFile()
    let save_pos = getpos(".")
    exec 'Neoformat'
    call setpos('.', save_pos)
endfunction
nnoremap <leader>F :call FormatFile()<CR>

nnoremap <leader>ae :Tab /=<CR>
nnoremap <leader>ac y :Tab /<C-R>"<CR>
xnoremap <leader>ac y :Tab /<C-R>"<CR>
xnoremap <leader>ae :Tab /=<CR>
]]
