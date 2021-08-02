local M = {}

function M.setup()
  vim.fn.nvim_set_option('foldmethod', 'expr')
  vim.fn.nvim_set_option('foldexpr', 'nvim_treesitter#foldexpr()')
  vim.fn.nvim_set_option('foldlevel', 10)

  local textobjects = {
    select = {
      enable = true,
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
        ["ii"] = "@call.inner",
        ["ai"] = "@call.outer",

        -- Or you can define your own textobjects like this
        ["iF"] = {
            python = "(function_definition) @function",
            cpp = "(function_definition) @function",
            c = "(function_definition) @function",
            java = "(method_declaration) @function",
        },
      },
    },
  }

  require'nvim-treesitter.configs'.setup {
    ensure_installed = "all",
    indent = {
      enable = true
    },
    highlight = {
      enable = true,
      use_languagetree = false,
      custom_captures = {
        ["jsx_expression.bracket"] = "GruvboxFg2",
        ["tag.intrinsic.delimiter"] = "TSTag",
        ["tag.type.delimiter"] = 'GruvboxOrange',
        ["tsx.named_imports.bracket"] = "GruvboxAqua",
        ["gruvbox.red"] = "GruvboxRed",
        ["gruvbox.yellow"] = "GruvboxYellow",
        ["gruvbox.blue"] = "GruvboxBlue",
        ["gruvbox.orange"] = "GruvboxOrange",
        ["gruvbox.fg2"] = "GruvboxFg2",
        ["gruvbox.aqua"] = "GruvboxAqua",
        ["gruvbox.green"] = "GruvboxGreen",
        ["tag.selfclosing"] = "GruvboxBlue",
        ["tdo"] = "TSTag",
        ["trr"] = "GruvboxOrange",
        ["jsx.self.closing.delimiter"] = "GruvboxOrange",
        ["tdd"] = "GruvboxOrange",
        ["tdc"] = "GruvboxRed"
      }
    },
    refactor = {
      highlight_definitions = { enable = true },
    },
    incremental_selection = incremental_selection,
    textobjects = textobjects
  }
end

return M
