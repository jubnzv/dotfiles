-- lua/user/plugins/nvim-tree.lua
-- NvimTree configuration

require('nvim-tree').setup({
  git = { ignore = true },
  disable_netrw = true,
  update_focused_file = { enable = true },
  update_cwd = true,
  filters = { custom = { '.git', 'node_modules', '.cache', '__pycache__', '.clangd' } },
})

-- Highlights
vim.cmd('hi NvimTreeIndentMarker guifg=#3c3836')
vim.cmd('hi NvimTreeFolderIcon guifg=#7c6f64')
vim.cmd('hi NvimTreeGitDirty guifg=#689d6a')
