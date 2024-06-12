return {
  {
    '2giosangmitom/nightfall.nvim',
    lazy = false,
    priority = 1000,
    init = function() vim.g.nightfall_debug = true end,
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
            St_cwd_icon = { fg = colors.black, bg = colors.light_cyan },
            St_cwd_text = { fg = colors.light_cyan, bg = colors.dark_navy },
            St_cwd_sep = { fg = colors.light_cyan, bg = colors.statusline_bg },
            St_pos_sep = { fg = colors.green, bg = colors.dark_navy },
            St_pos_icon = { fg = colors.black, bg = colors.green },
            St_pos_text = { fg = colors.green, bg = colors.dark_navy },
            St_lspError = { bg = colors.statusline_bg, fg = colors.red },
            St_lspWarning = { bg = colors.statusline_bg, fg = colors.pale_yellow },
            St_lspHints = { bg = colors.statusline_bg, fg = colors.violet },
            St_lspInfo = { bg = colors.statusline_bg, fg = colors.light_cyan },
            St_gitbranch = { fg = colors.pink, bg = colors.statusline_bg, bold = true },
            St_gitadded = { fg = colors.green, bg = colors.statusline_bg },
            St_gitremoved = { fg = colors.red, bg = colors.statusline_bg },
            St_gitmodified = { fg = colors.sky, bg = colors.statusline_bg },
            St_lspSv = { fg = colors.peach, bg = colors.statusline_bg },
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
        ['<leader>x'] = { name = '+diagnostics/quickfix' },
        [']'] = { name = '+next' },
        ['['] = { name = '+prev' },
        ['<leader><tab>'] = { name = '+tabs' },
        ['<leader>b'] = { name = '+buffer' },
        ['<leader>w'] = { name = '+windows' },
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
      max_height = function() return math.floor(vim.o.lines * 0.75) end,
      max_width = function() return math.floor(vim.o.columns * 0.75) end,
      on_open = function(win) vim.api.nvim_win_set_config(win, { zindex = 100 }) end,
    },
    init = function() vim.notify = require('notify') end,
  },
  {
    'nvimdev/dashboard-nvim',
    init = function()
      if vim.fn.argc() == 0 then require('dashboard') end
    end,
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
        hide = { statusline = false },
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
          callback = function() require('lazy').show() end,
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
      scope = {
        show_start = false,
        show_end = false,
      },
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
  {
    'folke/trouble.nvim',
    opts = {},
    cmd = 'Trouble',
    keys = {
      { '<leader>xx', '<cmd>Trouble diagnostics toggle<cr>', desc = 'Diagnostics (Trouble)' },
      { '<leader>xX', '<cmd>Trouble diagnostics toggle filter.buf=0<cr>', desc = 'Buffer Diagnostics (Trouble)' },
      { '<leader>cs', '<cmd>Trouble symbols toggle focus=false<cr>', desc = 'Symbols (Trouble)' },
      { '<leader>xL', '<cmd>Trouble loclist toggle<cr>', desc = 'Location List (Trouble)' },
      { '<leader>xQ', '<cmd>Trouble qflist toggle<cr>', desc = 'Quickfix List (Trouble)' },
    },
  },
  {
    'akinsho/bufferline.nvim',
    event = { 'BufReadPost', 'BufNewFile' },
    dependencies = 'nvim-tree/nvim-web-devicons',
    keys = {
      { '<leader>bp', '<Cmd>BufferLineTogglePin<CR>', desc = 'Toggle Pin' },
      { '<leader>bP', '<Cmd>BufferLineGroupClose ungrouped<CR>', desc = 'Delete Non-Pinned Buffers' },
      { '<leader>bo', '<Cmd>BufferLineCloseOthers<CR>', desc = 'Delete Other Buffers' },
      { '<leader>br', '<Cmd>BufferLineCloseRight<CR>', desc = 'Delete Buffers to the Right' },
      { '<leader>bl', '<Cmd>BufferLineCloseLeft<CR>', desc = 'Delete Buffers to the Left' },
      { '<S-h>', '<cmd>BufferLineCyclePrev<cr>', desc = 'Prev Buffer' },
      { '<S-l>', '<cmd>BufferLineCycleNext<cr>', desc = 'Next Buffer' },
      { '[b', '<cmd>BufferLineCyclePrev<cr>', desc = 'Prev Buffer' },
      { ']b', '<cmd>BufferLineCycleNext<cr>', desc = 'Next Buffer' },
      { '[B', '<cmd>BufferLineMovePrev<cr>', desc = 'Move buffer prev' },
      { ']B', '<cmd>BufferLineMoveNext<cr>', desc = 'Move buffer next' },
    },
    init = function()
      vim.api.nvim_create_autocmd({ 'BufAdd', 'BufDelete' }, {
        callback = function()
          vim.schedule(function() pcall(nvim_bufferline) end)
        end,
      })
    end,
    opts = {
      options = {
        diagnostics = 'nvim_lsp',
        always_show_bufferline = true,
        diagnostics_indicator = function(_, _, diag)
          local icons = require('config.icons').diagnostics
          local ret = (diag.error and icons.Error .. ' ' .. diag.error .. ' ' or '')
            .. (diag.warning and icons.Warning .. ' ' .. diag.warning or '')
          return vim.trim(ret)
        end,
      },
    },
  },
}
