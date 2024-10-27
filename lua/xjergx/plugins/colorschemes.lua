return {
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		config = function()
			require("catppuccin").setup({
				flavour = "mocha",
				integrations = {
					cmp = true,
					gitsigns = true,
					nvimtree = true,
					treesitter = true,
					notify = false,
					mini = {
						enabled = true,
						indentscope_color = "",
					},
				},
			})
			vim.cmd([[colorscheme catppuccin]])
		end,
	},

	{ "folke/tokyonight.nvim", lazy = false },

	{ "rebelot/kanagawa.nvim", lazy = false },

	{ "rose-pine/neovim", lazy = false, name = "rose-pine" },

	{ "sho-87/kanagawa-paper.nvim", lazy = false },

	{ "sainnhe/everforest", lazy = false, name = "everforest" },

	{ "tiagovla/tokyodark.nvim", lazy = false, name = "tokyodark" },

	{ "Everblush/nvim", name = "everblush" },

	{ "ttak0422/morimo", name = "morimo" },

	{ "RedsXDD/neopywal.nvim", name = "neopywal", lazy = false },

	{ "comfysage/twilight-moon", name = "twilight-moon", lazy = false },

	{ "dustypomerleau/tol.nvim", lazy = false },

	{ "pauchiner/pastelnight.nvim", lazy = false },

	{ "Zabanaa/neuromancer.vim", lazy = false },

	{
		"AlexvZyl/nordic.nvim",
		lazy = false,
		priority = 1000,
	},

	-- transparent
	{ "xiyaowong/nvim-transparent", lazy = false },
}
