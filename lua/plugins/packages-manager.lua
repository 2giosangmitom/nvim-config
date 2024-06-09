return {
	{
		"williamboman/mason.nvim",
		event = { "BufReadPost", "BufNewFile" },
		opts = {
			ui = {
				icons = {
					package_pending = "",
					package_installed = "󰄳",
					package_uninstalled = "󰚌",
				},
			},
		},
	},
}
