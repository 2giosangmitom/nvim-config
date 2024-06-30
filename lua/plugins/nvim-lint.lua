return {
  'mfussenegger/nvim-lint',
  opts = {
    linters_by_ft = {},
  },
  config = function(_, opts)
    require('lint').linters_by_ft = opts.linters_by_ft
    vim.api.nvim_create_autocmd({ 'BufWritePost' }, {
      callback = function()
        require('lint').try_lint()
      end,
    })
  end,
}
