return {
  '2giosangmitom/nightfall.nvim',
  lazy = false,
  priority = 1000,
  init = function() vim.g.nightfall_debug = true end,
  opts = {
    integrations = {
      flash = { enabled = true },
      headlines = { enabled = true },
      nvim_dap = { enabled = true },
    },
    highlight_overrides = {
      nightfall = function(colors)
        return {
          St_pos_sep = { fg = colors.green, bg = colors.deep_navy },
          St_pos_icon = { fg = colors.black, bg = colors.green },
          St_pos_text = { fg = colors.green, bg = colors.deep_navy },
          St_cwd_icon = { fg = colors.black, bg = colors.light_cyan },
          St_cwd_text = { fg = colors.light_cyan, bg = colors.deep_navy },
          St_cwd_sep = { fg = colors.light_cyan, bg = colors.statusline_bg },
          St_lspSv = { fg = colors.peach, bg = colors.statusline_bg },
          DapStoppedLine = { default = true, link = 'Visual' },
        }
      end,
      maron = function(colors)
        return {
          St_pos_sep = { fg = colors.green, bg = colors.deep_navy },
          St_pos_icon = { fg = colors.black, bg = colors.green },
          St_pos_text = { fg = colors.green, bg = colors.deep_navy },
          St_cwd_icon = { fg = colors.black, bg = colors.light_cyan },
          St_cwd_text = { fg = colors.light_cyan, bg = colors.deep_navy },
          St_cwd_sep = { fg = colors.light_cyan, bg = colors.statusline_bg },
          St_lspSv = { fg = colors.peach, bg = colors.statusline_bg },
          DapStoppedLine = { default = true, link = 'Visual' },
        }
      end,
      deepernight = function(colors)
        return {
          St_pos_sep = { fg = colors.green, bg = colors.deep_navy },
          St_pos_icon = { fg = colors.black, bg = colors.green },
          St_pos_text = { fg = colors.green, bg = colors.deep_navy },
          St_cwd_icon = { fg = colors.black, bg = colors.light_cyan },
          St_cwd_text = { fg = colors.light_cyan, bg = colors.deep_navy },
          St_cwd_sep = { fg = colors.light_cyan, bg = colors.statusline_bg },
          St_lspSv = { fg = colors.peach, bg = colors.statusline_bg },
          DapStoppedLine = { default = true, link = 'Visual' },
        }
      end,
    },
  },
  config = function(_, opts)
    require('nightfall').setup(opts)
    vim.cmd('colorscheme maron')
  end,
}
