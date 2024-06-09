local M = {}

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

local function vimmode()
  local current_mode = vim.api.nvim_get_mode().mode
  return '%#St_' .. current_mode .. 'Mode# -- ' .. modes[current_mode] .. ' --'
end

local function file_info()
  local filepath = vim.fn.expand('%:~:.')
  if vim.bo.modified then
    filepath = filepath .. ' '
  end
  if vim.bo.readonly then
    filepath = filepath .. ' 󰌾'
  end
  return '%#St_b# ' .. filepath
end

function M.generate()
  local result = { vimmode(), ' ', file_info() }
  local excludes = { 'TelescopePrompt' }
  if vim.tbl_contains(excludes, vim.bo.filetype) then
    return ''
  end
  return table.concat(result)
end

vim.opt.statusline = '%{%v:lua.require("statusline").generate()%}'

return M
