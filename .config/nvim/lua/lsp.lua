local api = vim.api
local lsp = require "lspconfig"
local virtualtypes = require "virtualtypes"

local M = {}

function M.setup()
  lsp.clangd.setup {
    cmd = { "clangd-11", "--background-index" }
  }
  lsp.pyls.setup     { }
  -- lsp.gopls.setup    { }
  lsp.rls.setup      { }
  lsp.ocamllsp.setup { on_attach=virtualtypes.on_attach }

  vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
      -- Enable underline, use default values
      underline = true,
      -- Disable virtual text
      virtual_text=false,
      -- Don't update while in insert mode
      update_in_insert = false,
    }
  )

  vim.api.nvim_exec([[
    nnoremap <silent> gl             <cmd>lua vim.lsp.buf.declaration()<CR>
    nnoremap <silent> gd             <cmd>lua vim.lsp.buf.definition()<CR>
    nnoremap <silent> gr             <cmd>lua vim.lsp.buf.references()<CR>
    nnoremap <silent> gi             <cmd>lua vim.lsp.buf.implementation()<CR>
    nnoremap <silent> gy             <cmd>lua vim.lsp.buf.type_definition()<CR>

    nnoremap <silent> gh <cmd>lua vim.lsp.buf.hover()<CR>

    nnoremap <silent> <localleader>a <cmd>lua vim.lsp.buf.code_action()<CR>
    nnoremap <silent> <localleader>r <cmd>lua vim.lsp.buf.rename()<CR>

    nnoremap <buffer>]e <cmd>lua vim.lsp.diagnostic.goto_next()<CR>
    nnoremap <buffer>[e <cmd>lua vim.lsp.diagnostic.goto_prev()<CR>
    nnoremap <silent> <localleader>d <cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>
    ]], '')
end

return M
