return {
  {
    'nvim-tree/nvim-tree.lua',
    cmd = { 'NvimTreeToggle' },
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    keys = {
      { '<leader>e', '<cmd>NvimTreeToggle<cr>', desc = 'Toggle NvimTree' },
    },
    opts = {
      view = {
        width = 30,
      },
    },
  },

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
