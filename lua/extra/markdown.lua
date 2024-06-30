return {
  {
    'stevearc/conform.nvim',
    opts = {
      formatters_by_ft = {
        ['markdown'] = { 'prettierd' },
        ['markdown.mdx'] = { 'prettierd' },
      },
    },
  },

  {
    'williamboman/mason.nvim',
    opts = {
      ensure_installed = { 'prettierd' },
    },
  },
}
