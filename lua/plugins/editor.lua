return {
  'nvim-tree/nvim-web-devicons',

  {
    'akinsho/toggleterm.nvim',
    keys = {
      { '<leader>t', '<cmd>ToggleTerm<cr>', desc = 'Toggle terminal' },
    },
    cmd = 'ToggleTerm',
    opts = {
      shell = 'fish',
    },
  },
}
