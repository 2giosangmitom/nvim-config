return {
  {
    'mfussenegger/nvim-lint',
    event = { 'BufReadPost', 'BufNewFile' },
    config = function()
      require('lint').linters_by_ft = {
        dockerfile = { 'hadolint' },
        go = { 'golangcilint' },
        nix = { 'statix' },
      }
      vim.api.nvim_create_autocmd({ 'BufWritePost' }, {
        callback = function() require('lint').try_lint() end,
      })
    end,
  },
}
