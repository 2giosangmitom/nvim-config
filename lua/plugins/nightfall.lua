return {
  "2giosangmitom/nightfall.nvim",
  dir = "~/Workspace/neovim-plugins/nightfall.nvim",
  init = function()
    vim.g.nightfall_debug = true
  end,
  opts = {
    integrations = {
      headlines = { enabled = true },
    },
  },
}
