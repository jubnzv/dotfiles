-- Neovim configuration entry point
-- Gradual migration from init.vim to Lua

-- Load Lua modules first (options must be before plugins for leaders)
require('user.options')
require('user.plugins')

-- Source remaining VimScript (plugin configs, ft-specific autocmds, functions)
vim.cmd('source ~/.config/nvim/legacy.vim')

-- Load plugin configurations (after plugins are loaded)
require('user.plugins.init')

-- Load autocommands and keymaps
require('user.autocmds')
require('user.keymaps')
