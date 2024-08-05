return {
  "nvim-lualine/lualine.nvim",
  opts = function(_, opts)
    opts.options = {
      component_separators = { left = "", right = "" },
      section_separators = { left = "", right = "" },
    }

    opts.sections.lualine_a = {
      {
        "mode",
        fmt = function(str)
          return " " .. str
        end,
      },
    }
    opts.sections.lualine_b = {
      {
        "branch",
        icon = "󰘬",
      },
    }
    opts.sections.lualine_y = {
      function()
        return "󰌒 " .. vim.bo.shiftwidth
      end,
      { "location", padding = { left = 0, right = 1 } },
    }
    opts.sections.lualine_z = {
      function()
        local ok, codetime = pcall(require, "codetime.api")
        if not ok then
          return ""
        end
        return "󱢅 " .. codetime.get_session_time()
      end,
    }
  end,
}
