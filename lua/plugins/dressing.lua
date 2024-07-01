return {
  'stevearc/dressing.nvim',
  init = function()
    for _, func in ipairs({ 'select', 'input' }) do
      vim.ui[func] = function(...)
        require('lazy').load({ plugins = { 'dressing.nvim' } })
        return vim.ui[func](...)
      end
    end
  end,
}
