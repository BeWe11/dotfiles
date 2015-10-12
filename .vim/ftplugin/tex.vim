" nnoremap <silent> <leader>e :BuildAndViewTexPdf<CR>
nnoremap <silent> <leader>e :!rubber --pdf Thesis && open Thesis.pdf<CR>
let g:AutoPairs = {'(':')', '[':']', '{':'}', '"':'"', '$':'$'}
set spelllang=en spell
let g:tex_comment_nospell = 1
