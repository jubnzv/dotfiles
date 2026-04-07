-- lua/user/plugins.lua
-- Plugin management with vim-plug wrapped in Lua

local Plug = vim.fn['plug#']

vim.call('plug#begin', '~/.local/share/nvim/plugged')

-- Core utilities
Plug('kshenoy/vim-signature')                 -- Extended marks support
Plug('tpope/vim-eunuch')                      -- Helpers for Shell
Plug('tpope/vim-repeat')                      -- Remap . in a way that plugins can tap into it
Plug('andymass/vim-matchup')                  -- Better %
Plug('junegunn/vim-easy-align')               -- A Vim alignment plugin
Plug('tpope/vim-surround')                    -- Surround text w/ brackets
Plug('tpope/vim-abolish')                     -- Case-sensitive search/substitute/abbreviate
Plug('jiangmiao/auto-pairs')                  -- Insert or delete brackets, parens, quotes in pair
Plug('tpope/vim-rsi')                         -- Readline (emacs) keybindings in command and insert modes
Plug('osyo-manga/vim-over')                   -- :substitute preview
Plug('christoomey/vim-tmux-navigator')        -- tmux integration

-- UI
Plug('tyru/open-browser.vim')                 -- Plugin for opening links in the browser
Plug('nvim-lualine/lualine.nvim')             -- Statusline plugin
Plug('jubnzv/gruvbox')                        -- Color scheme
Plug('norcalli/nvim-colorizer.lua')           -- Colorize color names and codes
Plug('haya14busa/incsearch.vim')              -- Incrementally highlight search results
Plug('itchyny/vim-cursorword')                -- Plugin to highlight the word under the cursor

-- Git
Plug('tpope/vim-fugitive')                    -- Git wrapper
Plug('cohama/agit.vim')                       -- gitk clone for vim
Plug('airblade/vim-gitgutter')                -- Shows git status on a gutter column
Plug('ruifm/gitlinker.nvim')                  -- Generate shareable links for git frontends
Plug('statox/vim-compare-lines')              -- Compares symbol in two lines in the buffer
Plug('rhysd/git-messenger.vim')               -- Reveal the commit messages under the cursor

-- File navigation
Plug('kyazdani42/nvim-tree.lua')              -- A tree explorer plugin for vim
Plug('kyazdani42/nvim-web-devicons')          -- devicons for nvim-tree.lua
Plug('mbbill/undotree')                       -- Emacs' undotree

-- LSP & Completion
Plug('simrat39/symbols-outline.nvim')         -- Viewer & Finder for LSP symbols and tags
Plug('ludovicchabant/vim-gutentags')          -- Auto (re)generate tag files
Plug('neovim/nvim-lspconfig')                 -- Configuration for native Neovim LSP client
Plug('j-hui/fidget.nvim', { tag = 'legacy' }) -- UI that shows LSP progress
Plug('jubnzv/virtual-types.nvim')             -- Plugin that shows type annotations in virtual text

-- nvim-cmp completion
Plug('hrsh7th/nvim-cmp')                      -- Completion engine
Plug('hrsh7th/cmp-nvim-lsp')                  -- LSP source for nvim-cmp
Plug('hrsh7th/cmp-buffer')                    -- Buffer words source
Plug('hrsh7th/cmp-path')                      -- Path source
Plug('hrsh7th/cmp-cmdline')                   -- Command line source

-- Snippets
Plug('sirver/ultisnips')                      -- Snippets engine
Plug('honza/vim-snippets')                    -- A collection of snippets
Plug('quangnguyen30192/cmp-nvim-ultisnips')   -- UltiSnips source for nvim-cmp

-- Editing
Plug('terryma/vim-expand-region')             -- Visually select increasingly larger regions of text
Plug('machakann/vim-swap')                    -- Reorder arguments in functions with `g>` and `g<`
Plug('tyru/caw.vim')                          -- Comment plugin
Plug('lukas-reineke/indent-blankline.nvim')   -- Display indent levels in code
Plug('sbdchd/neoformat')                      -- Integration with code formatters
Plug('jpalardy/vim-slime')                    -- REPL integration
Plug('derekwyatt/vim-fswitch')                -- Switching between companion files
Plug('luochen1990/rainbow')                   -- Rainbow Parentheses improved

-- Fuzzy finder
Plug('nvim-lua/plenary.nvim')                 -- Various utilities used by other plugins
Plug('nvim-telescope/telescope.nvim')         -- Fuzzy-finder
Plug('folke/trouble.nvim')                    -- Show persistent telescope results
Plug('stevearc/dressing.nvim')                -- A plugin that replaces most of built-in menus with telescope

-- Treesitter
Plug('nvim-treesitter/nvim-treesitter')       -- tree-sitter integration
Plug('nvim-treesitter/nvim-treesitter-context') -- Shows context of a current function using treesitter

-- org-mode
Plug('nvim-orgmode/orgmode.nvim')             -- org-mode clone

-- Writing
Plug('dhruvasagar/vim-table-mode', { ['for'] = { 'markdown' } })
Plug('iamcco/markdown-preview.nvim', {
  ['for'] = { 'markdown' },
  ['do'] = vim.fn['mkdp#util#install'],
  tag = 'v0.0.10'
})
Plug('junegunn/goyo.vim')                     -- Distraction-free writing

-- Language-specific
Plug('jamessan/vim-gnupg')                    -- Transparent editing of GPG-encrypted files
Plug('lervag/vimtex', { ['for'] = { 'tex' } })
Plug('bfrg/vim-cpp-modern', { ['for'] = { 'cpp' } })
Plug('ocaml/vim-ocaml', { ['for'] = { 'ocaml' } })
Plug('vim-python/python-syntax', { ['for'] = { 'python' } })
Plug('wlangstroth/vim-racket', { ['for'] = { 'rkt' } })
Plug('rust-lang/rust.vim', { ['for'] = { 'rust' } })
Plug('fatih/vim-go', { ['for'] = { 'go' } })
Plug('tomlion/vim-solidity', { ['for'] = { 'sol' } })
Plug('leafgarland/typescript-vim', { ['for'] = { 'typescript' } })
Plug('othree/xml.vim', { ['for'] = { 'xml', 'html' } })
Plug('whonore/Coqtail', { ['for'] = { 'coq' } })
Plug('florentc/vim-tla', { ['for'] = { 'tla' } })
Plug('hanw/vim-bluespec', { ['for'] = { 'quint' } })
Plug('tikhomirov/vim-glsl', { ['for'] = { 'glsl' } })
Plug('elzr/vim-json', { ['for'] = { 'json' } })
Plug('hylang/vim-hy', { ['for'] = { 'hy' } })
Plug('nathangrigg/vim-beancount', { ['for'] = { 'beancount' } })
Plug('move-language/move.vim', { ['for'] = { 'move' } })

-- Local plugins
if vim.fn.isdirectory('/home/jubnzv/Sources/llvm-project/llvm/utils/vim/') == 1 then
  Plug('/home/jubnzv/Sources/llvm-project/llvm/utils/vim/')
end

if vim.fn.isdirectory('/home/jubnzv/Dev/scilla.nvim/') == 1 then
  Plug('/home/jubnzv/Dev/scilla.nvim/')
else
  Plug('jubnzv/vim-scilla', { ['for'] = { 'scilla' } })
end

vim.call('plug#end')
