local M = {}

-- Define mode mappings
local modes = {
  n = { 'NORMAL', 'Normal' },
  no = { 'NORMAL (no)', 'Normal' },
  nov = { 'NORMAL (nov)', 'Normal' },
  noV = { 'NORMAL (noV)', 'Normal' },
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
  [''] = { 'V-BLOCK', 'Visual' },
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
  [''] = { 'S-BLOCK', 'Select' },
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

-- Get current mode info
local function get_mode()
  local mode = vim.api.nvim_get_mode().mode
  local mode_info = modes[mode] or { 'UNKNOWN', 'Unknown' }
  return string.format(
    '%%#St_%sMode#  %s %%#St_%sModeSep#%s%%#ST_EmptySpace#%s',
    mode_info[2],
    mode_info[1],
    mode_info[2],
    sep_r,
    sep_r
  )
end

-- Get current file info
local function get_file_info()
  local buf_name = vim.api.nvim_buf_get_name(vim.api.nvim_win_get_buf(vim.g.statusline_winid or 0))
  local file_name = buf_name == '' and 'Empty ' or buf_name:match('([^/\\]+)$')
  local icon = '󰈚'

  if file_name ~= 'Empty ' then
    local devicons_present, devicons = pcall(require, 'nvim-web-devicons')
    if devicons_present then
      icon = devicons.get_icon(file_name) or icon
    end
  end

  local modified = vim.bo.modified and '  ' or ' '
  return string.format('%%#St_file#%s %s%s%%#St_file_sep#%s', icon, file_name, modified, sep_r)
end

-- Get current working directory
local function get_cwd()
  local cwd = vim.uv.cwd()
  if not cwd then
    return ''
  end
  local cwd_name = cwd:match('([^/\\]+)$') or cwd
  return vim.o.columns > 85
      and string.format('%%#St_cwd_sep#%s%%#St_cwd_icon#󰉋 %%#St_cwd_text# %s ', sep_l, cwd_name)
    or ''
end

-- Cursor position info
local cursor = string.format('%%#St_pos_sep#%s%%#St_pos_icon# %%#St_pos_text# %%p %%%% ', sep_l)

-- Get git status
local function get_git_status()
  local buf = vim.api.nvim_win_get_buf(vim.g.statusline_winid or 0)
  local git_status = vim.b[buf].gitsigns_status_dict
  if not git_status then
    return ''
  end

  local added = git_status.added and git_status.added ~= 0 and string.format('  %d', git_status.added) or ''
  local changed = git_status.changed and git_status.changed ~= 0 and string.format('  %d', git_status.changed) or ''
  local removed = git_status.removed and git_status.removed ~= 0 and string.format('  %d', git_status.removed) or ''
  local branch_name = ' ' .. git_status.head

  return string.format('%%#St_gitIcons# %s%s%s%s', branch_name, added, changed, removed)
end

-- Get diagnostics info
local function get_diagnostics()
  if not rawget(vim, 'lsp') then
    return ''
  end

  local buf = vim.api.nvim_win_get_buf(vim.g.statusline_winid or 0)
  local severity = vim.diagnostic.severity
  local errors = #vim.diagnostic.get(buf, { severity = severity.ERROR })
  local warnings = #vim.diagnostic.get(buf, { severity = severity.WARN })
  local hints = #vim.diagnostic.get(buf, { severity = severity.HINT })
  local infos = #vim.diagnostic.get(buf, { severity = severity.INFO })

  local function diag_info(count, icon, hl_group)
    return count > 0 and string.format('%%#%s#%s %d ', hl_group, icon, count) or ''
  end

  return string.format(
    ' %s%s%s%s',
    diag_info(errors, '', 'St_lspError'),
    diag_info(warnings, '', 'St_lspWarning'),
    diag_info(hints, '󰛩', 'St_lspHints'),
    diag_info(infos, '󰋼', 'St_lspInfo')
  )
end

-- Generate statusline
function M.generate()
  if vim.tbl_contains({ 'TelescopePrompt' }, vim.bo.filetype) then
    return ''
  end
  return table.concat({
    get_mode(),
    ' ',
    get_file_info(),
    get_git_status(),
    '%=',
    get_diagnostics(),
    get_cwd(),
    cursor,
  })
end

vim.opt.statusline = '%{%v:lua.require("statusline").generate()%}'

return M
