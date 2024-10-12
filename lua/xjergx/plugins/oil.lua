return {
	"stevearc/oil.nvim",
	opts = {
		view_options = {
			show_hidden = true,
		},
		float = {
			-- Padding around the floating window
			padding = 3,
			max_width = 70,
			max_height = 0,
			border = "rounded",
			win_options = {
				winblend = 0,
			},
			-- preview_split: Split direction: "auto", "left", "right", "above", "below".
			preview_split = "right",
			-- This is the config that will be passed to nvim_open_win.
			-- Change values here to customize the layout
			override = function(conf)
				return conf
			end,
		},
		keymaps = {
			["q"] = "actions.close",
		},
	},
	dependencies = { { "echasnovski/mini.icons", opts = {} } },
}
