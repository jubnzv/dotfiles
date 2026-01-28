-- lua/user/plugins/gitlinker.lua
-- gitlinker configuration

require('gitlinker').setup()

-- Keymaps for opening git links in browser
vim.api.nvim_set_keymap(
  'n',
  '<leader>vo',
  '<cmd>lua require"gitlinker".get_buf_range_url("n", {action_callback = require"gitlinker.actions".open_in_browser})<cr>',
  {}
)
vim.api.nvim_set_keymap(
  'v',
  '<leader>vo',
  '<cmd>lua require"gitlinker".get_buf_range_url("v", {action_callback = require"gitlinker.actions".open_in_browser})<cr>',
  {}
)
