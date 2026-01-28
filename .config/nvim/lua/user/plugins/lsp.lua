-- lua/user/plugins/lsp.lua
-- LSP configuration

local virtualtypes = require('virtualtypes')

-- General LSP options
vim.diagnostic.config({
  underline = true,
  virtual_text = false,
  update_in_insert = false,
})

-- Enables LSP server if its `executable` is present and the current directory not in `forbidden_directories`
local enable_if = function(executable, forbidden_directories)
  if not vim.fn.executable(executable) then
    return false
  end

  if forbidden_directories then
    local current_directory = vim.fn.getcwd()
    local basename = vim.fn.fnamemodify(current_directory, ':t')
    for _, value in ipairs(forbidden_directories) do
      if value == basename then
        return false
      end
    end
  end

  return true
end

-- clangd
if enable_if('clangd', { 'llvm-project' }) then
  vim.lsp.config.clangd = {
    cmd = {
      'clangd',
      '--background-index',
      '--header-insertion=iwyu',
      '--header-insertion-decorators',
      '--suggest-missing-includes',
      '--completion-style=detailed',
      '--clang-tidy',
    },
  }
  vim.lsp.enable('clangd')
end

-- Python LSP
if enable_if('pylsp') then
  vim.lsp.enable('pylsp')
end

-- Go LSP
if enable_if('gopls') then
  vim.lsp.enable('gopls')
end

-- Rust Analyzer
if enable_if('rust-analyzer', { 'rust', 'solang', 'reqwest' }) then
  vim.lsp.config.rust_analyzer = {
    settings = {
      ['rust-analyzer'] = {
        checkOnSave = {
          command = 'clippy',
        },
        assist = {
          importGranularity = 'module',
          importPrefix = 'by_self',
        },
        cargo = {
          loadOutDirsFromCheck = true,
        },
        procMacro = {
          enable = true,
        },
      },
    },
  }
  vim.lsp.enable('rust_analyzer')
end

-- OCaml LSP
if enable_if('ocamllsp') then
  vim.lsp.config.ocamllsp = {
    on_attach = virtualtypes.on_attach,
  }
  vim.lsp.enable('ocamllsp')
end

-- TypeScript LSP
if enable_if('typescript-language-server') then
  vim.lsp.enable('ts_ls')
end

-- Symbols Outline
require('symbols-outline').setup()

-- Fidget (LSP progress UI)
require('fidget').setup({})
