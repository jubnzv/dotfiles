-- lua/user/keymaps.lua
-- Global keymaps for Neovim

local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Basic mappings
keymap('i', 'jj', '<Esc>', opts)
keymap('n', '<leader>h', ':noh<CR>', opts)
keymap('n', '<leader>xc', ':q<CR>', opts)
keymap('n', '<leader>w', ':w<CR>', opts)

-- Y yanks from the cursor to the end of line as expected
keymap('n', 'Y', 'y$', opts)

-- Disable the ever-annoying Ex mode shortcut key
keymap('n', 'Q', '@@', opts)

-- Map Ctrl-Backspace to delete previous word
keymap('i', '<C-BS>', '<C-W>', opts)
keymap('c', '<C-BS>', '<C-W>', opts)

-- Search visually selected text
keymap('v', '//', 'y/<C-R>"<CR>', opts)

-- Search in visual selected area
keymap('v', '<M-/>', '<Esc>/\\%V', { noremap = true })

-- Keep selected text selected when fixing indentation
keymap('v', '<', '<gv', opts)
keymap('v', '>', '>gv', opts)

-- Tabs management
keymap('n', '<A-t>', ':tabnew<CR>', opts)
keymap('i', '<A-t>', '<C-O>:tabnew<CR>', opts)
keymap('n', '<A-Tab>', ':tabnext<CR>', opts)
keymap('i', '<A-Tab>', '<C-O>:tabnext<CR>', opts)

for i = 1, 9 do
  keymap('n', '<A-' .. i .. '>', i .. 'gt', opts)
  keymap('i', '<A-' .. i .. '>', '<C-O>' .. i .. 'gt', opts)
end

-- Refresh content of the current buffer
keymap('n', '<leader>B', ':checktime<CR>', opts)

-- Convert the ^M linebreaks to the normal linebreaks
keymap('n', '<leader>rl', ':set ff=unix<CR> :e ++ff=dos<CR>', opts)

-- Remove all trailing whitespaces
keymap('n', '<leader>rs', ':let _s=@/ <Bar> :%s/\\s\\+$//e <Bar> :let @/=_s <Bar> :nohl <Bar> :unlet _s <CR>', opts)

-- Re-select the text you just pasted
keymap('n', 'gp', '`[v`]', opts)

-- Switch to the recent buffer
keymap('n', '<A-r>', '<C-^>', opts)

-- Use Ctrl-W operation in insert mode
keymap('i', '<C-w>', '<C-g>u<C-w>', opts)

-- Copy file path to the system clipboard
keymap('n', '<leader>cr', function()
  local path = vim.fn.expand('%')
  if vim.fn.has('win32') == 1 then
    path = path:gsub('/', '\\')
  end
  vim.fn.setreg('+', path)
  print('Copied: ' .. path)
end, opts)

keymap('n', '<leader>ca', function()
  local path = vim.fn.expand('%:p')
  if vim.fn.has('win32') == 1 then
    path = path:gsub('/', '\\')
  end
  vim.fn.setreg('+', path)
  print('Copied: ' .. path)
end, opts)

-- Datetime insertion
keymap('n', '<leader>c.', '"=strftime("%Y-%m-%d")<CR>P', opts)
keymap('n', '<C-c>.', '"=strftime("%Y-%m-%d")<CR>P', opts)
keymap('i', '<C-c>.', '<C-R>=strftime("%Y-%m-%d")<CR>', opts)

-- UndoTree
keymap('n', '<A-U>', ':UndotreeToggle<CR>', opts)

-- Highlight specific lines
vim.cmd('highlight LineHighlight ctermbg=darkgray guibg=#458588')
keymap('n', '<leader>m', ":call matchadd('LineHighlight', '\\%'.line('.').'l')<CR>", opts)
keymap('n', '<leader>M', ':call clearmatches()<CR>', opts)

