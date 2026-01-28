-- lua/user/autocmds.lua
-- Autocommands for Neovim

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- Disable syntax for large files
augroup('LargeFile', { clear = true })
autocmd('BufWinEnter', {
  group = 'LargeFile',
  pattern = '*',
  callback = function()
    if vim.fn.line2byte(vim.fn.line('$') + 1) > 1000000 then
      vim.cmd('syntax clear')
    end
  end,
})

-- Jump to last position when reopening a file
augroup('LastPosition', { clear = true })
autocmd('BufReadPost', {
  group = 'LastPosition',
  pattern = '*',
  callback = function()
    local line = vim.fn.line
    if line("'\"") > 1 and line("'\"") <= line('$') then
      vim.cmd("normal! g'\"")
    end
  end,
})

-- Parse modelines safely (disable on temp paths)
augroup('SafeModeline', { clear = true })
autocmd({ 'BufReadPost', 'BufNewFile' }, {
  group = 'SafeModeline',
  pattern = '*',
  callback = function()
    local path = vim.fn.expand('%:p')
    if path:match('/tmp') or path:match('~/Downloads') then
      vim.opt_local.modeline = false
    end
  end,
})

-- Trailing whitespace highlight
vim.cmd('highlight ExtraWhitespace ctermbg=red guibg=red')
augroup('TrailingWhitespace', { clear = true })
autocmd('BufWinEnter', {
  group = 'TrailingWhitespace',
  pattern = '*',
  callback = function()
    vim.fn.matchadd('ExtraWhitespace', '\\s\\+$')
  end,
})
autocmd('InsertEnter', {
  group = 'TrailingWhitespace',
  pattern = '*',
  callback = function()
    vim.fn.matchadd('ExtraWhitespace', '\\s\\+\\%#\\@<!$')
  end,
})
autocmd('InsertLeave', {
  group = 'TrailingWhitespace',
  pattern = '*',
  callback = function()
    vim.fn.matchadd('ExtraWhitespace', '\\s\\+$')
  end,
})
autocmd('BufWinLeave', {
  group = 'TrailingWhitespace',
  pattern = '*',
  callback = function()
    vim.fn.clearmatches()
  end,
})

-- Color column based on textwidth
local function set_color_column()
  if vim.bo.textwidth == 0 then
    vim.opt_local.colorcolumn = '80'
  else
    vim.opt_local.colorcolumn = '+0'
  end
end

augroup('ColorColumn', { clear = true })
autocmd('OptionSet', {
  group = 'ColorColumn',
  pattern = 'textwidth',
  callback = set_color_column,
})
autocmd('BufEnter', {
  group = 'ColorColumn',
  pattern = '*',
  callback = set_color_column,
})

-- Create directories before write
augroup('CreateDir', { clear = true })
autocmd('BufWritePre', {
  group = 'CreateDir',
  pattern = '*',
  callback = function()
    local file = vim.fn.expand('<afile>')
    if not file:match('^%w+://') then
      local dir = vim.fn.expand('%:h')
      if vim.fn.isdirectory(dir) == 0 then
        vim.fn.system('mkdir -p ' .. vim.fn.shellescape(dir))
      end
    end
  end,
})

-- Last modified timestamp
augroup('LastModified', { clear = true })
autocmd('BufWritePre', {
  group = 'LastModified',
  pattern = '*',
  callback = function()
    if vim.bo.modified then
      local save_cursor = vim.fn.getpos('.')
      local n = math.min(20, vim.fn.line('$'))
      local timestamp = os.date('%a %b %d, %Y  %I:%M%p')
      vim.cmd(string.format("silent! 1,%ds#^\\(.\\{,10}Last modified: \\).*#\\1%s#e", n, timestamp))
      vim.fn.histdel('search', -1)
      vim.fn.setpos('.', save_cursor)
    end
  end,
})

-- Disable completion in Telescope prompt
augroup('TelescopeCmp', { clear = true })
autocmd('FileType', {
  group = 'TelescopeCmp',
  pattern = 'TelescopePrompt',
  callback = function()
    require('cmp').setup.buffer({ enabled = false })
  end,
})
