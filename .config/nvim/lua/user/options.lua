-- lua/user/options.lua
-- General and UI options for Neovim

local opt = vim.opt
local g = vim.g

-- Leaders (must be set before plugins)
g.mapleader = ' '
g.maplocalleader = ','

-- Shell
if vim.fn.has('fish') == 1 then
  opt.shell = '/bin/bash'
end

-- Windows PATH tweak
if vim.fn.has('win32') == 1 then
  vim.env.PATH = 'C:\\Program Files\\Git\\usr\\bin;' .. vim.env.PATH
end

-- Disable some builtin plugins
g.loaded_gzip = 1
g.loaded_tar = 1
g.loaded_tarPlugin = 1
g.loaded_zipPlugin = 1
g.loaded_2html_plugin = 1

-- General options
opt.compatible = false
opt.viminfo = "'1000,f1"
opt.scrolloff = 7
opt.scroll = 7
opt.undofile = true
opt.undodir = vim.fn.expand('$HOME/.vim/undo')
opt.undolevels = 1000
opt.undoreload = 10000
opt.clipboard = 'unnamedplus,unnamed'
opt.showmatch = true
opt.mat = 1
opt.wildmenu = true
opt.wildmode = 'longest,list,full'
opt.wildignore:append({ '*.o', '*.pyc', '*.aux', '*.out', '*.toc' })
opt.wildignore:append({ '*.jpg', '*.jpeg', '*.gif', '*.png' })
opt.wildignore:append({ '.hg', '.git', '.svn', '*~' })
opt.wildcharm = vim.fn.char2nr('<C-z>')
opt.timeoutlen = 500
opt.timeout = false
opt.autochdir = false
opt.autoindent = true
opt.autoread = false
opt.hidden = true
opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.lazyredraw = true
opt.joinspaces = false
opt.eol = true
opt.fixeol = true
opt.mouse = 'a'
opt.spell = false
opt.conceallevel = 0
opt.concealcursor = 'nc'

-- Langmap for Cyrillic
opt.langmap:append('ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯ;ABCDEFGHIJKLMNOPQRSTUVWXYZ')
opt.langmap:append('фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz')
opt.langmap:append('ЖжЭэХхЪъ;\\:\\;\\"\\\'\\{[\\}]')

-- netrw
g.netrw_browsex_viewer = 'xdg-open'

-- UI options
opt.termguicolors = true
opt.winblend = 5
opt.pumblend = 5
opt.shortmess:append('Ic')
opt.showmode = false
opt.relativenumber = true
opt.cursorline = true
opt.laststatus = 2
opt.title = true
opt.signcolumn = 'yes'
-- Set background based on theme-mode file
local function set_background_from_theme()
  local theme_file = vim.fn.expand('$HOME/.config/theme-mode')
  local f = io.open(theme_file, 'r')
  if f then
    local mode = f:read('*l')
    f:close()
    if mode == 'light' or mode == 'dark' then
      opt.background = mode
    end
  end
end
set_background_from_theme()

-- Update background when Neovim gains focus
vim.api.nvim_create_autocmd('FocusGained', {
  callback = set_background_from_theme,
})
opt.guicursor:append('c-ci-cr:block')

-- Folding settings
opt.foldmethod = 'syntax'
opt.foldnestmax = 6
opt.foldenable = false
opt.foldlevel = 2
opt.foldcolumn = '0'
opt.fillchars = 'fold: '

-- ctags
opt.tags = './tags;'
