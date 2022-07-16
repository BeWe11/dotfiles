vim.cmd [[
" use ripgrep instead of ag in fzf
command! -bang -nargs=* Find
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview({'options': '--delimiter : --nth 4.. --exact'}, 'right:50%')
  \           : fzf#vim#with_preview({'options': '--delimiter : --nth 4.. --exact'}, 'right:50%:hidden', '?'),
  \   <bang>0)

" Redefine fzf functions to use preview windows in vertical split when
" fullscreen ist activated
command! -bang -nargs=? -complete=dir Files
  \ call fzf#vim#files(
  \   <q-args>,
  \   <bang>0 ? fzf#vim#with_preview('right:50%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)

command! -bang -nargs=? -complete=dir GFiles
  \ call fzf#vim#gitfiles(
  \   <q-args>,
  \   <bang>0 ? fzf#vim#with_preview('right:50%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)

" Override fzf commit commands to make more space for side-by-side diffs
command! -bar -bang -range=% Commits let b:fzf_winview = winsaveview() | <line1>,<line2>call fzf#vim#commits(fzf#vim#with_preview({ "placeholder": "", 'options': '--preview-window=right,70%' }), <bang>0)
command! -bar -bang -range=% BCommits let b:fzf_winview = winsaveview() | <line1>,<line2>call fzf#vim#buffer_commits(fzf#vim#with_preview({ "placeholder": "", 'options': '--preview-window=right,70%' }), <bang>0)

" FZF mappings
nnoremap <leader>ff :Files<CR>
nnoremap <leader>fF :Files!<CR>
nnoremap <leader>fgf :GFiles<CR>
nnoremap <leader>fgF :GFiles!<CR>
nnoremap <leader>fbb :Buffers<CR>
nnoremap <leader>fbB :Buffers!<CR>
nnoremap <leader>fi :Find<CR>
nnoremap <leader>fI :Find!<CR>
nnoremap <leader>fc :Commits<CR>
nnoremap <leader>fC :Commits!<CR>
noremap <leader>fl :BCommits<CR>
noremap <leader>fL :BCommits!<CR>
vnoremap <leader>fi y :Find <C-R>"<CR>
vnoremap <leader>fI y :Find! <C-R>"<CR>
nnoremap <leader>fn :NvimTreeToggle<CR>
]]
