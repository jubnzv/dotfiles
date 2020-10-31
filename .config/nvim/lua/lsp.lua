local api = vim.api
local lsp = require "nvim_lsp"
local lsp_configs = require "nvim_lsp/configs"
local diagnostic = require "diagnostic"
local virtualtypes = require "virtualtypes"

local M = {}

-- F# configuration
lsp_configs.fsharp = {
  default_config = {
    cmd = {"/home/jubnzv/Sources/fsharp-language-server/src/FSharpLanguageServer/bin/Release/netcoreapp3.0/FSharpLanguageServer"};
    filetypes = {"fsharp"};
    root_dir = lsp.util.root_pattern("*.fsproj", ".git");
  };
}

function M.setup()
  lsp.clangd.setup {
    on_attach=diagnostic.on_attach,
    cmd = { "clangd-11", "--background-index" }
  }
  lsp.pyls.setup     { on_attach=diagnostic.on_attach }
  lsp.gopls.setup    { on_attach=diagnostic.on_attach }
  lsp.rls.setup      { on_attach=diagnostic.on_attach }
  lsp.fsharp.setup   { on_attach=diagnostic.on_attach }
  lsp.ocamllsp.setup {
      on_attach=(function()
          diagnostic.on_attach()
          virtualtypes.on_attach()
      end)
  }

  vim.api.nvim_exec([[
    nnoremap <silent> gl             <cmd>lua vim.lsp.buf.declaration()<CR>
    nnoremap <silent> gd             <cmd>lua vim.lsp.buf.definition()<CR>
    nnoremap <silent> gr             <cmd>lua vim.lsp.buf.references()<CR>
    nnoremap <silent> gi             <cmd>lua vim.lsp.buf.implementation()<CR>
    nnoremap <silent> gy             <cmd>lua vim.lsp.buf.type_definition()<CR>

    nnoremap <silent> gh <cmd>lua vim.lsp.buf.hover()<CR>

    nnoremap <silent> <localleader>a <cmd>lua vim.lsp.buf.code_action()<CR>
    nnoremap <silent> <localleader>r <cmd>lua vim.lsp.buf.rename()<CR>
    nnoremap <silent> <localleader>d <cmd>lua vim.lsp.util.show_line_diagnostics()<CR>
    ]], '')
end

return M
