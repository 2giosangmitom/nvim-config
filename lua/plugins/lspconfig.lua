return {
  {
    'neovim/nvim-lspconfig',
    event = { 'BufReadPost', 'BufNewFile' },
    dependencies = {
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      { 'VonHeikemen/lsp-zero.nvim', branch = 'v3.x' },
    },
    opts = {
      servers = {},
      setup = {},
    },
    config = function(_, opts)
      local Keys = require('lazy.core.handler.keys')
      local icons = require('config.icons')
      local servers = opts.servers
      local has_cmp, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
      local lsp_zero = require('lsp-zero')
      local capabilities = vim.tbl_deep_extend(
        'force',
        {},
        vim.lsp.protocol.make_client_capabilities(),
        has_cmp and cmp_nvim_lsp.default_capabilities() or {},
        opts.capabilities or {}
      )

      -- Setup keymaps
      lsp_zero.on_attach(function(_, bufnr)
        lsp_zero.default_keymaps({
          buffer = bufnr,
          preserve_mappings = false,
          exclude = { 'gl', '<F4>', '<F3>', '<F2>', 'gr' },
        })

        local keymaps = {
          { 'gr', require('telescope.builtin').lsp_references, buffer = bufnr, desc = 'References' },
          { '<leader>ca', vim.lsp.buf.code_action, buffer = bufnr, desc = 'Code Action' },
          { '<leader>cr', vim.lsp.buf.rename, buffer = bufnr, desc = 'Rename' },
          { '<leader>cc', vim.lsp.codelens.run, buffer = bufnr, desc = 'Run codelens' },
          { '<leader>cC', vim.lsp.codelens.refresh, buffer = bufnr, desc = 'Refresh & Display Codelens' },
        }

        for _, keymap in ipairs(keymaps) do
          local key_opts = Keys.opts(keymap)
          ---@diagnostic disable-next-line: param-type-mismatch
          vim.keymap.set(keymap.mode or 'n', keymap[1], keymap[2], key_opts)
        end
      end)

      -- Setup diagnostics
      vim.diagnostic.config({
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
            [vim.diagnostic.severity.WARN] = icons.diagnostics.Warn,
            [vim.diagnostic.severity.HINT] = icons.diagnostics.Hint,
            [vim.diagnostic.severity.INFO] = icons.diagnostics.Info,
          },
        },
      })

      -- Function to setup LSP server
      local function setup(server)
        local server_opts = vim.tbl_deep_extend('force', {
          capabilities = vim.deepcopy(capabilities),
        }, servers[server] or {})

        if server_opts.keys then
          for _, keymap in ipairs(server_opts.keys) do
            local key_opts = Keys.opts(keymap)
            ---@diagnostic disable-next-line: param-type-mismatch
            vim.keymap.set(keymap.mode or 'n', keymap[1], keymap[2], key_opts)
          end
        end

        if opts.setup[server] then
          if opts.setup[server](server, server_opts) then return end
        end
        require('lspconfig')[server].setup(server_opts)
      end

      -- Ensure LSP servers are installed
      local ensure_installed = {}
      for server, server_opts in pairs(servers) do
        if server_opts.mason == false then
          setup(server)
        else
          table.insert(ensure_installed, server)
        end
      end

      -- Setup Mason for LSP
      local have_mason, mlsp = pcall(require, 'mason-lspconfig')
      if have_mason then
        mlsp.setup({
          ensure_installed = ensure_installed,
          handlers = { setup },
        })
      end
    end,
  },
}
