local map = vim.keymap.set

-- Key mappings
map('n', '<C-s>', '<cmd>w<cr>', { desc = 'Save file' })
map('n', '<leader>pl', '<cmd>Lazy<cr>', { desc = 'Lazy' })

-- Window navigation
local window_nav_commands = {
  ['h'] = '<C-w>h',
  ['j'] = '<C-w>j',
  ['k'] = '<C-w>k',
  ['l'] = '<C-w>l',
}
for key, command in pairs(window_nav_commands) do
  map('n', '<C-' .. key .. '>', command, { desc = 'Go to ' .. key:upper() .. ' Window', remap = true })
end

-- Resize window using <ctrl> arrow keys
map('n', '<C-Up>', '<cmd>resize +2<cr>', { desc = 'Increase Window Height' })
map('n', '<C-Down>', '<cmd>resize -2<cr>', { desc = 'Decrease Window Height' })
map('n', '<C-Left>', '<cmd>vertical resize -2<cr>', { desc = 'Decrease Window Width' })
map('n', '<C-Right>', '<cmd>vertical resize +2<cr>', { desc = 'Increase Window Width' })

-- Move Lines
local move_line_command = '<cmd>m .%s<cr>=='
map('n', '<A-j>', move_line_command:format('+1'), { desc = 'Move Down' })
map('n', '<A-k>', move_line_command:format('-2'), { desc = 'Move Up' })
map('i', '<A-j>', '<esc>' .. move_line_command:format('+1') .. 'gi', { desc = 'Move Down' })
map('i', '<A-k>', '<esc>' .. move_line_command:format('-2') .. 'gi', { desc = 'Move Up' })
map('v', '<A-j>', ":m '>+1<cr>gv=gv", { desc = 'Move Down' })
map('v', '<A-k>', ":m '<-2<cr>gv=gv", { desc = 'Move Up' })

-- Buffers
map('n', '<S-h>', '<cmd>bprevious<cr>', { desc = 'Prev Buffer' })
map('n', '<S-l>', '<cmd>bnext<cr>', { desc = 'Next Buffer' })
map('n', '[b', '<cmd>bprevious<cr>', { desc = 'Prev Buffer' })
map('n', ']b', '<cmd>bnext<cr>', { desc = 'Next Buffer' })
map('n', '<leader>bD', '<cmd>:bd<cr>', { desc = 'Delete Buffer and Window' })

-- Clear search with <esc>
map({ 'i', 'n' }, '<esc>', '<cmd>noh<cr><esc>', { desc = 'Escape and Clear hlsearch' })

-- Search navigation
local search_nav_command = "'Nn'[v:searchforward].'zv'"
map({ 'n', 'x', 'o' }, 'n', search_nav_command, { expr = true, desc = 'Next Search Result' })
map({ 'n', 'x', 'o' }, 'N', "'nN'[v:searchforward].'zv'", { expr = true, desc = 'Prev Search Result' })

-- Other mappings
map('v', '<', '<gv')
map('v', '>', '>gv')
map('n', '<leader>fn', '<cmd>enew<cr>', { desc = 'New File' })
map('n', '<leader>xl', '<cmd>lopen<cr>', { desc = 'Location List' })
map('n', '<leader>xq', '<cmd>copen<cr>', { desc = 'Quickfix List' })
map('n', '[q', vim.cmd.cprev, { desc = 'Previous Quickfix' })
map('n', ']q', vim.cmd.cnext, { desc = 'Next Quickfix' })

-- Window management
map('n', '<leader>ww', '<C-W>p', { desc = 'Other Window', remap = true })
map('n', '<leader>wd', '<C-W>c', { desc = 'Delete Window', remap = true })
map('n', '<leader>w-', '<C-W>s', { desc = 'Split Window Below', remap = true })
map('n', '<leader>w|', '<C-W>v', { desc = 'Split Window Right', remap = true })

-- Tab navigation
local tab_nav_command = '<cmd>tab%s<cr>'
map('n', '<leader><tab>l', tab_nav_command:format('last'), { desc = 'Last Tab' })
map('n', '<leader><tab>o', '<cmd>tabonly<cr>', { desc = 'Close Other Tabs' })
map('n', '<leader><tab>f', tab_nav_command:format('first'), { desc = 'First Tab' })
map('n', '<leader><tab><tab>', '<cmd>tabnew<cr>', { desc = 'New Tab' })
map('n', '<leader><tab>]', '<cmd>tabnext<cr>', { desc = 'Next Tab' })
map('n', '<leader><tab>d', '<cmd>tabclose<cr>', { desc = 'Close Tab' })
map('n', '<leader><tab>[', '<cmd>tabprevious<cr>', { desc = 'Previous Tab' })
