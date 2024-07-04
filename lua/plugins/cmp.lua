return {
  {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      { 'hrsh7th/cmp-buffer', lazy = true },
      { 'hrsh7th/cmp-path', lazy = true },
      { 'hrsh7th/cmp-nvim-lsp', lazy = true },
      {
        'garymjr/nvim-snippets',
        dependencies = { 'rafamadriz/friendly-snippets' },
        opts = { friendly_snippets = true },
      },
    },
    opts = function()
      local cmp = require('cmp')
      return {
        window = {
          completion = {
            border = 'rounded',
            winhighlight = 'Normal:CmpPmenu,CursorLine:CmpSel,Search:None',
          },
          documentation = {
            border = 'rounded',
            winhighlight = 'Normal:CmpDoc',
          },
        },
        preselect = 'item',
        completion = {
          completeopt = 'menu,menuone,noinsert',
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-n>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
          ['<C-p>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
          ['<C-u>'] = cmp.mapping.scroll_docs(-4),
          ['<C-d>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.abort(),
          ['<Tab>'] = cmp.mapping.confirm({ select = false }),
        }),
        formatting = {
          fields = { 'menu', 'abbr', 'kind' },
          format = function(_, item)
            local icons = require('config.icons').kinds
            if icons[item.kind] then item.kind = icons[item.kind] .. item.kind .. ' ' end
            return item
          end,
        },
        sources = cmp.config.sources({
          { name = 'snippets' },
          { name = 'nvim_lsp' },
          { name = 'path' },
        }, {
          { name = 'buffer' },
        }),
      }
    end,
  },
}
