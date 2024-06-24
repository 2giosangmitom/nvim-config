local map = vim.keymap.set
local default_opts = { noremap = true, silent = true }

-- Basic Key Mappings
map('n', '<C-s>', '<cmd>w<cr>', vim.tbl_extend('force', default_opts, { desc = 'Save file' }))
map('n', '<S-h>', '<cmd>bprevious<cr>', vim.tbl_extend('force', default_opts, { desc = 'Prev Buffer' }))
map('n', '<S-l>', '<cmd>bnext<cr>', vim.tbl_extend('force', default_opts, { desc = 'Next Buffer' }))
map('n', '[b', '<cmd>bprevious<cr>', vim.tbl_extend('force', default_opts, { desc = 'Prev Buffer' }))
map('n', ']b', '<cmd>bnext<cr>', vim.tbl_extend('force', default_opts, { desc = 'Next Buffer' }))
map('n', '<leader>bd', '<cmd>:bd<cr>', vim.tbl_extend('force', default_opts, { desc = 'Delete Buffer and Window' }))
map('n', '<leader>fn', '<cmd>enew<cr>', vim.tbl_extend('force', default_opts, { desc = 'New File' }))
map('n', '<leader>xl', '<cmd>lopen<cr>', vim.tbl_extend('force', default_opts, { desc = 'Location List' }))
map('n', '<leader>xq', '<cmd>copen<cr>', vim.tbl_extend('force', default_opts, { desc = 'Quickfix List' }))
map('n', '[q', vim.cmd.cprev, vim.tbl_extend('force', default_opts, { desc = 'Previous Quickfix' }))
map('n', ']q', vim.cmd.cnext, vim.tbl_extend('force', default_opts, { desc = 'Next Quickfix' }))

-- Lazy.nvim Key Mappings
local lazy = require('lazy')
map('n', '<Leader>pi', lazy.install, vim.tbl_extend('force', default_opts, { desc = 'Plugins Install' }))
map('n', '<Leader>ps', lazy.home, vim.tbl_extend('force', default_opts, { desc = 'Plugins Status' }))
map('n', '<Leader>pS', lazy.sync, vim.tbl_extend('force', default_opts, { desc = 'Plugins Sync' }))
map('n', '<Leader>pu', lazy.check, vim.tbl_extend('force', default_opts, { desc = 'Plugins Check Updates' }))
map('n', '<Leader>pU', lazy.update, vim.tbl_extend('force', default_opts, { desc = 'Plugins Update' }))

-- Window Navigation
local window_nav = { h = 'h', j = 'j', k = 'k', l = 'l' }
for key, cmd in pairs(window_nav) do
  map(
    'n',
    '<C-' .. key .. '>',
    '<C-w>' .. cmd,
    vim.tbl_extend('force', default_opts, { desc = 'Go to ' .. key:upper() .. ' Window', remap = true })
  )
end

-- Window Resizing
local window_resize = {
  ['<C-Up>'] = '<cmd>resize +2<cr>',
  ['<C-Down>'] = '<cmd>resize -2<cr>',
  ['<C-Left>'] = '<cmd>vertical resize -2<cr>',
  ['<C-Right>'] = '<cmd>vertical resize +2<cr>',
}
for key, cmd in pairs(window_resize) do
  map('n', key, cmd, vim.tbl_extend('force', default_opts, { desc = 'Resize Window' }))
end

-- Move Line
local move_line_cmd = '<cmd>m .%s<cr>=='
map('n', '<A-j>', move_line_cmd:format('+1'), vim.tbl_extend('force', default_opts, { desc = 'Move Down' }))
map('n', '<A-k>', move_line_cmd:format('-2'), vim.tbl_extend('force', default_opts, { desc = 'Move Up' }))
map(
  'i',
  '<A-j>',
  '<esc>' .. move_line_cmd:format('+1') .. 'gi',
  vim.tbl_extend('force', default_opts, { desc = 'Move Down' })
)
map(
  'i',
  '<A-k>',
  '<esc>' .. move_line_cmd:format('-2') .. 'gi',
  vim.tbl_extend('force', default_opts, { desc = 'Move Up' })
)
map('v', '<A-j>', ":m '>+1<cr>gv=gv", vim.tbl_extend('force', default_opts, { desc = 'Move Down' }))
map('v', '<A-k>', ":m '<-2<cr>gv=gv", vim.tbl_extend('force', default_opts, { desc = 'Move Up' }))

-- Search and Navigation
map(
  { 'n', 'x', 'o' },
  'n',
  "'Nn'[v:searchforward].'zv'",
  vim.tbl_extend('force', default_opts, { expr = true, desc = 'Next Search Result' })
)
map(
  { 'n', 'x', 'o' },
  'N',
  "'nN'[v:searchforward].'zv'",
  vim.tbl_extend('force', default_opts, { expr = true, desc = 'Prev Search Result' })
)
map('v', '<', '<gv', vim.tbl_extend('force', default_opts, { desc = 'Indent Left' }))
map('v', '>', '>gv', vim.tbl_extend('force', default_opts, { desc = 'Indent Right' }))

-- Window Management
local window_management = {
  ['<leader>ww'] = '<C-W>p',
  ['<leader>wd'] = '<C-W>c',
  ['<leader>w-'] = '<C-W>s',
  ['<leader>w|'] = '<C-W>v',
}
for key, cmd in pairs(window_management) do
  map('n', key, cmd, vim.tbl_extend('force', default_opts, { desc = 'Window Management', remap = true }))
end

-- Escape and Clear Search
map(
  { 'i', 'n' },
  '<esc>',
  '<cmd>noh<cr><esc>',
  vim.tbl_extend('force', default_opts, { desc = 'Escape and Clear hlsearch' })
)
