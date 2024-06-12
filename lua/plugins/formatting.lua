return {
  {
    'stevearc/conform.nvim',
    keys = {
      {
        '<leader>cf',
        function() require('conform').format() end,
        desc = 'Format code',
      },
    },
    cmd = 'ConformInfo',
    opts = function()
      local opts = {
        formatters_by_ft = {
          lua = { 'stylua' },
          go = { 'goimports', 'gofumpt' },
        },
      }
      local prettier_supported = {
        'css',
        'graphql',
        'handlebars',
        'html',
        'javascript',
        'javascriptreact',
        'json',
        'jsonc',
        'less',
        'markdown',
        'markdown.mdx',
        'scss',
        'typescript',
        'typescriptreact',
        'vue',
        'yaml',
      }
      for _, ft in ipairs(prettier_supported) do
        opts.formatters_by_ft[ft] = { 'prettier' }
      end
      return opts
    end,
  },
}
