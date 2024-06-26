return {
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
}
