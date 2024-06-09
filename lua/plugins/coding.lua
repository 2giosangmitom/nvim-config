return {
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
      vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, { border = opts.ui.border })
      vim.lsp.handlers['textDocument/signatureHelp'] =
        vim.lsp.with(vim.lsp.handlers.signature_help, { border = opts.ui.border })
      require('lspconfig.ui.windows').default_options.border = opts.ui.border

      -- Diagnostics
      vim.diagnostic.config(opts.diagnostics)

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
}
