return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        gopls = {}
      }
    }
  },

  {
    'nvim-treesitter/nvim-treesitter',
    opts = {
      ensure_installed = { 'go', 'gomod', 'gosum', 'gowork' },
    },
  },
}
