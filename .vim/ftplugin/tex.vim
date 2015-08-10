" nnoremap <silent> <leader>e :BuildAndViewTexPdf<CR>
nnoremap <silent> <leader>e :!rubber --pdf --into=../ Thesis && evince Thesis.pdf<CR>
let g:AutoPairs = {'(':')', '[':']', '{':'}',"'":"'",'"':'"', '`':'`', '$':'$'}
