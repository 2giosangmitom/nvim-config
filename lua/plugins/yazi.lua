return {
  'mikavilpas/yazi.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  keys = {
    { '<leader>E', function() require('yazi').yazi() end, desc = 'Open the file manager (Yazi)' },
  },
}
