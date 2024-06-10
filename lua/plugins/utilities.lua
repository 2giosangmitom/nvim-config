return {
  {
    'nvim-telescope/telescope.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    keys = {
      { '<leader>ff', '<cmd>Telescope find_files<cr>', desc = 'Find files' },
    },
    cmd = 'Telescope',
    opts = {
      defaults = {},
    },
  },

  {
    'chrisgrieser/nvim-genghis',
    cmd = {
      'New',
      'Duplicate',
      'NewFromSelection',
      'Rename',
      'Move',
      'MoveToFolderInCwd',
    },
    dependencies = 'stevearc/dressing.nvim',
  },
}
