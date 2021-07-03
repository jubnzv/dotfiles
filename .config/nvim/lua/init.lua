local api = vim.api

local M = {}

function M.setup()
  require 'lsp'.setup()
  require 'nvim-colorizer'.setup()
  require 'mdeval'.setup({
    require_confirmation = false,
    exec_timeout = 5,
    eval_options = {
      -- Set custom configuration for C++
      cpp = {
        command = {"clang++", "-std=c++20", "-O0"},
      },
      racket = {
        command = {"racket"},
        language_code = "racket",
        exec_type = "interpreted",
        extension = "rkt",
      },
    }
  })
  vim.api.nvim_set_keymap('n', '<localleader>c',
                          "<cmd>lua require 'mdeval'.eval_code_block()<CR>",
                          {silent = true, noremap = true})
end

return M
