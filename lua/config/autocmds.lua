local function create_augroup(name)
  return vim.api.nvim_create_augroup(name, { clear = true })
end

-- Check if we need to reload the file when it changed
vim.api.nvim_create_autocmd({ 'FocusGained', 'TermClose', 'TermLeave' }, {
  group = create_augroup('checktime'),
  callback = function()
    if vim.o.buftype == 'nofile' then
      return
    end
    vim.cmd('checktime')
  end,
})

-- Highlight on yank
vim.api.nvim_create_autocmd('TextYankPost', {
  group = create_augroup('highlight_yank'),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Resize splits if window got resized
vim.api.nvim_create_autocmd('VimResized', {
  group = create_augroup('resize_splits'),
  callback = function()
    local current_tab = vim.fn.tabpagenr()
    vim.cmd('tabdo wincmd =')
    vim.cmd('tabnext ' .. current_tab)
  end,
})

-- Close certain filetypes with <q>
vim.api.nvim_create_autocmd('FileType', {
  group = create_augroup('close_with_q'),
  pattern = {
    'PlenaryTestPopup',
    'help',
    'lspinfo',
    'notify',
    'qf',
    'spectre_panel',
    'neotest-output',
    'checkhealth',
    'neotest-summary',
    'neotest-output-panel',
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set('n', 'q', '<cmd>close<cr>', { buffer = event.buf, silent = true })
  end,
})

-- Auto create dir when saving a file, in case some intermediate directory does not exist
vim.api.nvim_create_autocmd('BufWritePre', {
  group = create_augroup('auto_create_dir'),
  callback = function(event)
    if event.match:match('^%w%w+:[\\/][\\/]') then
      return
    end
    local filepath = vim.uv.fs_realpath(event.match) or event.match
    vim.fn.mkdir(vim.fn.fnamemodify(filepath, ':p:h'), 'p')
  end,
})

