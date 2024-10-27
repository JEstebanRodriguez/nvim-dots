return {
	{
		"aznhe21/actions-preview.nvim",
		config = function()
			vim.keymap.set(
				{ "v", "n" },
				"<leader>ca",
				require("actions-preview").code_actions,
				{ desc = "Code Actions" }
			)
		end,
	},

	{
		"windwp/nvim-ts-autotag",
		config = function()
			require("nvim-ts-autotag").setup()
		end,
	},

	{
		"windwp/nvim-autopairs",
		config = function()
			require("nvim-autopairs").setup()
		end,
	},

	{
		"HiPhish/rainbow-delimiters.nvim",
		config = function()
			local rainbow_delimiters = require("rainbow-delimiters")

			vim.g.rainbow_delimiters = {
				strategy = {
					[""] = rainbow_delimiters.strategy["global"],
					vim = rainbow_delimiters.strategy["local"],
				},
				query = {
					[""] = "rainbow-delimiters",
					lua = "rainbow-blocks",
				},
				priority = {
					[""] = 110,
					lua = 210,
				},
				highlight = {
					"RainbowDelimiterRed",
					"RainbowDelimiterYellow",
					"RainbowDelimiterBlue",
					"RainbowDelimiterOrange",
					"RainbowDelimiterGreen",
					"RainbowDelimiterViolet",
					"RainbowDelimiterCyan",
				},
			}
		end,
	},

	{
		"folke/zen-mode.nvim",
		config = function()
			require("zen-mode").setup({})
			vim.keymap.set("n", "<leader>z", ":ZenMode<cr>", { desc = "Zen Mode" })
		end,
	},

	{
		"folke/todo-comments.nvim",
		config = function()
			require("todo-comments").setup({})
		end,
	},

	{
		"JoosepAlviste/nvim-ts-context-commentstring",
		config = function()
			require("ts_context_commentstring").setup({
				enable_autocmd = false,
			})
		end,
	},

	{
		"numToStr/Comment.nvim",
		config = true,
	},

	{
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("harpoon").setup()
			--keymaps
			vim.keymap.set(
				"n",
				"<leader>a",
				":lua require('harpoon.mark').add_file()<cr>",
				{ desc = "Harpoon Add File" }
			)
			vim.keymap.set(
				"n",
				"<leader>h",
				":lua require('harpoon.ui').toggle_quick_menu()<cr>",
				{ desc = "Harpoon Quick Menu" }
			)
			vim.keymap.set("n", "<leader>1", ":lua require('harpoon.ui').nav_file(1)<cr>", { desc = "Harpoon 1" })
			vim.keymap.set("n", "<leader>2", ":lua require('harpoon.ui').nav_file(2)<cr>", { desc = "Harpoon 2" })
			vim.keymap.set("n", "<leader>3", ":lua require('harpoon.ui').nav_file(3)<cr>", { desc = "Harpoon 3" })
			vim.keymap.set("n", "<leader>4", ":lua require('harpoon.ui').nav_file(4)<cr>", { desc = "Harpoon 4" })
		end,
	},

	{
		"folke/flash.nvim",
		event = "VeryLazy",
		opts = {},
		keys = {
			{
				"s",
				mode = { "n", "x", "o" },
				function()
					require("flash").jump()
				end,
				desc = "Flash",
			},
			{
				"S",
				mode = { "n", "x", "o" },
				function()
					require("flash").treesitter()
				end,
				desc = "Flash Treesitter",
			},
			{
				"r",
				mode = "o",
				function()
					require("flash").remote()
				end,
				desc = "Remote Flash",
			},
			{
				"R",
				mode = { "o", "x" },
				function()
					require("flash").treesitter_search()
				end,
				desc = "Treesitter Search",
			},
			{
				"<c-s>",
				mode = { "c" },
				function()
					require("flash").toggle()
				end,
				desc = "Toggle Flash Search",
			},
		},
	},

	{
		"folke/zen-mode.nvim",
		opts = {
			mappings = {
				["<leader>z"] = ":ZenMode<cr>",
			},
		},
	},

	{
		"kylechui/nvim-surround",
		version = "*",
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup({})

			vim.keymap.set("n", "ysiw)", "<cmd>normal! ysiw)<CR>", { desc = "Surround words with parentheses" })
			vim.keymap.set("n", 'ys$"', '<cmd>normal! ys$"<CR>', { desc = "Make strings" })
			vim.keymap.set("n", "ds]", "<cmd>normal! ds]<CR>", { desc = "Delete around square brackets" })
			vim.keymap.set("n", "dst", "<cmd>normal! dst<CR>", { desc = "Remove HTML tags" })
			vim.keymap.set("n", "cs'", "<cmd>normal! cs'<CR>", { desc = "Change single quotes to double quotes" })
			vim.keymap.set("n", "csth1", "<cmd>normal! csth1<CR>", { desc = "Change tag types to <h1>" })
			vim.keymap.set("n", "dsf", "<cmd>normal! dsf<CR>", { desc = "Delete function calls" })
		end,
	},

	{
		"echasnovski/mini.move",
		version = false,
		config = function()
			require("mini.move").setup({
				mappings = {
					left = "<M-h>",
					right = "<M-l>",
					down = "<M-j>",
					up = "<M-k>",
					-- Move current line in Normal mode
					line_left = "<M-h>",
					line_right = "<M-l>",
					line_down = "<M-j>",
					line_up = "<M-k>",
				},
			})
		end,
	},

	{
		"echasnovski/mini.surround",
		version = "*",
		config = function()
			require("mini.surround").setup({
				mappings = {
					add = "sa", -- Add surrounding in Normal and Visual modes
					delete = "sd", -- Delete surrounding
					find = "sf", -- Find surrounding (to the right)
					find_left = "sF", -- Find surrounding (to the left)
					highlight = "sh", -- Highlight surrounding
					replace = "sr", -- Replace surrounding
					update_n_lines = "sn", -- Update `n_lines`

					suffix_last = "l", -- Suffix to search with "prev" method
					suffix_next = "n", -- Suffix to search with "next" method
				},
			})
		end,
	},

	{
		"karb94/neoscroll.nvim",
		config = function()
			require("neoscroll").setup({ mappings = { "<C-u>", "<C-d>", "<C-b>", "<C-f>" } })
		end,
	},

	{
		"rachartier/tiny-inline-diagnostic.nvim",
		event = "VeryLazy",
		config = function()
			require("tiny-inline-diagnostic").setup()
		end,
	},
}
