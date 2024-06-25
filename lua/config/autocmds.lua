local function create_augroup(name) return vim.api.nvim_create_augroup(name, { clear = true }) end

-- Check if we need to reload the file when it changes
vim.api.nvim_create_autocmd({ 'FocusGained', 'TermClose', 'TermLeave' }, {
  group = create_augroup('checktime'),
  callback = function()
    if vim.o.buftype ~= 'nofile' then vim.cmd('checktime') end
  end,
})

-- Highlight on yank
vim.api.nvim_create_autocmd('TextYankPost', {
  group = create_augroup('highlight_yank'),
  callback = function() vim.highlight.on_yank() end,
})

-- Go to the last location when opening a buffer
vim.api.nvim_create_autocmd('BufReadPost', {
  group = create_augroup('last_loc'),
  callback = function(event)
    local exclude = { 'gitcommit' }
    local buf = event.buf
    if vim.tbl_contains(exclude, vim.bo[buf].filetype) or vim.b[buf].last_loc then return end
    vim.b[buf].last_loc = true
    local mark = vim.api.nvim_buf_get_mark(buf, '"')
    local lcount = vim.api.nvim_buf_line_count(buf)
    if mark[1] > 0 and mark[1] <= lcount then pcall(vim.api.nvim_win_set_cursor, 0, mark) end
  end,
})

-- Resize splits if window is resized
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

-- Auto create directory when saving a file, in case some intermediate directories do not exist
vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
  group = create_augroup('auto_create_dir'),
  callback = function(event)
    if event.match:match('^%w%w+:[\\/][\\/]') then return end
    local file = vim.uv.fs_realpath(event.match) or event.match
    vim.fn.mkdir(vim.fn.fnamemodify(file, ':p:h'), 'p')
  end,
})
