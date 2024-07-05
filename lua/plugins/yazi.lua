return {
  "mikavilpas/yazi.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  keys = {
    {
      "<leader>y",
      function()
        require("yazi").yazi()
      end,
      desc = "Open the file manager (Yazi)",
    },
  },
}
