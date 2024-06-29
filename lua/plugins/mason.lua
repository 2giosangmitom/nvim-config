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
            package_uninstalled = '󰚌',
          },
        },
      }
    end,
    config = function(_, opts)
      require('mason').setup(opts)
      local mr = require('mason-registry')
      mr:on('package:install:success', function()
        vim.defer_fn(function()
          -- trigger FileType event to possibly load this newly installed LSP server
          require('lazy.core.handler.event').trigger({
            event = 'FileType',
            buf = vim.api.nvim_get_current_buf(),
          })
        end, 100)
      end)

      mr.refresh(function()
        for _, tool in ipairs(opts.ensure_installed) do
          local p = mr.get_package(tool)
          if not p:is_installed() then p:install() end
        end
      end)
    end,
  },
}
