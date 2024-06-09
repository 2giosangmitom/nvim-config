return {
	{
		"stevearc/conform.nvim",
		keys = {
			{
				"<leader>cf",
				function()
					require("conform").format()
				end,
				desc = "Format code",
			},
		},
		opts = {
			formatters_by_ft = {
				lua = { "stylua" },
			},
		},
	},
}