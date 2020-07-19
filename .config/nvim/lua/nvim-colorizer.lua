local api = vim.api
local M = {}

function M.setup()
    -- Attach to certain Filetypes, add special configuration for `html`
    -- Use `background` for everything else.
    require'colorizer'.setup {
      'css',
      'javascript',
      'html',
      'markdown',
      'conf',
      'plantuml',
    }
end

return M
