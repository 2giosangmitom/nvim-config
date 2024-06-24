return {
  'nvim-lualine/lualine.nvim',
  event = 'VeryLazy',
  opts = function()
    -- PERF: We don't need this lualine_require madness 🤷
    local lualine_require = require('lualine_require')
    lualine_require.require = require
    local icons = require('config.icons')

    local function cursor()
      local cur, total = vim.fn.line('.'), vim.fn.line('$')
      if cur == 1 then
        return string.format('%%#St_pos_sep#%s%%#St_pos_icon# %%#St_pos_text# Top ', '')
      elseif cur == total then
        return string.format('%%#St_pos_sep#%s%%#St_pos_icon# %%#St_pos_text# Bot ', '')
      else
        return string.format(
          '%%#St_pos_sep#%s%%#St_pos_icon# %%#St_pos_text# %2d%%%% ',
          '',
          math.floor(cur / total * 100)
        )
      end
    end

    local function get_cwd()
      local cwd = vim.uv.cwd()
      if not cwd then return '' end
      local cwd_name = cwd:match('([^/\\]+)$') or cwd
      return vim.o.columns > 85
          and string.format(
            '%%#St_cwd_sep#%s%%#St_cwd_icon#' .. icons.ui.Dir .. ' %%#St_cwd_text# %s ',
            '',
            cwd_name
          )
        or ''
    end

    local function lsp_clients()
      local buf = vim.api.nvim_win_get_buf(0)
      local clients = vim.lsp.get_clients({ bufnr = 0 })
      if #clients == 0 then return '' end
      local client_names = {}
      for _, client in ipairs(clients) do
        if client.attached_buffers[buf] then table.insert(client_names, client.name) end
      end
      return '%#St_lspSv#   LSP ~ ' .. table.concat(client_names, ', ') .. ' '
    end

    return {
      options = {
        theme = 'auto',
        globalstatus = true,
        disabled_filetypes = { statusline = { 'dashboard' } },
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
      },
      sections = {
        lualine_a = { { 'mode', fmt = function(m) return ' ' .. m end, separator = { right = '' } } },
        lualine_b = { { 'branch', icon = { icons.git.Branch }, separator = { right = '' } } },
        lualine_c = {},
        lualine_x = {
          {
            'diagnostics',
            symbols = {
              error = icons.diagnostics.Error,
              warn = icons.diagnostics.Warn,
              info = icons.diagnostics.Info,
              hint = icons.diagnostics.Hint,
            },
          },
          lsp_clients(),
          { get_cwd(), padding = { right = 0, left = 0 } },
          { cursor(), padding = { right = 0, left = 0 } },
        },
        lualine_y = {},
        lualine_z = {},
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {},
      },
      extensions = { 'lazy' },
    }
  end,
}
