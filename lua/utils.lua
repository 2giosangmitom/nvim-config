local M = {}

--- Gets a path to a package in the Mason registry.
---@param pkg string
---@param path? string
function M.get_pkg_path(pkg, path)
  pcall(require, 'mason')
  local root = vim.fn.stdpath('data') .. '/mason'
  path = path or ''
  local ret = root .. '/packages/' .. pkg .. '/' .. path
  return ret
end

return M
