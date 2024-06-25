return {
  'folke/which-key.nvim',
  event = 'VeryLazy',
  opts = {
    plugins = { spelling = true },
    icons = {
      group = '',
      separator = '-',
    },
    disable = { filetypes = { 'TelescopePrompt' } },
  },
  config = function(_, opts)
    local wk = require('which-key')
    wk.setup(opts)
    wk.register({
      mode = { 'n', 'v' },
      ['<leader><tab>'] = { name = '󰓩 Tabs' },
      ['<leader>b'] = { name = '󰓩 Buffers' },
      ['<leader>c'] = { name = ' Code' },
      ['<leader>f'] = { name = ' Find' },
      ['<leader>g'] = { name = '󰊢 Git' },
      ['<leader>gh'] = { name = 'Hunks', ['_'] = 'which_key_ignore' },
      ['<leader>u'] = { name = ' UI' },
      ['<leader>w'] = { name = ' Windows' },
      ['<leader>x'] = { name = '󰒡 Diagnostics/Quickfix' },
      ['<leader>T'] = { name = ' Terminal' },
      ['<leader>t'] = { name = '󰙨 Test' },
      ['<leader>s'] = { name = '󰛔 Search/Replace' },
    })
  end,
}
