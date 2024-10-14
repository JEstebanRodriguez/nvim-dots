return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.8",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"debugloop/telescope-undo.nvim",
		"nvim-telescope/telescope-file-browser.nvim",
		"nvim-telescope/telescope-fzf-native.nvim",
	},
	config = function()
		local function calculate_height()
			if vim.o.lines <= 40 then
				return vim.o.lines
			else
				-- return math.floor(vim.o.lines * 0.96) -- 30% height for larger terminals
				return vim.o.lines
			end
		end
		local initial_height = calculate_height()
		local telescope = require("telescope")
		telescope.setup({
			defaults = {
				-- mappings = {
				-- 	i = { ["<c-t>"] = open_with_trouble },
				-- 	n = { ["<c-t>"] = open_with_trouble },
				-- },
				prompt_prefix = "🔍 ",
				layout_strategy = "horizontal",
				layout_config = {
					prompt_position = "top",
					height = initial_height,
					width = vim.o.columns,
					preview_cutoff = 0,
					mirror = false,
					-- anchor = "S", -- Anchor the layout to the bottom
				},
				sorting_strategy = "ascending",
				winblend = 1, -- No transparency
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

		-- telescope.load_extension("fzf")
		telescope.load_extension("file_browser")
		telescope.load_extension("undo")
		local builtin = require("telescope.builtin")
		vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Telescope find files" })
		vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Telescope live grep" })
		vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Telescope buffers" })
		vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Telescope help tags" })
		vim.keymap.set("n", "<leader>fd", builtin.diagnostics, { desc = "Telescope diagnostics" })
		vim.keymap.set("n", "<leader>fu", builtin.git_files, { desc = "Telescope git files" })

		vim.keymap.set("n", "<leader>ft", builtin.treesitter, { desc = "Telescope treesitter" })
		vim.keymap.set("n", "<leader>fk", builtin.keymaps, { desc = "Telescope keymaps" })

		vim.keymap.set("n", "<leader>fo", builtin.oldfiles, { desc = "Telescope oldfiles" })
		vim.keymap.set("n", "<leader>fc", builtin.commands, { desc = "Telescope commands" })

		vim.keymap.set("n", "<leader>fm", builtin.man_pages, { desc = "Telescope man pages" })
		-- vim.keymap.set(
		-- 	"n",
		-- 	"<leader>fb",
		-- 	builtin.extensions.file_browser.file_browser,
		-- 	{ desc = "Telescope file browser" }
		-- )
		vim.keymap.set("n", "<leader>u", "<cmd>Telescope undo<cr>", { desc = "Telescope undo" })
	end,
}
