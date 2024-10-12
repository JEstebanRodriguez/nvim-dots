return {
	{
		"nvim-lualine/lualine.nvim",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
			"arkav/lualine-lsp-progress",
		},
		config = function()
			require("lualine").setup({
				sections = {
					lualine_a = {
						{
							-- MODE WITH VIM ICON
							"mode",
							-- separator = { left = "", right = "" },
							color = { gui = "bold" },
							icon = "  ",
						},
					},
					lualine_b = { { "filename", path = 1, path_hl = "Constant" } },
					lualine_c = {
						{
							"diagnostics",
							sources = { "nvim_diagnostic" },
							symbols = { error = " ", warn = " ", info = " ", hint = " " },
						},
					},
					lualine_x = {
						"filetype",
						"encoding",
						"fileformat",
						"location",
					},
					lualine_y = {
						"progress",
						{
							"diff",
							symbols = { added = " ", modified = " ", removed = " " },
						},
					},
					lualine_z = {
						"branch",
					},
				},
			})
		end,
	},
}
