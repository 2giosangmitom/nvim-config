return {
  '2giosangmitom/nightfall.nvim',
  lazy = false,
  priority = 1000,
  init = function() vim.g.nightfall_debug = true end,
  opts = {
    integrations = {
      flash = { enabled = true },
      headlines = { enabled = true },
    },
  },
  config = function(_, opts)
    require('nightfall').setup(opts)
    vim.cmd('colorscheme nightfall')
  end,
}
