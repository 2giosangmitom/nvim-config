return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = { "typst" },
    },
  },

  -- Wait until this package is available in the mason-registry
  -- {
  --   "williamboman/mason.nvim",
  --   opts = {
  --     ensure_installed = { "typstyle" },
  --   },
  -- },

  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        tinymist = {},
      },
    },
  },

  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters_by_ft = {
        typst = { "typstyle" },
      },
    },
  },

  {
    "nvimtools/none-ls.nvim",
    optional = true,
    opts = function(_, opts)
      local nls = require("null-ls")
      opts.sources = vim.list_extend(opts.sources or {}, {
        nls.builtins.formatting.typstyle,
      })
    end,
  },

  {
    "chomosuke/typst-preview.nvim",
    cmd = { "TypstPreview" },
    opts = {
      dependencies_bin = {
        ["typst-preview"] = "tinymist",
      },
    },
  },
}
