return {
  {
    'stevearc/conform.nvim',
    opts = {
      formatters_by_ft = {
        typst = { 'typstfmt' },
      },
    },
  },

  {
    'williamboman/mason.nvim',
    opts = {
      ensure_installed = { 'typstfmt' },
    },
  },
}
