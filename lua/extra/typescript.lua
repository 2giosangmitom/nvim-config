return {
  {
    'nvim-treesitter/nvim-treesitter',
    opts = {
      ensure_installed = { 'javascript', 'typescript', 'tsx', 'jsdoc' },
    },
  },

  {
    'neovim/nvim-lspconfig',
    opts = {
      servers = {
        vtsls = {},
        eslint = {},
      },
    },
  },

  {
    'williamboman/mason.nvim',
    opts = { ensure_installed = { 'prettierd' } },
  },

  {
    'stevearc/conform.nvim',
    opts = function(_, opts)
      local langs = { 'javascript', 'typescript', 'javascriptreact', 'typescriptreact' }
      for _, ft in ipairs(langs) do
        opts.formatters_by_ft[ft] = { 'prettierd' }
      end
    end,
  },

  {
    'jay-babu/mason-nvim-dap.nvim',
    opts = {
      ensure_installed = { 'js' },
    },
  },

  {
    'vuki656/package-info.nvim',
    dependencies = { 'MunifTanjim/nui.nvim' },
    opts = {},
    event = 'BufRead package.json',
  },
}
