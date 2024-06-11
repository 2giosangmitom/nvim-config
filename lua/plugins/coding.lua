return {
  {
    'ray-x/go.nvim',
    dependencies = {
      'ray-x/guihua.lua',
      'neovim/nvim-lspconfig',
      'nvim-treesitter/nvim-treesitter',
    },
    ft = { 'go', 'gomod' },
    opts = {},
    build = function()
      require('go.install').update_all()
    end,
  },

  {
    'folke/lazydev.nvim',
    ft = 'lua',
    dependencies = 'Bilal2453/luvit-meta',
    opts = {
      library = {
        { path = 'luvit-meta/library', words = { 'vim%.uv' } },
      },
    },
  },

  {
    'neovim/nvim-lspconfig',
    event = { 'BufReadPost', 'BufNewFile' },
    dependencies = {
      'williamboman/mason.nvim',
    },
    opts = function()
      local icons = require('config.icons')

      return {
        servers = { 'lua_ls' },
        ui = {
          border = 'rounded',
        },
        diagnostics = {
          underline = true,
          update_in_insert = false,
          virtual_text = {
            spacing = 4,
            source = 'if_many',
          },
          severity_sort = true,
          signs = {
            text = {
              [vim.diagnostic.severity.ERROR] = icons.diagnostics.Error,
              [vim.diagnostic.severity.WARN] = icons.diagnostics.Warning,
              [vim.diagnostic.severity.HINT] = icons.diagnostics.Hint,
              [vim.diagnostic.severity.INFO] = icons.diagnostics.Infomation,
            },
          },
        },
      }
    end,
    config = function(_, opts)
      -- Border
      vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, { border = opts.ui.border })
      vim.lsp.handlers['textDocument/signatureHelp'] =
        vim.lsp.with(vim.lsp.handlers.signature_help, { border = opts.ui.border })
      require('lspconfig.ui.windows').default_options.border = opts.ui.border

      -- Diagnostics
      vim.diagnostic.config(opts.diagnostics)

      -- Setup servers
      for _, server in ipairs(opts.servers) do
        local server_opts = {}
        local ok, settings = pcall(require, 'lsp.' .. server)
        if ok then
          server_opts = vim.tbl_deep_extend('force', settings, server_opts)
        end
        require('lspconfig')[server].setup(server_opts)
      end
    end,
  },

  {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
    },
    opts = function()
      local cmp = require('cmp')
      return {
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
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
            if icons[item.kind] then
              item.kind = icons[item.kind] .. item.kind
            end
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
