return {
  'Zeioth/compiler.nvim',
  cmd = { 'CompilerOpen', 'CompilerToggleResults', 'CompilerRedo' },
  dependencies = { 'stevearc/overseer.nvim', 'nvim-telescope/telescope.nvim' },
  keys = {
    { '<leader>cb', '<cmd>CompilerOpen<cr>', desc = 'Open compiler' },
    { '<leader>uc', '<cmd>CompilerToggleResults<cr>', desc = 'Toggle compiler result' },
  },
  opts = {},
}
