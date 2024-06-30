return {
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      {
        'Saecki/crates.nvim',
        event = { 'BufRead Cargo.toml' },
        opts = {
          completion = {
            cmp = { enabled = true },
          },
        },
      },
    },
    opts = function(_, opts)
      opts.sources = opts.sources or {}
      table.insert(opts.sources, { name = 'crates' })
    end,
  },

  {
    'nvim-treesitter/nvim-treesitter',
    opts = { ensure_installed = { 'rust', 'toml' } },
  },

  {
    'jay-babu/mason-nvim-dap.nvim',
    opts = { ensure_installed = { 'codelldb' } },
  },

  {
    'mrcjkb/rustaceanvim',
    ft = { 'rust' },
    opts = {
      server = {
        on_attach = function(_, bufnr)
          vim.keymap.set(
            'n',
            '<leader>cR',
            function() vim.cmd.RustLsp('codeAction') end,
            { desc = 'Code Action', buffer = bufnr }
          )
          vim.keymap.set(
            'n',
            '<leader>dr',
            function() vim.cmd.RustLsp('debuggables') end,
            { desc = 'Rust Debuggables', buffer = bufnr }
          )
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
            checkOnSave = true,
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
    config = function(_, opts) vim.g.rustaceanvim = vim.tbl_deep_extend('keep', vim.g.rustaceanvim or {}, opts or {}) end,
  },

  {
    'neovim/nvim-lspconfig',
    opts = {
      servers = {
        taplo = {
          keys = {
            {
              'K',
              function()
                if vim.fn.expand('%:t') == 'Cargo.toml' and require('crates').popup_available() then
                  require('crates').show_popup()
                else
                  vim.lsp.buf.hover()
                end
              end,
              desc = 'Show Crate Documentation',
            },
          },
        },
      },
    },
  },

  {
    'nvim-neotest/neotest',
    opts = function(_, opts) table.insert(opts.adapters, require('rustaceanvim.neotest')) end,
  },
}
