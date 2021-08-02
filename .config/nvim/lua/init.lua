local lsp = require('lspconfig')
local virtualtypes = require('virtualtypes')
local lspfuzzy = require('lspfuzzy')

local M = {}

function M.setup()

  -- {{{ mdeval.nvim
  require('mdeval').setup({
    require_confirmation = false,
    exec_timeout = 5,
    eval_options = {
      cpp = {
        default_header = [[
#include <iostream>
#include <vector>
using namespace std;
        ]],
        command = {"clang++", "-std=c++20", "-O0"},
      },
      racket = {
        command = {"racket"},
        language_code = "racket",
        exec_type = "interpreted",
        extension = "rkt",
      },
    }
  })
  vim.api.nvim_set_keymap('n', '<localleader>c',
                          "<cmd>lua require 'mdeval'.eval_code_block()<CR>",
                          {silent = true, noremap = true})
  -- }}}

  -- {{{ hop.nvim
  vim.api.nvim_set_keymap('n', '<leader>q', "<cmd>lua require'hop'.hint_words()<cr>", {})
  -- }}}

  -- {{{ nvim-colorizer.nvim
  -- Attach to certain Filetypes, add special configuration for `html`
  -- Use `background` for everything else.
  require'colorizer'.setup {
    'css',
    'javascript',
    'html',
    'markdown',
    'conf',
    'plantuml',
  }

  require 'colorizer'.setup {
    '*';
    markdown = { names = false };
    css = { rgb_fn = true; }; -- Enable parsing rgb(...) functions in css.
  }
  -- }}}

  -- {{{ Built-in LSP client
  -- General LSP options
  vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
      underline = true,
      virtual_text=false,
      update_in_insert = false,
    }
  )

  -- Use fzf to display LSP results and navigate the code.
  lspfuzzy.setup {}

  -- Register lsp-status
  -- lsp_status.register_progress()

  if vim.fn.executable('clangd-11') then
    lsp.clangd.setup {
      cmd = { "clangd-11",
              "--background-index",
              "--header-insertion=iwyu",
              "--header-insertion-decorators",
              "--suggest-missing-includes",
              "--completion-style=detailed",
              "--clang-tidy",
             },
      -- Connect lsp-status:
      -- handlers = lsp_status.extensions.clangd.setup(),
      -- init_options = { clangdFileStatus = true },
      -- on_attach = lsp_status.on_attach,
      -- capabilities = lsp_status.capabilities
    }
  end

  if vim.fn.executable('pylsp') then
    lsp.pylsp.setup { }
  end

  if vim.fn.executable('ocamllsp') then
    lsp.ocamllsp.setup { on_attach=virtualtypes.on_attach }
  end

  -- Keybindings
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
  -- }}}
end

return M

-- vim:fdm=marker:fen:sw=2:tw=120
