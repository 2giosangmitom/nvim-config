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

  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    opts = {
      check_ts = true,
      ts_config = { java = false },
      fast_wrap = {
        map = '<M-e>',
        chars = { '{', '[', '(', '"', "'" },
        pattern = ([[ [%'%"%)%>%]%)%}%,] ]]):gsub('%s+', ''),
        offset = 0,
        end_key = '$',
        keys = 'qwertyuiopzxcvbnmasdfghjkl',
        check_comma = true,
        highlight = 'PmenuSel',
        highlight_grey = 'LineNr',
      },
    },
    config = function(_, opts)
      local npairs = require('nvim-autopairs')
      npairs.setup(opts)
      require('cmp').event:on('confirm_done', require('nvim-autopairs.completion.cmp').on_confirm_done({ tex = false }))
    end,
  },

  {
    'mikavilpas/yazi.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    keys = {
      {
        '<leader>e',
        function() require('yazi').yazi() end,
        desc = 'Open the file manager',
      },
      {
        '<leader>E',
        function() require('yazi').yazi(nil, vim.fn.getcwd()) end,
        desc = 'Open the file manager (cwd)',
      },
    },
    opts = {},
  },
}
