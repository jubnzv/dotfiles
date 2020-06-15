local api = vim.api

local M = {}

function M.setup()
  require 'lsp'.setup()
  require 'ts'.setup()
end

return M

