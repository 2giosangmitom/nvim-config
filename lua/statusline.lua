local M = {}

local icons = require('config.icons')

-- Define mode mappings
local modes = {
  n = { 'NORMAL', 'Normal' },
  no = { 'O-PENDING', 'Normal' },
  nov = { 'O-PENDING', 'Normal' },
  noV = { 'O-PENDING', 'Normal' },
  noCTRL_V = { 'NORMAL', 'Normal' },
  niI = { 'NORMAL i', 'Normal' },
  niR = { 'NORMAL r', 'Normal' },
  niV = { 'NORMAL v', 'Normal' },
  nt = { 'NTERMINAL', 'NTerminal' },
  ntT = { 'NTERMINAL (ntT)', 'NTerminal' },
  v = { 'VISUAL', 'Visual' },
  vs = { 'V-CHAR (Ctrl O)', 'Visual' },
  V = { 'V-LINE', 'Visual' },
  Vs = { 'V-LINE', 'Visual' },
  ['\22'] = { 'V-BLOCK', 'Visual' },
  i = { 'INSERT', 'Insert' },
  ic = { 'INSERT (completion)', 'Insert' },
  ix = { 'INSERT completion', 'Insert' },
  t = { 'TERMINAL', 'Terminal' },
  R = { 'REPLACE', 'Replace' },
  Rc = { 'REPLACE (Rc)', 'Replace' },
  Rx = { 'REPLACE (Rx)', 'Replace' },
  Rv = { 'V-REPLACE', 'Replace' },
  Rvc = { 'V-REPLACE (Rvc)', 'Replace' },
  Rvx = { 'V-REPLACE (Rvx)', 'Replace' },
  s = { 'SELECT', 'Select' },
  S = { 'S-LINE', 'Select' },
  ['\19'] = { 'S-BLOCK', 'Select' },
  c = { 'COMMAND', 'Command' },
  cv = { 'COMMAND', 'Command' },
  ce = { 'COMMAND', 'Command' },
  cr = { 'COMMAND', 'Command' },
  r = { 'PROMPT', 'Confirm' },
  rm = { 'MORE', 'Confirm' },
  ['r?'] = { 'CONFIRM', 'Confirm' },
  x = { 'CONFIRM', 'Confirm' },
  ['!'] = { 'SHELL', 'Terminal' },
}

-- Define separator icons
local separators = { left = '', right = '' }
local sep_l, sep_r = separators.left, separators.right

local function get_mode()
  local mode = vim.api.nvim_get_mode().mode
  local mode_info = modes[mode] or { 'UNKNOWN', 'Unknown' }
  return string.format('%%#St_%sMode#  %s %%#St_%sModeSep#%s%%#ST_EmptySpace#%s', mode_info[2], mode_info[1], mode_info[2], sep_r, sep_r)
end

local function get_file_info()
  local buf_name = vim.api.nvim_buf_get_name(vim.api.nvim_win_get_buf(0))
  local file_name = buf_name == '' and 'Empty ' or buf_name:match('([^/\\]+)$')
  local icon = '󰈚'

  if file_name ~= 'Empty ' then
    local devicons_present, devicons = pcall(require, 'nvim-web-devicons')
    if devicons_present then icon = devicons.get_icon(file_name) or icon end
  end

  local modified = vim.bo.modified and ' ' or ''
  local readonly = vim.bo.readonly and ' ' or ''
  file_name = file_name .. modified .. readonly
  return string.format('%%#St_file#%s %s %%#St_file_sep#%s', icon, file_name, sep_r)
end

local function get_cwd()
  local cwd = vim.uv.cwd()
  if not cwd then return '' end
  local cwd_name = cwd:match('([^/\\]+)$') or cwd
  return vim.o.columns > 85 and string.format('%%#St_cwd_sep#%s%%#St_cwd_icon#󰉋 %%#St_cwd_text# %s ', sep_l, cwd_name) or ''
end

local function cursor()
  local cur, total = vim.fn.line('.'), vim.fn.line('$')
  if cur == 1 then
    return string.format('%%#St_pos_sep#%s%%#St_pos_icon# %%#St_pos_text# Top ', sep_l)
  elseif cur == total then
    return string.format('%%#St_pos_sep#%s%%#St_pos_icon# %%#St_pos_text# Bot ', sep_l)
  else
    return string.format('%%#St_pos_sep#%s%%#St_pos_icon# %%#St_pos_text# %2d%%%% ', sep_l, math.floor(cur / total * 100))
  end
end

local function get_git_status()
  local buf = vim.api.nvim_win_get_buf(0)
  local git_status = vim.b[buf].gitsigns_status_dict
  if not git_status then return '' end

  local function status_info(count, icon, hl_group) return count and count ~= 0 and string.format(' %%#%s#%s%d', hl_group, icon, count) or '' end

  local added = status_info(git_status.added, icons.git.added, 'St_gitadded')
  local changed = status_info(git_status.changed, icons.git.modified, 'St_gitmodified')
  local removed = status_info(git_status.removed, icons.git.removed, 'St_gitremoved')
  local branch_name = '%#St_gitbranch# ' .. git_status.head

  return string.format(' %s%s%s%s', branch_name, added, changed, removed)
end

local function get_diagnostics()
  if not rawget(vim, 'lsp') then return '' end

  local buf = vim.api.nvim_win_get_buf(0)
  local severity = vim.diagnostic.severity
  local errors = #vim.diagnostic.get(buf, { severity = severity.ERROR })
  local warnings = #vim.diagnostic.get(buf, { severity = severity.WARN })
  local hints = #vim.diagnostic.get(buf, { severity = severity.HINT })
  local infos = #vim.diagnostic.get(buf, { severity = severity.INFO })

  local function diag_info(count, icon, hl_group) return count > 0 and string.format('%%#%s#%s %d ', hl_group, icon, count) or '' end

  return string.format(
    ' %s%s%s%s',
    diag_info(errors, icons.diagnostics.Error, 'St_lspError'),
    diag_info(warnings, icons.diagnostics.Warning, 'St_lspWarning'),
    diag_info(hints, icons.diagnostics.Hint, 'St_lspHints'),
    diag_info(infos, icons.diagnostics.Information, 'St_lspInfo')
  )
end

local function lsp_clients()
  local buf = vim.api.nvim_win_get_buf(0)
  local clients = vim.lsp.get_clients({ bufnr = 0 })
  if #clients == 0 then return '' end
  local client_names = {}
  for _, client in ipairs(clients) do
    if client.attached_buffers[buf] then table.insert(client_names, client.name) end
  end
  return '%#St_lspSv#   LSP ~ ' .. table.concat(client_names, ', ') .. ' '
end

function M.generate()
  return table.concat({
    get_mode(),
    ' ',
    get_file_info(),
    get_git_status(),
    '%=',
    get_diagnostics(),
    lsp_clients(),
    get_cwd(),
    cursor(),
  })
end

return M
