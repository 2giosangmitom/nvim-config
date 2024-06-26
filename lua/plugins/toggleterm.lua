return {
  'akinsho/toggleterm.nvim',
  cmd = { 'ToggleTerm', 'TermExec' },
  keys = function()
    local Terminal = require('toggleterm.terminal').Terminal

    return {
      { '<leader>Tf', '<cmd>ToggleTerm direction=float<cr>', desc = 'ToggleTerm float' },
      { '<leader>Th', '<cmd>ToggleTerm size=15 direction=horizontal<cr>', desc = 'ToggleTerm horizontal' },
      {
        '<leader>gg',
        function()
          local lazygit = Terminal:new({ cmd = 'lazygit', hidden = true, display_name = 'Lazygit' })
          lazygit:toggle()
        end,
        desc = 'Lazygit',
      },
    }
  end,
  opts = {
    shading_factor = 2,
    direction = 'float',
    float_opts = { border = 'rounded' },
    size = 20,
    open_mapping = [[<c-\>]],
    highlights = {
      Normal = { link = 'Normal' },
      NormalNC = { link = 'NormalNC' },
      NormalFloat = { link = 'NormalFloat' },
      FloatBorder = { link = 'FloatBorder' },
      StatusLine = { link = 'StatusLine' },
      StatusLineNC = { link = 'StatusLineNC' },
      WinBar = { link = 'WinBar' },
      WinBarNC = { link = 'WinBarNC' },
    },
  },
}
