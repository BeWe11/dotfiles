vim.cmd [[
" fugitive mappings
nnoremap <leader>ge :Gedit<CR>
nnoremap <leader>gE :Gvsplit<CR>
nnoremap <leader>gd :Gvdiffsplit<CR>
nnoremap <leader>gD :Gvdiffsplit HEAD^<CR>
nnoremap <leader>gs :Git<CR>
nnoremap <leader>gS :Git<CR><C-w>T
nnoremap <leader>gl :silent! 0Gclog<CR>
vnoremap <leader>gb :Git blame<CR>
]]
