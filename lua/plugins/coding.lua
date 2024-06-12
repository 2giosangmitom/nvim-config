return {
  {
    'Saecki/crates.nvim',
    event = { 'BufRead Cargo.toml' },
    opts = {
      completion = {
        cmp = { enabled = true },
      },
    },
  },

  {
    'mrcjkb/rustaceanvim',
    version = '^4', -- Recommended
    ft = { 'rust' },
    opts = {
      server = {
        on_attach = function(_, bufnr)
          vim.keymap.set('n', '<leader>ca', function()
            vim.cmd.RustLsp('codeAction')
          end, { desc = 'Code Action', buffer = bufnr })
          vim.keymap.set('n', '<leader>dr', function()
            vim.cmd.RustLsp('debuggables')
          end, { desc = 'Rust Debuggables', buffer = bufnr })
        end,
        default_settings = {
          -- rust-analyzer language server configuration
          ['rust-analyzer'] = {
            cargo = {
              allFeatures = true,
              loadOutDirsFromCheck = true,
              buildScripts = {
                enable = true,
              },
            },
            -- Add clippy lints for Rust.
            checkOnSave = {
              allFeatures = true,
              command = 'clippy',
              extraArgs = { '--no-deps' },
            },
            procMacro = {
              enable = true,
              ignored = {
                ['async-trait'] = { 'async_trait' },
                ['napi-derive'] = { 'napi' },
                ['async-recursion'] = { 'async_recursion' },
              },
            },
          },
        },
      },
    },
    config = function(_, opts)
      vim.g.rustaceanvim = vim.tbl_deep_extend('keep', vim.g.rustaceanvim or {}, opts or {})
    end,
  },

  {
    'ray-x/go.nvim',
    dependencies = {
      'ray-x/guihua.lua',
      'neovim/nvim-lspconfig',
      'nvim-treesitter/nvim-treesitter',
    },
    ft = { 'go', 'gomod' },
    opts = {
      disable_defaults = true,
      diagnostic = false,
    },
  },

  {
    'folke/lazydev.nvim',
    ft = 'lua',
    dependencies = 'Bilal2453/luvit-meta',
    opts = {
      library = {
        { path = 'luvit-meta/library', words = { 'vim%.uv' } },
      },
    },
  },

  {
    'neovim/nvim-lspconfig',
    event = { 'BufReadPost', 'BufNewFile' },
    dependencies = {
      'williamboman/mason.nvim',
      {
        'nvimdev/lspsaga.nvim',
        opts = {
          symbol_in_winbar = {
            show_file = true,
            folder_level = 0,
          },
          hover = {
            open_cmd = '!xdg-open',
          },
          lightbulb = {
            enable = false,
          },
        },
      },
    },
    opts = function()
      local icons = require('config.icons')

      return {
        servers = { 'lua_ls', 'dockerls', 'docker_compose_language_service', 'gopls', 'vtsls', 'volar' },
        ui = {
          border = 'rounded',
        },
        diagnostics = {
          underline = true,
          update_in_insert = false,
          virtual_text = {
            spacing = 4,
            source = 'if_many',
          },
          severity_sort = true,
          signs = {
            text = {
              [vim.diagnostic.severity.ERROR] = icons.diagnostics.Error,
              [vim.diagnostic.severity.WARN] = icons.diagnostics.Warning,
              [vim.diagnostic.severity.HINT] = icons.diagnostics.Hint,
              [vim.diagnostic.severity.INFO] = icons.diagnostics.Infomation,
            },
          },
        },
      }
    end,
    config = function(_, opts)
      local utils = require('utils')
      -- Border
      vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, { border = opts.ui.border })
      vim.lsp.handlers['textDocument/signatureHelp'] =
        vim.lsp.with(vim.lsp.handlers.signature_help, { border = opts.ui.border })
      require('lspconfig.ui.windows').default_options.border = opts.ui.border

      -- Diagnostics
      vim.diagnostic.config(opts.diagnostics)

      -- Setup keymaps
      utils.on_attach(function(_, bufnr)
        local function map(key, cmd, desc)
          vim.keymap.set('n', key, cmd, { desc = desc, buffer = bufnr })
        end
        map('K', '<cmd>Lspsaga hover_doc<cr>', 'Hover')
        map('<leader>ci', '<cmd>Lspsaga incoming_calls<cr>', 'Incoming calls')
        map('<leader>co', '<cmd>Lspsaga outgoing_calls<cr>', 'Outgoing calls')
        map('<leader>ca', '<cmd>Lspsaga code_action<cr>', 'Code action')
        map('<leader>cd', '<cmd>Lspsaga peek_definition<cr>', 'Peek definition')
        map('gd', '<cmd>Lspsaga goto_definition<cr>', 'Goto Definition')
        map('gr', '<cmd>Telescope lsp_references<cr>', 'References')
        map(']d', '<cmd>Lspsaga diagnostic_jump_next<cr>', 'Next diagnostic')
        map('[d', '<cmd>Lspsaga diagnostic_jump_prev<cr>', 'Previous diagnostic')
        map('<leader>cr', '<cmd>Lspsaga rename<cr>', 'Rename')
        map('gD', vim.lsp.buf.declaration, 'Goto Declaration')
        map('gI', function()
          require('telescope.builtin').lsp_implementations({ reuse_win = true })
        end, 'Goto Implementation')
      end)

      -- Setup servers
      for _, server in ipairs(opts.servers) do
        local server_opts = {}
        local ok, settings = pcall(require, 'lsp.' .. server)
        if ok then
          server_opts = vim.tbl_deep_extend('force', settings, server_opts)
        end
        require('lspconfig')[server].setup(server_opts)
      end
    end,
  },

  {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
    },
    opts = function()
      local cmp = require('cmp')
      return {
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        preselect = 'item',
        completion = {
          completeopt = 'menu,menuone,noinsert',
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-n>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
          ['<C-p>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
          ['<C-u>'] = cmp.mapping.scroll_docs(-4),
          ['<C-d>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.abort(),
          ['<Tab>'] = cmp.mapping.confirm({ select = false }),
        }),
        formatting = {
          fields = { 'menu', 'abbr', 'kind' },
          format = function(_, item)
            local icons = require('config.icons').kinds
            if icons[item.kind] then
              item.kind = icons[item.kind] .. item.kind
            end
            return item
          end,
        },
        sources = cmp.config.sources({
          { name = 'snippets' },
          { name = 'nvim_lsp' },
          { name = 'path' },
          { name = 'crates' },
        }, {
          { name = 'buffer' },
        }),
      }
    end,
  },
}
