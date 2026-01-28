-- lua/user/plugins/telescope.lua
-- Telescope configuration

local telescope = require('telescope')
local open_with_trouble = require('trouble.sources.telescope').open

telescope.setup({
  defaults = {
    preview = {
      treesitter = false,
    },
    mappings = {
      i = { ['<c-t>'] = open_with_trouble },
      n = { ['<c-t>'] = open_with_trouble },
    },
  },
})

-- Poor man's Zettelkasten
local home = vim.fn.expand('~/Org/Notes/')
local builtin = require('telescope.builtin')

function _G.backlinks()
  local filename = vim.fn.expand('%:t')
  builtin.live_grep({
    results_title = 'Backlinks to ' .. filename,
    prompt_title = 'Search',
    cwd = home,
    search_dirs = { home },
    default_text = '\\[.*\\]\\((./)?' .. filename .. '(#.+)*\\)',
    find_command = { 'fd' },
  })
end
