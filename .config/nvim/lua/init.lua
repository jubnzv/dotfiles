local M = {}

function M.setup_telescope()
  local telescope = require'telescope'

  telescope.load_extension('project')

  vim.api.nvim_exec([[
    nnoremap <A-p>      <cmd>lua require('telescope.builtin').find_files()<cr>
    nnoremap <leader>fs <cmd>lua require('telescope.builtin').live_grep()<cr>
    nnoremap <leader>b  <cmd>lua require('telescope.builtin').buffers()<cr>
    nnoremap <leader>fo <cmd>lua require('telescope.builtin').oldfiles()<cr>
    nnoremap <leader>fm <cmd>lua require('telescope.builtin').marks()<cr>

    nnoremap <leader>fp <cmd>lua require'telescope'.extensions.project.project{}<cr>

    nnoremap <A-u> <cmd>lua require('telescope.builtin').spell_suggest()<cr>

    nnoremap gr <cmd>lua require('telescope.builtin').lsp_references()<cr>
    nnoremap gs <cmd>lua require('telescope.builtin').lsp_document_symbols()<cr>
    nnoremap gd <cmd>lua require('telescope.builtin').lsp_definitions()<cr>
    nnoremap gi <cmd>lua require('telescope.builtin').lsp_implementations()<cr>
    nnoremap <localleader>a <cmd>lua require('telescope.builtin').lsp_code_actions()<cr>

    nnoremap <localleader>vc <cmd>lua require('telescope.builtin').git_commits()<cr>
    nnoremap <localleader>vC <cmd>lua require('telescope.builtin').git_bcommits()<cr>
    nnoremap <localleader>vB <cmd>lua require('telescope.builtin').git_branches()<cr>
    nnoremap <localleader>vS <cmd>lua require('telescope.builtin').git_stash()<cr>
  ]], '')
end

function M.setup_mdeval()
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
end

function M.setup_colorizer()
  require'colorizer'.setup {
    'yml',
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
end

function M.setup_lsp()
  local lsp = require('lspconfig')
  local virtualtypes = require('virtualtypes')

  -- General LSP options
  vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
      underline = true,
      virtual_text=false,
      update_in_insert = false,
    }
  )

  -- Register lsp-status
  -- lsp_status.register_progress()

  if vim.fn.executable('clangd') then
    lsp.clangd.setup {
      cmd = { "clangd",
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

  if vim.fn.executable('gopls') then
    lsp.gopls.setup { }
  end

  if vim.fn.executable('rust-analyzer') then
    lsp.rust_analyzer.setup({
      on_attach=on_attach,
      settings = {
        ["rust-analyzer"] = {
          assist = {
            importGranularity = "module",
            importPrefix = "by_self",
          },
          cargo = {
            loadOutDirsFromCheck = true
          },
          procMacro = {
            enable = true
          },
        }
      }
  })
  end

  -- Setup jubnzv/virtual-types.nvim
  lsp.ocamllsp.setup { on_attach=virtualtypes.on_attach }

  vim.api.nvim_exec([[
    nnoremap <silent> gy <cmd>lua vim.lsp.buf.type_definition()<CR>
    nnoremap <silent> gh <cmd>lua vim.lsp.buf.hover()<CR>
    nnoremap <silent> <localleader>r <cmd>lua vim.lsp.buf.rename()<CR>
    nnoremap ]e <cmd>lua vim.lsp.diagnostic.goto_next()<CR>
    nnoremap [e <cmd>lua vim.lsp.diagnostic.goto_prev()<CR>
    nnoremap <silent> <localleader>d <cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>
    ]], '')
end

function M.setup()
  M.setup_telescope()
  M.setup_mdeval()
  M.setup_colorizer()
  M.setup_lsp()
  vim.api.nvim_set_keymap('n', '<leader>q', "<cmd>lua require'hop'.hint_words()<cr>", {})
end

return M

-- vim:fen:sw=2:tw=120
