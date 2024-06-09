-- Define mode names in a local table
local modes = {
  ['n'] = 'NORMAL',
  ['no'] = 'O-PENDING',
  ['nov'] = 'O-PENDING',
  ['noV'] = 'O-PENDING',
  ['no\22'] = 'O-PENDING',
  ['niI'] = 'NORMAL',
  ['niR'] = 'NORMAL',
  ['niV'] = 'NORMAL',
  ['nt'] = 'NORMAL',
  ['ntT'] = 'NORMAL',
  ['v'] = 'VISUAL',
  ['vs'] = 'VISUAL',
  ['V'] = 'V-LINE',
  ['Vs'] = 'V-LINE',
  ['\22'] = 'V-BLOCK',
  ['\22s'] = 'V-BLOCK',
  ['s'] = 'SELECT',
  ['S'] = 'S-LINE',
  ['\19'] = 'S-BLOCK',
  ['i'] = 'INSERT',
  ['ic'] = 'INSERT',
  ['ix'] = 'INSERT',
  ['R'] = 'REPLACE',
  ['Rc'] = 'REPLACE',
  ['Rx'] = 'REPLACE',
  ['Rv'] = 'V-REPLACE',
  ['Rvc'] = 'V-REPLACE',
  ['Rvx'] = 'V-REPLACE',
  ['c'] = 'COMMAND',
  ['cv'] = 'EX',
  ['ce'] = 'EX',
  ['r'] = 'REPLACE',
  ['rm'] = 'MORE',
  ['r?'] = 'CONFIRM',
  ['!'] = 'SHELL',
  ['t'] = 'TERMINAL',
}

-- Function to get the current mode name
local function mode()
  local current_mode = vim.api.nvim_get_mode().mode
  return string.format('-- %s --', modes[current_mode] or 'UNKNOWN')
end

-- Function to get the file path, name, and modified status
local function file_info()
  if vim.fn.isdirectory(vim.fn.expand('%:p')) == 1 then
    return ''
  end

  local file_path = vim.fn.fnamemodify(vim.fn.expand('%'), ':~:.:h')
  local file_name = vim.fn.expand('%:t')
  local modified = vim.bo.modified and ' ' or ''

  if file_path == '' then
    return file_name .. modified
  end

  return string.format('%%<%s/%s%s', file_path, file_name, modified)
end

-- Main status line function
_G.statusline = function()
  return table.concat({
    mode(),
    file_info(),
  }, ' ')
end

-- Create augroup function
local function create_augroup(name)
  return vim.api.nvim_create_augroup(name, { clear = true })
end

-- Show statusline
vim.api.nvim_create_autocmd({ 'WinEnter', 'BufEnter' }, {
  group = create_augroup('statusline'),
  callback = function()
    vim.opt_local.statusline = '%!v:lua.statusline()'
  end,
})
