return {
  {
    '2giosangmitom/nightfall.nvim',
    lazy = false,
    priority = 1000,
    init = function()
      vim.g.nightfall_debug = true
    end,
    opts = {
      integrations = {
        flash = { enabled = true },
        headlines = { enabled = true },
      },
      highlight_overrides = {
        ---@param colors NightfallPalette
        nightfall = function(colors)
          local res = {
            St_EmptySpace = { fg = colors.grey, bg = colors.deep_navy },
            St_file = { bg = colors.dark_navy, fg = colors.ghost_white },
            St_file_sep = { fg = colors.dark_navy, bg = colors.statusline_bg },
            St_gitIcons = { fg = colors.ghost_white, bg = colors.statusline_bg },
            St_cwd_icon = { fg = colors.black, bg = colors.red },
            St_cwd_text = { fg = colors.red, bg = colors.dark_navy },
            St_cwd_sep = { fg = colors.red, bg = colors.statusline_bg },
            St_pos_sep = { fg = colors.green, bg = colors.dark_navy },
            St_pos_icon = { fg = colors.black, bg = colors.green },
            St_pos_text = { fg = colors.green, bg = colors.dark_navy },
            St_lspError = { bg = colors.statusline_bg, fg = colors.red },
            St_lspWarning = { bg = colors.statusline_bg, fg = colors.pale_yellow },
            St_lspHints = { bg = colors.statusline_bg, fg = colors.violet },
            St_lspInfo = { bg = colors.statusline_bg, fg = colors.light_cyan },
            St_gitbranch = { fg = colors.pink,bg = colors.statusline_bg, bold = true },
            St_gitadded = { fg = colors.green,bg = colors.statusline_bg },
            St_gitremoved = { fg = colors.red,bg = colors.statusline_bg },
            St_gitmodified = { fg = colors.sky,bg = colors.statusline_bg },
          }
          local function genModes_hl(modename, col)
            res['St_' .. modename .. 'Mode'] = { fg = colors.black, bg = colors[col], bold = true }
            res['St_' .. modename .. 'ModeSep'] = { fg = colors[col], bg = colors.grey }
          end
          genModes_hl('Normal', 'violet')
          genModes_hl('Visual', 'nord_blue')
          genModes_hl('Insert', 'green')
          genModes_hl('Terminal', 'peach')
          genModes_hl('NTerminal', 'pale_yellow')
          genModes_hl('Replace', 'red')
          genModes_hl('Confirm', 'pink')
          genModes_hl('Command', 'sky')
          genModes_hl('Select', 'turquoise')
          return res
        end,
      },
    },
    config = function(_, opts)
      require('nightfall').setup(opts)
      vim.cmd('colorscheme nightfall')
    end,
  },

  {
    'j-hui/fidget.nvim',
    event = 'LspAttach',
    opts = {},
  },

  {
    'folke/which-key.nvim',
    event = 'VeryLazy',
    opts = {
      defaults = {
        mode = { 'n', 'v' },
        g = { name = '+goto' },
        gs = { name = '+surround' },
        z = { name = '+fold' },
        ['<leader>c'] = { name = '+code' },
        ['<leader>f'] = { name = '+file/find' },
        ['<leader>p'] = { name = '+packages' },
      },
    },
    config = function(_, opts)
      local wk = require('which-key')
      wk.setup(opts)
      wk.register(opts.defaults)
    end,
  },

  {
    'rcarriga/nvim-notify',
    opts = {
      stages = 'static',
      timeout = 3000,
      max_height = function()
        return math.floor(vim.o.lines * 0.75)
      end,
      max_width = function()
        return math.floor(vim.o.columns * 0.75)
      end,
      on_open = function(win)
        vim.api.nvim_win_set_config(win, { zindex = 100 })
      end,
    },
    init = function()
      vim.notify = require('notify')
    end,
  },

  {
    'nvimdev/dashboard-nvim',
    lazy = false,
    opts = function()
      local logo = [[
██████╗ ██╗  ██╗███████╗██╗      ██████╗ ██╗
██╔══██╗██║  ██║██╔════╝██║     ██╔═══██╗██║
██████╔╝███████║█████╗  ██║     ██║   ██║██║
██╔═══╝ ██╔══██║██╔══╝  ██║     ██║   ██║██║
██║     ██║  ██║███████╗███████╗╚██████╔╝██║
╚═╝     ╚═╝  ╚═╝╚══════╝╚══════╝ ╚═════╝ ╚═╝
      ]]

      logo = string.rep('\n', 8) .. logo .. '\n\n'

      local opts = {
        theme = 'doom',
        hide = {
          statusline = false,
        },
        config = {
          header = vim.split(logo, '\n'),
          center = {
            { action = 'Telescope find_files', desc = ' Find File', icon = ' ', key = 'f' },
            { action = 'ene | startinsert', desc = ' New File', icon = ' ', key = 'n' },
            { action = 'Telescope oldfiles', desc = ' Recent Files', icon = ' ', key = 'r' },
            { action = 'Telescope live_grep', desc = ' Find Text', icon = ' ', key = 'g' },
            { action = 'Lazy', desc = ' Lazy', icon = '󰒲 ', key = 'l' },
            { action = 'qa', desc = ' Quit', icon = ' ', key = 'q' },
          },
          footer = function()
            local stats = require('lazy').stats()
            local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
            return { '⚡ Neovim loaded ' .. stats.loaded .. '/' .. stats.count .. ' plugins in ' .. ms .. 'ms' }
          end,
        },
      }

      for _, button in ipairs(opts.config.center) do
        button.desc = button.desc .. string.rep(' ', 43 - #button.desc)
        button.key_format = '  %s'
      end

      if vim.o.filetype == 'lazy' then
        vim.cmd('close')
        vim.api.nvim_create_autocmd('User', {
          pattern = 'DashboardLoaded',
          callback = function()
            require('lazy').show()
          end,
        })
      end

      return opts
    end,
  },

  {
    'lewis6991/gitsigns.nvim',
    event = { 'BufReadPost', 'BufNewFile' },
    opts = {},
  },

  {
    'stevearc/dressing.nvim',
    lazy = true,
    init = function()
      for _, func in ipairs({ 'select', 'input' }) do
        vim.ui[func] = function(...)
          require('lazy').load({ plugins = { 'dressing.nvim' } })
          return vim.ui[func](...)
        end
      end
    end,
    opts = {
      input = { default_prompt = '➤ ' },
      select = { backend = { 'telescope', 'builtin' } },
    },
  },

  {
    'lukas-reineke/indent-blankline.nvim',
    event = { 'BufReadPost', 'BufNewFile' },
    opts = {
      indent = {
        char = '│',
        tab_char = '│',
      },
      scope = { show_start = false, show_end = false },
      exclude = {
        filetypes = {
          'help',
          'dashboard',
          'lazy',
          'mason',
          'notify',
          'toggleterm',
        },
      },
    },
    main = 'ibl',
  },
}
