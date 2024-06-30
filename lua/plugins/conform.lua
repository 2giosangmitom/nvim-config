return {
  'stevearc/conform.nvim',
  keys = {
    {
      '<leader>cf',
      function() require('conform').format({ timeout_ms = 500, lsp_format = 'fallback' }) end,
      desc = 'Format code',
    },
  },
  opts = {
    formatters_by_ft = {},
  },
}
