return {
  {
    'nvim-tree/nvim-tree.lua',
    cmd = { 'NvimTreeToggle' },
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
      { '<leader>e', '<cmd>NvimTreeToggle<cr>', desc = 'Toggle NvimTree' },
    },
    opts = {
      view = {
        width = 30,
      },
    },
  },
}
