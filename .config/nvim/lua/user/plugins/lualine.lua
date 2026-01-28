-- lua/user/plugins/lualine.lua
-- Lualine statusline configuration

local ok, lualine = pcall(require, 'lualine')
if not ok then
  return
end

-- Custom filename component that shortens path
local function shortened_filename()
  local path = vim.fn.expand('%')
  if path == '' then return '[No Name]' end

  local parts = vim.split(path, '/')
  if #parts < 3 then
    return path
  end

  -- Shorten all but last component to 2 chars
  local result = {}
  for i, part in ipairs(parts) do
    if i == #parts then
      table.insert(result, part)
    else
      table.insert(result, part:sub(1, 2))
    end
  end
  return table.concat(result, '/')
end

lualine.setup({
  options = {
    theme = 'gruvbox',
    component_separators = { left = '|', right = '|' },
    section_separators = { left = '', right = '' },
    globalstatus = false,
  },
  sections = {
    lualine_a = { 'mode' },
    lualine_b = {
      { 'branch', icon = '' },  -- no icon
      {
        'diagnostics',
        symbols = { error = '● ', warn = '● ', info = '● ', hint = '● ' },
        colored = true,
      },
    },
    lualine_c = {
      { shortened_filename },
      { 'readonly', fmt = function(str) return str ~= '' and 'RO' or '' end },
      { 'modified', fmt = function(str) return str ~= '' and '[+]' or '' end },
    },
    lualine_x = {
      'encoding',
      { 'fileformat', icons_enabled = false, cond = function() return vim.bo.fileformat ~= 'unix' end },
      { 'filetype', icons_enabled = false },
    },
    lualine_y = { 'progress' },
    lualine_z = { 'location' },
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { 'filename' },
    lualine_x = { 'location' },
    lualine_y = {},
    lualine_z = {},
  },
})
