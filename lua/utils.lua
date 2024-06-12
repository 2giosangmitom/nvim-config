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

function M.on_attach(on_attach, name)
  return vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(args)
      local buffer = args.buf ---@type number
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      if client and (not name or client.name == name) then
        return on_attach(client, buffer)
      end
    end,
  })
end

return M
