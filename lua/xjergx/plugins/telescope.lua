return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.8",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		local function calculate_height()
			if vim.o.lines <= 40 then
				return vim.o.lines -- 100% height for small terminals
			else
				-- return math.floor(vim.o.lines * 0.96) -- 30% height for larger terminals
				return vim.o.lines
			end
		end
		local initial_height = calculate_height()
		require("telescope").setup({
			defaults = {
				-- mappings = {
				-- 	i = { ["<c-t>"] = open_with_trouble },
				-- 	n = { ["<c-t>"] = open_with_trouble },
				-- },
				prompt_prefix = "🔍 ",
				layout_strategy = "horizontal",
				layout_config = {
					prompt_position = "top", -- Position the prompt at the top
					height = initial_height, -- Set the initial height
					width = vim.o.columns, -- Occupy the full width of the window
					preview_cutoff = 0, -- Always show the preview
					mirror = false, -- Place the preview on the right
					-- anchor = "S", -- Anchor the layout to the bottom
				},
				sorting_strategy = "ascending",
				winblend = 0, -- No transparency
				results_title = false, -- Remove the "Results" title
				borderchars = {
					prompt = { "─", " ", " ", " ", " ", " ", " ", " " }, -- Top border for the prompt only
					results = { " ", " ", " ", " ", " ", " ", " ", " " }, -- No borders for results
					preview = { "─", "│", "", "│", "╭", "╮", "", "" }, -- Borders for the preview (top and sides)
				},
				-- layout_config = {
				-- 	horizontal = {
				-- 		prompt_position = "top",
				-- 		preview_width = 0.55,
				-- 		results_width = 0.8,
				-- 	},
				-- 	vertical = {
				-- 		mirror = false,
				-- 	},
				-- 	width = 0.87,
				-- 	height = 0.80,
				-- 	preview_cutoff = 120,
				-- },
			},
			pickers = {
				find_files = {
					prompt_prefix = "🔍 ",
				},
			},
			extensions = {
				fzf = {
					fuzzy = true,
					override_generic_sorter = true,
					override_file_sorter = true,
					case_mode = "smart_case",
				},
				file_browser = {
					theme = "ivy",
				},
				-- git_file_history = {
				-- 	-- Keymaps inside the picker
				-- 	mappings = {
				-- 		i = {
				-- 			["<C-g>h"] = gfh_actions.open_in_browser,
				-- 		},
				-- 		n = {
				-- 			["<C-g>h"] = gfh_actions.open_in_browser,
				-- 		},
				-- 	},
				-- 	browser_command = nil,
				-- },
			},
		})
		local builtin = require("telescope.builtin")
		vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Telescope find files" })
		vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Telescope live grep" })
		vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Telescope buffers" })
		vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Telescope help tags" })
	end,
}
