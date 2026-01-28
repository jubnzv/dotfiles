-- lua/user/plugins/cmp.lua
-- nvim-cmp completion configuration

local ok, cmp = pcall(require, 'cmp')
if not ok then
  return
end

-- UltiSnips integration
local ok_ultisnips, cmp_ultisnips_mappings = pcall(require, 'cmp_nvim_ultisnips.mappings')
if not ok_ultisnips then
  cmp_ultisnips_mappings = nil
end

cmp.setup({
  snippet = {
    expand = function(args)
      vim.fn['UltiSnips#Anon'](args.body)
    end,
  },

  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },

  mapping = cmp.mapping.preset.insert({
    -- Navigate completion menu (matching old deoplete keybindings)
    ['<A-j>'] = cmp.mapping.select_next_item(),
    ['<A-k>'] = cmp.mapping.select_prev_item(),

    -- Scroll docs
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),

    -- Trigger completion manually
    ['<A-o>'] = cmp.mapping.complete(),

    -- Close completion menu
    ['<A-q>'] = cmp.mapping.abort(),

    -- Confirm selection and expand/jump snippets
    ['<A-l>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.confirm({ select = true })
      elseif cmp_ultisnips_mappings then
        cmp_ultisnips_mappings.expand_or_jump_forwards(fallback)
      else
        fallback()
      end
    end, { 'i', 's' }),

    -- UltiSnips jump backward
    ['<A-h>'] = cmp.mapping(function(fallback)
      if cmp_ultisnips_mappings then
        cmp_ultisnips_mappings.jump_backwards(fallback)
      else
        fallback()
      end
    end, { 'i', 's' }),

    -- Enter to confirm (alternative)
    ['<CR>'] = cmp.mapping.confirm({ select = false }),
  }),

  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'ultisnips' },
    { name = 'path' },
  }, {
    { name = 'buffer' },
  }),

  -- Formatting with icons
  formatting = {
    format = function(entry, vim_item)
      -- Kind icons
      local kind_icons = {
        Text = '',
        Method = '󰆧',
        Function = '󰊕',
        Constructor = '',
        Field = '󰇽',
        Variable = '󰂡',
        Class = '󰠱',
        Interface = '',
        Module = '',
        Property = '󰜢',
        Unit = '',
        Value = '󰎠',
        Enum = '',
        Keyword = '󰌋',
        Snippet = '',
        Color = '󰏘',
        File = '󰈙',
        Reference = '',
        Folder = '󰉋',
        EnumMember = '',
        Constant = '󰏿',
        Struct = '',
        Event = '',
        Operator = '󰆕',
        TypeParameter = '󰅲',
      }
      vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind] or '', vim_item.kind)

      -- Source labels
      vim_item.menu = ({
        nvim_lsp = '[LSP]',
        ultisnips = '[Snip]',
        buffer = '[Buf]',
        path = '[Path]',
      })[entry.source.name]

      return vim_item
    end,
  },
})

-- Command line completion for `/` and `?`
cmp.setup.cmdline({ '/', '?' }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' },
  },
})

-- Command line completion for `:`
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' },
  }, {
    { name = 'cmdline' },
  }),
})

-- Set completeopt for better completion experience
vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }
