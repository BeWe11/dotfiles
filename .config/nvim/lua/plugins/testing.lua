vim.cmd [[
let test#strategy = {
  \ 'nearest': 'neovim',
  \ 'file':    'basic',
  \ 'suite':   'basic',
\}
let g:test#neovim#start_normal = 1
let g:test#basic#start_normal = 1
let test#neovim#term_position = "bel"
let test#python#pytest#options = '-v'

nmap <silent> <leader>tt :TestNearest<CR>
nmap <silent> <leader>tT :TestFile<CR>
nmap <silent> <leader>ta :TestSuite<CR>
nmap <silent> <leader>tl :TestLast<CR>
nmap <silent> <leader>tg :TestVisit<CR>
]]
