return {
  "kndndrj/nvim-dbee",
  cmd = "Dbee",
  dependencies = {
    "MunifTanjim/nui.nvim",
  },
  build = function()
    require("dbee").install()
  end,
  opts = {},
}
