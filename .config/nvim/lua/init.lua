local api = vim.api

local M = {}

function M.setup()
  require 'lsp'.setup()
  require 'ts'.setup()
  require 'nvim-colorizer'.setup()
end

return M

