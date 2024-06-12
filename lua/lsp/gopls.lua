return {
  on_attach = function(_, bufnr)
    vim.keymap.set('n', '<leader>dt', function() require('dap-go').debug_test() end, { desc = 'Debug test (Go)', buffer = bufnr })
  end,
  settings = {
    gopls = {
      analyses = {
        ST1003 = true,
        fieldalignment = false,
        fillreturns = true,
        nilness = true,
        nonewvars = true,
        shadow = true,
        undeclaredname = true,
        unreachable = true,
        unusedparams = true,
        unusedwrite = true,
        useany = true,
      },
      codelenses = {
        gc_details = true,
        generate = true,
        regenerate_cgo = true,
        test = true,
        tidy = true,
        upgrade_dependency = true,
        vendor = true,
      },
      hints = {
        assignVariableTypes = true,
        compositeLiteralFields = true,
        compositeLiteralTypes = true,
        constantValues = true,
        functionTypeParameters = true,
        parameterNames = true,
        rangeVariableTypes = true,
      },
      buildFlags = { '-tags', 'integration' },
      completeUnimported = true,
      diagnosticsDelay = '500ms',
      matcher = 'Fuzzy',
      semanticTokens = true,
      staticcheck = true,
      symbolMatcher = 'fuzzy',
      usePlaceholders = true,
    },
  },
}
