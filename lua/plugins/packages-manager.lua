return {
  {
    'williamboman/mason.nvim',
    event = { 'BufReadPost', 'BufNewFile' },
    keys = {
      { '<leader>pm', '<cmd>Mason<cr>', desc = 'Mason' },
    },
    opts = {
      ui = {
        icons = {
          package_pending = '',
          package_installed = '󰄳',
          package_uninstalled = '󰚌',
        },
      },
    },
  },
}
