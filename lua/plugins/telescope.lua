return {
  'nvim-telescope/telescope.nvim',
  dependencies = {
    { 'nvim-lua/plenary.nvim', lazy = true },
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      lazy = true,
      build = 'make',
    },
    'nvim-treesitter/nvim-treesitter',
  },
  cmd = 'Telescope',
  keys = {
    { '<leader>ff', function() require('telescope.builtin').find_files() end, desc = 'Find files' },
    {
      '<leader>fc',
      function()
        require('telescope.builtin').find_files({
          cwd = vim.fn.stdpath('config'),
          follow = true,
          prompt_title = 'Config Files',
        })
      end,
      desc = 'Find config files',
    },
    {
      '<leader>fb',
      function() require('telescope.builtin').buffers() end,
      desc = 'Find buffers',
    },
    {
      '<leader>fC',
      function() require('telescope.builtin').commands() end,
      desc = 'Find commands',
    },
    {
      '<leader>ft',
      function() require('telescope.builtin').live_grep() end,
      desc = 'Find text',
    },
  },
  opts = function()
    local actions = require('telescope.actions')
    return {
      defaults = {
        prompt_prefix = '❯ ',
        selection_caret = ' ',
        path_display = { 'truncate' },
        sorting_strategy = 'ascending',
        layout_config = {
          horizontal = { prompt_position = 'top', preview_width = 0.55 },
          vertical = { mirror = false },
          width = 0.87,
          height = 0.80,
          preview_cutoff = 120,
        },
        mappings = {
          n = { q = actions.close },
        },
      },
    }
  end,
}
