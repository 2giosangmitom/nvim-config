return {
  'nvim-neo-tree/neo-tree.nvim',
  dependencies = {
    { 'nvim-lua/plenary.nvim', lazy = true },
    { 'MunifTanjim/nui.nvim', lazy = true },
    { 'nvim-tree/nvim-web-devicons', lazy = true },
  },
  keys = {
    { '<leader>e', '<cmd>Neotree toggle<cr>', desc = 'Toggle Explorer' },
  },
  opts = function()
    local icons = require('config.icons')

    return {
      close_if_last_window = false,
      popup_border_style = 'rounded',
      enable_git_status = true,
      enable_diagnostics = true,
      open_files_do_not_replace_types = { 'terminal', 'trouble', 'qf' },
      sort_case_insensitive = false,
      default_component_configs = {
        icon = {
          folder_closed = icons.ui.Dir,
          folder_open = icons.ui.DirOpen,
          folder_empty = '󰜌',
        },
        modified = {
          symbol = '',
        },
        git_status = {
          symbols = {
            added = icons.git.Added,
            modified = icons.git.Changed,
            deleted = icons.git.Deleted,
            renamed = icons.git.Renamed,
            untracked = icons.git.Untracked,
            ignored = icons.git.Ignored,
            unstaged = icons.git.Unstaged,
            staged = icons.git.Staged,
            conflict = icons.git.Conflict,
          },
        },
      },
    }
  end,
}
