local ok, configs = pcall(require, 'nvim-treesitter.configs')
if not ok then return end

configs.setup({
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
})
