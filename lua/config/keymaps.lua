local map = vim.keymap.set

-- Better up/down movement
map({ 'n', 'x' }, 'j', "v:count == 0 ? 'gj' : 'j'", { desc = 'Down', expr = true, silent = true })
map({ 'n', 'x' }, '<Down>', "v:count == 0 ? 'gj' : 'j'", { desc = 'Down', expr = true, silent = true })
map({ 'n', 'x' }, 'k', "v:count == 0 ? 'gk' : 'k'", { desc = 'Up', expr = true, silent = true })
map({ 'n', 'x' }, '<Up>', "v:count == 0 ? 'gk' : 'k'", { desc = 'Up', expr = true, silent = true })

-- Move to window using the <Ctrl> hjkl keys
map('n', '<C-h>', '<C-w>h', { desc = 'Go to Left Window', remap = true })
map('n', '<C-j>', '<C-w>j', { desc = 'Go to Lower Window', remap = true })
map('n', '<C-k>', '<C-w>k', { desc = 'Go to Upper Window', remap = true })
map('n', '<C-l>', '<C-w>l', { desc = 'Go to Right Window', remap = true })

-- Resize window using <Ctrl> arrow keys
map('n', '<C-Up>', '<cmd>resize +2<cr>', { desc = 'Increase Window Height' })
map('n', '<C-Down>', '<cmd>resize -2<cr>', { desc = 'Decrease Window Height' })
map('n', '<C-Left>', '<cmd>vertical resize -2<cr>', { desc = 'Decrease Window Width' })
map('n', '<C-Right>', '<cmd>vertical resize +2<cr>', { desc = 'Increase Window Width' })

-- Move Lines
map('n', '<A-j>', '<cmd>m .+1<cr>==', { desc = 'Move Down' })
map('n', '<A-k>', '<cmd>m .-2<cr>==', { desc = 'Move Up' })
map('i', '<A-j>', '<esc><cmd>m .+1<cr>==gi', { desc = 'Move Down' })
map('i', '<A-k>', '<esc><cmd>m .-2<cr>==gi', { desc = 'Move Up' })
map('v', '<A-j>', ":m '>+1<cr>gv=gv", { desc = 'Move Down' })
map('v', '<A-k>', ":m '<-2<cr>gv=gv", { desc = 'Move Up' })

-- Clear search with <Esc>
map({ 'i', 'n' }, '<Esc>', '<cmd>noh<cr><Esc>', { desc = 'Escape and Clear hlsearch' })

-- Clear search, diff update and redraw
map(
  'n',
  '<leader>ur',
  '<Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>',
  { desc = 'Redraw / Clear hlsearch / Diff Update' }
)

-- Next and Previous Search Result
map('n', 'n', "'Nn'[v:searchforward].'zv'", { desc = 'Next Search Result', expr = true })
map('x', 'n', "'Nn'[v:searchforward]", { desc = 'Next Search Result', expr = true })
map('o', 'n', "'Nn'[v:searchforward]", { desc = 'Next Search Result', expr = true })
map('n', 'N', "'nN'[v:searchforward].'zv'", { desc = 'Prev Search Result', expr = true })
map('x', 'N', "'nN'[v:searchforward]", { desc = 'Prev Search Result', expr = true })
map('o', 'N', "'nN'[v:searchforward]", { desc = 'Prev Search Result', expr = true })

-- Add undo break-points
map('i', ',', ',<c-g>u')
map('i', '.', '.<c-g>u')
map('i', ';', ';<c-g>u')

-- Save file
map({ 'i', 'x', 'n', 's' }, '<C-s>', '<cmd>w<cr><Esc>', { desc = 'Save File' })

-- Better indenting
map('v', '<', '<gv')
map('v', '>', '>gv')

-- Lazy
map('n', '<leader>l', '<cmd>Lazy<cr>', { desc = 'Lazy' })

-- Location and Quickfix Lists
map('n', '<leader>xl', '<cmd>lopen<cr>', { desc = 'Location List' })
map('n', '<leader>xq', '<cmd>copen<cr>', { desc = 'Quickfix List' })

map('n', '[q', vim.cmd.cprev, { desc = 'Previous Quickfix' })
map('n', ']q', vim.cmd.cnext, { desc = 'Next Quickfix' })

-- Terminal Mappings
map('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Enter Normal Mode' })
map('t', '<C-h>', '<cmd>wincmd h<cr>', { desc = 'Go to Left Window' })
map('t', '<C-j>', '<cmd>wincmd j<cr>', { desc = 'Go to Lower Window' })
map('t', '<C-k>', '<cmd>wincmd k<cr>', { desc = 'Go to Upper Window' })
map('t', '<C-l>', '<cmd>wincmd l<cr>', { desc = 'Go to Right Window' })
map('t', '<C-/>', '<cmd>close<cr>', { desc = 'Hide Terminal' })
map('t', '<C-_>', '<cmd>close<cr>', { desc = 'which_key_ignore' })

-- Window Management
map('n', '<leader>ww', '<C-W>p', { desc = 'Other Window', remap = true })
map('n', '<leader>wd', '<C-W>c', { desc = 'Delete Window', remap = true })
map('n', '<leader>w-', '<C-W>s', { desc = 'Split Window Below', remap = true })
map('n', '<leader>w|', '<C-W>v', { desc = 'Split Window Right', remap = true })
map('n', '<leader>-', '<C-W>s', { desc = 'Split Window Below', remap = true })
map('n', '<leader>|', '<C-W>v', { desc = 'Split Window Right', remap = true })

-- Tab Management
map('n', '<leader><tab>l', '<cmd>tablast<cr>', { desc = 'Last Tab' })
map('n', '<leader><tab>o', '<cmd>tabonly<cr>', { desc = 'Close Other Tabs' })
map('n', '<leader><tab>f', '<cmd>tabfirst<cr>', { desc = 'First Tab' })
map('n', '<leader><tab><tab>', '<cmd>tabnew<cr>', { desc = 'New Tab' })
map('n', '<leader><tab>]', '<cmd>tabnext<cr>', { desc = 'Next Tab' })
map('n', '<leader><tab>d', '<cmd>tabclose<cr>', { desc = 'Close Tab' })
map('n', '<leader><tab>[', '<cmd>tabprevious<cr>', { desc = 'Previous Tab' })
