return {
	{ "folke/tokyonight.nvim" },

	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		lazy = false,
		config = function()
			require("catppuccin").setup({})
			vim.cmd("coloscheme catppuccin")
		end,
	},

	{ "rose-pine/neovim", name = "rose-pine" },

	{ "rebelot/kanagawa.nvim", name = "kanagawa" },

	{
		"sho-87/kanagawa-paper.nvim",
		lazy = false,
		opts = {
			overrides = function(colors)
				local theme = colors.theme
				return {
					NormalFloat = { bg = "none" },
					FloatBorder = { bg = "none" },
					FloatTitle = { bg = "none" },
					NormalDark = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },
					LazyNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
					MasonNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
				}
			end,
		},
	},
	-- { "xiyaowong/transparent.nvim", lazy = false, priority = 1000, opts = {} },
	{ "embark-theme/vim", name = "embark", lazy = false, opts = {} },
	{ name = "dracula", lazy = false, "maxmx03/dracula.nvim" },
	{ "pauchiner/pastelnight.nvim", lazy = false, name = "pastelnight" },
	{ "EdenEast/nightfox.nvim", lazy = false, name = "nightfox" },
	{ "hardhackerlabs/theme-vim", name = "hardhackerlabs", lazy = false },
	{ "challenger-deep-theme/vim", name = "challenger-deep", lazy = false },
	{ "drewtempelmeyer/palenight.vim", name = "palenight", lazy = false },
	{ "Shadorain/shadotheme", name = "shadotheme", lazy = false },
	{ "audibleblink/hackthebox.vim", name = "hackthebox", lazy = false },
	{ "Jas-SinghFSU/drappuccin", lazy = false, name = "drappuccin" },
	{ "comfysage/aurora", lazy = false, name = "aurora" },
	{ "neanias/everforest-nvim", lazy = false, name = "everforest" },
	{ "marko-cerovac/material.nvim", lazy = false, name = "material" },
	{ "wuelnerdotexe/vim-enfocado", lazy = false, name = "enfocado" },
}
