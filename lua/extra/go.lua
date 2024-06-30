return {
  {
    'neovim/nvim-lspconfig',
    opts = {
      servers = {
        gopls = {},
      },
    },
  },

  {
    'nvim-treesitter/nvim-treesitter',
    opts = {
      ensure_installed = { 'go', 'gomod', 'gosum', 'gowork' },
    },
  },

  {
    'williamboman/mason.nvim',
    opts = { ensure_installed = { 'goimports', 'gofumpt' } },
  },

  {
    'stevearc/conform.nvim',
    optional = true,
    opts = {
      formatters_by_ft = {
        go = { 'goimports', 'gofumpt' },
      },
    },
  },

  {
    'leoluz/nvim-dap-go',
    opts = {},
  },

  {
    'jay-babu/mason-nvim-dap.nvim',
    opts = {
      ensure_installed = { 'delve' },
    },
  },

  {
    'nvim-neotest/neotest',
    dependencies = {
      'fredrikaverpil/neotest-golang',
    },
    opts = function(_, opts)
      table.insert(
        opts.adapters,
        require('neotest-golang')({
          dap_go_enabled = true,
        })
      )
    end,
  },
}
