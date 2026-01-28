-- lua/user/plugins/colorizer.lua
-- nvim-colorizer configuration

require('colorizer').setup({
  '*',
  markdown = { names = false },
  css = { rgb_fn = true },
})
