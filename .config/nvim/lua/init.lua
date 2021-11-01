local M = {}

-- {{{ Setup nvim-telescope/telescope.nvim and related plugins.
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
-- }}}

-- {{{ Setup hrsh7th/nvim-cmp.
function M.setup_nvim_cmp()
  local cmp = require'cmp'

  local has_any_words_before = function()
    if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then
      return false
    end
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and
           vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
    end

  local press = function(key)
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), "n", true)
  end

  cmp.setup({
    snippet = {
      expand = function(args)
        -- vim.fn["vsnip#anonymous"](args.body)
        vim.fn["UltiSnips#Anon"](args.body)
      end,
    },
    mapping = {
      ['<A-l>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
          if vim.fn["UltiSnips#CanExpandSnippet"]() == 1 then
            return press("<C-R>=UltiSnips#ExpandSnippet()<CR>")
          end
          cmp.select_next_item()
        elseif has_any_words_before() then
          press("<Space>")
        else
          fallback()
        end
      end),
      ['<A-j>'] = cmp.mapping(
        cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
        { 'i', 'c' }
      ),
      ['<A-k>'] = cmp.mapping(
        cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
        { 'i', 'c' }
      ),
      ['<A-q>'] = cmp.mapping({
        i = cmp.mapping.abort(),
        c = cmp.mapping.close(),
      }),
    },
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      -- { name = 'vsnip' },
      { name = 'ultisnips' },
    }, {
      { name = 'buffer' },
    })
  })

  -- Use buffer source for `/`.
  cmp.setup.cmdline('/', {
    sources = {
      { name = 'buffer' }
    }
  })

  -- Use cmdline & path source for ':'.
  cmp.setup.cmdline(':', {
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    })
  })

  -- Setup lspconfig.
  local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
  local lsp_servers = {'clangd', 'pylsp', 'ocamllsp', 'rust_analyzer', 'gopls', 'hls'}
  for _, lsp in pairs(lsp_servers) do
    require('lspconfig')[lsp].setup {
      capabilities = capabilities
    }
  end
end
-- }}}

-- {{{ Setup jubnzv/mdeval.nvim.
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
-- }}}

-- {{{ Setup norcalli/nvim-colorizer.lua.
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
-- }}}

-- {{{ Setup all things related to built-in LSP server, including keybinginds, helper plugins, etc.
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

  -- ghcup-env is installed in the configuration file of the current shell.
  -- We want to explicitly specify path to the hls binary here.
  local hls_bin = "/home/jubnzv/.ghcup/bin/haskell-language-server-wrapper"
  if vim.fn.executable(hls_bin) then
    lsp.hls.setup {
      cmd = { hls_bin, "--lsp" },
      on_attach=virtualtypes.on_attach
    }
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

  if vim.fn.executable('ocamllsp') then
    lsp.ocamllsp.setup { on_attach=virtualtypes.on_attach }
  end

  vim.api.nvim_exec([[
    nnoremap <silent> gy <cmd>lua vim.lsp.buf.type_definition()<CR>
    nnoremap <silent> gh <cmd>lua vim.lsp.buf.hover()<CR>
    nnoremap <silent> <localleader>r <cmd>lua vim.lsp.buf.rename()<CR>
    nnoremap ]e <cmd>lua vim.lsp.diagnostic.goto_next()<CR>
    nnoremap [e <cmd>lua vim.lsp.diagnostic.goto_prev()<CR>
    nnoremap <silent> <localleader>d <cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>
    ]], '')
end
-- }}}

-- {{{ Setup kristijanhusak/orgmode.nvim.
function M.setup_org_mode()
  -- Setup nvim-treesitter grammar used by org-mode.
  local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
  parser_config.org = {
    install_info = {
      url = 'https://github.com/milisims/tree-sitter-org',
      revision = 'main',
      files = {'src/parser.c', 'src/scanner.cc'},
    },
    filetype = 'org',
  }

  require'nvim-treesitter.configs'.setup {
    -- If TS highlights are not enabled at all, or disabled via `disable` prop, highlighting will
    -- fallback to default Vim syntax highlighting
    highlight = {
      enable = true,
      -- Remove this to use TS highlighter for some of the highlights (Experimental)
      disable = {'org'},
      -- Required since TS highlighter doesn't support all syntax features (conceal)
      additional_vim_regex_highlighting = {'org'},
    },
    ensure_installed = {'org'}, -- Or run :TSUpdate org
  }

  require('orgmode').setup({
    org_agenda_files = {'~/Org/org-mode/Notes.org'},
    -- Refile is useless in my workflow now.
    org_default_notes_file = '~/Org/org-mode/refile.org',
  })
end
-- }}}

-- {{{ Setup kyazdani42/nvim-tree.lua
function M.setup_nvim_tree()
  vim.api.nvim_command("nnoremap <silent><A-0> :NvimTreeToggle<CR>")

  vim.api.nvim_command("hi NvimTreeIndentMarker guifg=#3c3836")
  vim.api.nvim_command("hi NvimTreeFolderIcon guifg=#7c6f64")
  vim.api.nvim_command("hi NvimTreeGitDirty guifg=#689d6a")

  vim.g.nvim_tree_indent_markers = 1
  vim.g.nvim_tree_gitignore = 1
  vim.g.nvim_tree_icons = {
    default =      '',
    symlink =      '',
    git = {
      unstaged =   "~",
      staged =     "✓",
      unmerged =   "",
      renamed =    "➜",
      untracked =  "★"
    },
    folder = {
      default =    "",
      open =       "",
      empty =      "",
      empty_open = "",
      symlink =    "",
    }
  }

  require 'nvim-tree'.setup{
    disable_netrw       = true,
    update_focused_file = { enable = true },
    update_cwd = true,
    filters = { custom = { '.git', 'node_modules', '.cache', '__pycache__', '.clangd' } }
  }
end
-- }}}

function M.setup()
  M.setup_telescope()
  M.setup_nvim_cmp()
  M.setup_mdeval()
  M.setup_colorizer()
  M.setup_lsp()
  M.setup_org_mode()
  M.setup_nvim_tree()
  -- vim.api.nvim_set_keymap('n', '<leader>q', "<cmd>lua require'hop'.hint_words()<cr>", {})
end

return M

-- vim:fen:fdm=marker:sw=2:tw=100
