return {
  {
    'neovim/nvim-lspconfig',
    opts = {
      servers = {
        nil_ls = {
          mason = false,
        },
      },
    },
  },

  {
    'stevearc/conform.nvim',
    opts = {
      formatters_by_ft = {
        nix = { 'alejandra' },
      },
    },
  },
}