-- FSwitch bindings
keymap('n', '<A-o>', ':FSHere<CR>', opts)
keymap('n', '<localleader>oh', ':FSSplitLeft<CR>', opts)
keymap('n', '<localleader>oj', ':FSSplitBelow<CR>', opts)
keymap('n', '<localleader>ok', ':FSSplitAbove<CR>', opts)
keymap('n', '<localleader>ol', ':FSSplitRight<CR>', opts)

-- Neoformat
keymap('n', '<leader>lf', ':Neoformat<CR>', opts)

-- nvim-tree
keymap('n', '<A-0>', ':NvimTreeToggle<CR>', opts)

-- Telescope keymaps
keymap('n', '<A-p>', "<cmd>lua require('telescope.builtin').find_files()<CR>", opts)
keymap('n', '<leader>fs', "<cmd>lua require('telescope.builtin').live_grep()<CR>", opts)
keymap('n', '<leader>b', "<cmd>lua require('telescope.builtin').buffers()<CR>", opts)
keymap('n', '<leader>fo', "<cmd>lua require('telescope.builtin').oldfiles()<CR>", opts)
keymap('n', '<A-u>', "<cmd>lua require('telescope.builtin').spell_suggest()<CR>", opts)
keymap('n', 'gr', "<cmd>lua require('telescope.builtin').lsp_references()<CR>", opts)
keymap('n', 'gs', "<cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>", opts)
keymap('n', 'gd', "<cmd>lua require('telescope.builtin').lsp_definitions()<CR>", opts)
keymap('n', 'gi', "<cmd>lua require('telescope.builtin').lsp_implementations()<CR>", opts)
keymap('n', '<localleader>a', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
keymap('n', '<localleader>vc', "<cmd>lua require('telescope.builtin').git_commits()<CR>", opts)
keymap('n', '<localleader>vC', "<cmd>lua require('telescope.builtin').git_bcommits()<CR>", opts)
keymap('n', '<localleader>vB', "<cmd>lua require('telescope.builtin').git_branches()<CR>", opts)
keymap('n', '<localleader>vS', "<cmd>lua require('telescope.builtin').git_stash()<CR>", opts)

-- Notes navigation
keymap('n', '<leader>pn', "<cmd>lua require('telescope.builtin').find_files({prompt_title = 'Notes', cwd = '~/Org/Notes/'})<CR>", opts)
keymap('n', '<leader>pm', "<cmd>lua require('telescope.builtin').find_files({prompt_title = 'org-mode', cwd = '~/Org/org-mode'})<CR>", opts)

-- LSP keymaps
keymap('n', 'gy', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
keymap('n', 'gh', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
keymap('n', '<localleader>r', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
keymap('n', ']e', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
keymap('n', '[e', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
keymap('n', '<localleader>d', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)

-- Symbols outline
keymap('n', '<A-6>', ':SymbolsOutline<CR>', opts)

-- Toggle functions (will call VimL functions for now)
keymap('n', '<leader>tc', ':call ToggleConceal()<CR>', opts)
keymap('n', '<leader>tg', ':call Togglegjgk()<CR>', opts)
keymap('n', '<leader>tx', ':call ToggleHex()<CR>', opts)
keymap('n', '<leader>ts', ':call ToggleSyntax()<CR>', opts)
keymap('n', '<leader>tn', ':call ToggleNumber()<CR>', opts)
keymap('n', '<leader>tS', ':call ToggleScrollBind()<CR>', opts)
keymap('n', '<leader>tp', ':setlocal paste!<CR>', opts)
keymap('n', '<leader>tC', ':ColorizerToggle<CR>', opts)
keymap('n', '<leader>tr', ':RainbowToggle<CR>', opts)
keymap('n', '<leader>tm', ':NeomakeToggle<CR>', opts)
keymap('n', '<leader>tt', ':TableModeToggle<CR>', opts)
keymap('n', '<leader>ti', ':IBLToggle<CR>', opts)
