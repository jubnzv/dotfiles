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

    require 'colorizer'.setup {
      '*';
      markdown = { names = false };
      css = { rgb_fn = true; }; -- Enable parsing rgb(...) functions in css.
    }
end

return M
