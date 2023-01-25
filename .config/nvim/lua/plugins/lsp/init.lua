local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
require'lspconfig'.tsserver.setup{capabilities=capabilities}
require'lspconfig'.vuels.setup{capabilities=capabilities}
require'lspconfig'.pyright.setup{
  capabilities = capabilities;
  settings = {
    python = {
      analysis = {
        autoSearchPaths = false,
        autoImportCompletions = false,
        completeFunctionParens = true,
        typeCheckingMode = "off"
      }
    }
  }
}

require'lspconfig'.efm.setup{
    filetypes = {"python"};
    capabilities = capabilities;
}

require("plugins/lsp/definition_in_tab_callbacks")

vim.cmd[[
nnoremap <silent> gd        <cmd> lua vim.lsp.buf.definition()<CR>
nnoremap <silent> K         <cmd> lua vim.lsp.buf.hover()<CR>
nnoremap <silent> <leader>r <cmd> lua vim.lsp.buf.rename()<CR>
nnoremap <silent> <c-]>     <cmd> lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> <c-k>     <cmd> lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> 1gD       <cmd> lua vim.lsp.buf.type_definition()<CR>
nnoremap <silent> gr        <cmd> lua vim.lsp.buf.references()<CR>
nnoremap <silent> g0        <cmd> lua vim.lsp.buf.document_symbol()<CR>
nnoremap <silent> gW        <cmd> lua vim.lsp.buf.workspace_symbol()<CR>
nnoremap <silent> gD        <cmd> lua vim.lsp.buf.declaration()<CR>
]]
