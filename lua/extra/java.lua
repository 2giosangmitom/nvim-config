return {
  {
    'nvim-treesitter/nvim-treesitter',
    opts = {
      ensure_installed = { 'java' },
    },
  },

  {
    'williamboman/mason.nvim',
    opts = {
      registries = {
        'github:nvim-java/mason-registry',
        'github:mason-org/mason-registry',
      },
    },
  },

  {
    'nvim-java/nvim-java',
    config = false,
    ft = { 'java' },
    dependencies = {
      {
        'neovim/nvim-lspconfig',
        opts = {
          servers = {
            jdtls = {},
          },
          setup = {
            jdtls = function()
              require('java').setup({
                jdk = {
                  auto_install = false,
                },
              })
            end,
          },
        },
      },
    },
  },
}
