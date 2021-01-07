local api = vim.api
local lsp = require "lspconfig"
local virtualtypes = require "virtualtypes"
local lspfuzzy = require('lspfuzzy')
-- local lsp_status = require('lsp-status')

local M = {}

function M.setup()
  -- lsp_status.register_progress()

  lspfuzzy.setup {}

  lsp.clangd.setup {
    cmd = { "clangd-11",
            "--background-index",
            "--header-insertion=iwyu",
            "--header-insertion-decorators",
            "--suggest-missing-includes",
            "--completion-style=detailed",
           },

    -- Connect lsp-status:
    -- handlers = lsp_status.extensions.clangd.setup(),
    -- init_options = { clangdFileStatus = true },
    -- on_attach = lsp_status.on_attach,
    -- capabilities = lsp_status.capabilities
  }

  if vim.fn.executable('pyls') then
    lsp.pyls.setup { }
  end

  if vim.fn.executable('rls') then
    lsp.rls.setup { }
  end

  if vim.fn.executable('ocamllsp') then
    lsp.ocamllsp.setup { on_attach=virtualtypes.on_attach }
  end

  if vim.fn.executable('gopls') then
    lsp.gopls.setup { }
  end

  vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
      underline = true,
      virtual_text=false,
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

    nnoremap ]e <cmd>lua vim.lsp.diagnostic.goto_next()<CR>
    nnoremap [e <cmd>lua vim.lsp.diagnostic.goto_prev()<CR>
    nnoremap <silent> <localleader>d <cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>
    ]], '')
end

return M
