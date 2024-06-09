return {
  {
    '2giosangmitom/nightfall.nvim',
    lazy = false,
    priority = 1000,
    init = function()
      vim.g.nightfall_debug = true
    end,
    opts = {
      integrations = {
        flash = { enabled = true },
        headlines = { enabled = true },
      },
      highlight_overrides = {
        nightfall = function(colors)
          return {
            St_nMode = { bg = colors.violet, fg = colors.black },
            St_iMode = { bg = colors.green, fg = colors.black },
            St_vMode = { bg = colors.nord_blue, fg = colors.black },
          }
        end,
      },
    },
    config = function(_, opts)
      require('nightfall').setup(opts)
      vim.cmd('colorscheme nightfall')
    end,
  },

  {
    'j-hui/fidget.nvim',
    event = 'LspAttach',
    opts = {},
  },
}
