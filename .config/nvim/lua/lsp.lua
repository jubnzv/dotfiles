local api = vim.api
local diagnostic = require "diagnostic"
local virtualtypes = require "virtualtypes"
local M = {}

function on_attach_ocaml()
  diagnostic.on_attach()
  virtualtypes.on_attach()
end

function M.setup()
  require'nvim_lsp'.clangd.setup{
    on_attach=diagnostic.on_attach,
    cmd = { "clangd-10", "--background-index" }
  }
  require'nvim_lsp'.pyls.setup{
    on_attach=diagnostic.on_attach
  }
  require'nvim_lsp'.gopls.setup{
    on_attach=diagnostic.on_attach
  }

  require'nvim_lsp'.ocamllsp.setup{
    on_attach=on_attach_ocaml
  }

  vim.api.nvim_exec([[
    nnoremap <silent> gl             <cmd>lua vim.lsp.buf.declaration()<CR>
    nnoremap <silent> gd             <cmd>lua vim.lsp.buf.definition()<CR>
    nnoremap <silent> gr             <cmd>lua vim.lsp.buf.references()<CR>
    nnoremap <silent> gi             <cmd>lua vim.lsp.buf.implementation()<CR>
    nnoremap <silent> gy             <cmd>lua vim.lsp.buf.type_definition()<CR>

    nnoremap <silent> <localleader>a <cmd>lua vim.lsp.buf.code_action()<CR>
    nnoremap <silent> <localleader>k <cmd>lua vim.lsp.buf.hover()<CR>
    nnoremap <silent> <localleader>r <cmd>lua vim.lsp.buf.rename()<CR>
    nnoremap <silent> <localleader>d <cmd>lua vim.lsp.util.show_line_diagnostics()<CR>
    ]], '')
end

return M
