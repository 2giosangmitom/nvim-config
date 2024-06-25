return {
  {
    'williamboman/mason.nvim',
    cmd = 'Mason',
    build = ':MasonUpdate',
    opts_extend = { 'ensure_installed' },
    opts = function()
      local icons = require('config.icons')
      return {
        ensure_installed = {},
        ui = {
          icons = {
            package_pending = icons.ui.Pending,
            package_installed = icons.ui.CheckMark,
            package_uninstalled = '󰚌 ',
          },
        },
      }
    end,
  },
}
