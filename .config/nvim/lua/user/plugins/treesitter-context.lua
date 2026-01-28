-- lua/user/plugins/treesitter-context.lua
-- Treesitter context configuration

local ok, context = pcall(require, 'treesitter-context')
if not ok then
  return
end

context.setup({
  enable = false,  -- Disabled by default
  max_lines = 0,
  min_window_height = 0,
  line_numbers = true,
  multiline_threshold = 20,
  trim_scope = 'outer',
  mode = 'cursor',
  separator = nil,
  zindex = 20,
})

vim.keymap.set('n', '<leader>tt', '<cmd>TSContextToggle<cr>', { desc = 'Toggle treesitter context' })
