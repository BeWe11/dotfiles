vim.diagnostic.config({
  virtual_text = false,
  signs = true,
  update_in_insert = false,
})

vim.cmd [[
set updatetime=750

" Set completeopt to have a better completion experience
set completeopt=menu,menuone,noselect

call sign_define("DiagnosticSignError", {"text" : "", "texthl" : "DiagnosticSignError"})
call sign_define("DiagnosticSignWarn", {"text" : "", "texthl" : "DiagnosticSignWarn"})
call sign_define("DiagnosticSignInfo", {"text" : "", "texthl" : "DiagnosticSignInfo"})
call sign_define("DiagnosticSignHint", {"text" : "", "texthl" : "DiagnosticSignHint"})
autocmd CursorHold * lua vim.diagnostic.open_float(nil, {focus = false})
set signcolumn=yes

function OpenDiagnostics()
    lua vim.diagnostic.setloclist()
endfunction
nnoremap <leader>D :call OpenDiagnostics()<CR>
nnoremap ]d <cmd>lua vim.diagnostic.goto_next()<CR>
nnoremap [d <cmd>lua vim.diagnostic.goto_prev()<CR>
]]
