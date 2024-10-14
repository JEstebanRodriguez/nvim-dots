return {
	-- {
	-- 	"lukas-reineke/indent-blankline.nvim",
	-- 	main = "ibl",
	-- 	opts = {},
	-- },
	{
		"shellRaining/hlchunk.nvim",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("hlchunk").setup({
				indent = {
					enable = true,
					chars = {
						"│",
					},
					style = {
						vim.fn.synIDattr(vim.fn.synIDtrans(vim.fn.hlID("Whitespace")), "fg", "gui"),
					},
				},
				line_num = {
					enable = true,
					style = "#806d9c",
				},
				-- indent = {
				-- 	enable = true,
				-- 	chars = {
				-- 		"│",
				-- 		"│",
				-- 		"│",
				-- 		"│",
				-- 	},
				-- },
			})
		end,
	},

	{
		"goolord/alpha-nvim",
		dependencies = { "echasnovski/mini.icons" },
		config = function()
			local startify = require("alpha.themes.startify")
			startify.file_icons.provider = "devicons"
			startify.section.header.val = {
				[[                                                      ]],
				[[                                                      ]],
				[[ ██╗  ██╗     ██╗███████╗██████╗  ██████╗ ██╗  ██╗    ]],
				[[ ╚██╗██╔╝     ██║██╔════╝██╔══██╗██╔════╝ ╚██╗██╔╝    ]],
				[[  ╚███╔╝      ██║█████╗  ██████╔╝██║  ███╗ ╚███╔╝     ]],
				[[  ██╔██╗ ██   ██║██╔══╝  ██╔══██╗██║   ██║ ██╔██╗     ]],
				[[ ██╔╝ ██╗╚█████╔╝███████╗██║  ██║╚██████╔╝██╔╝ ██╗    ]],
				[[ ╚═╝  ╚═╝ ╚════╝ ╚══════╝╚═╝  ╚═╝ ╚═════╝ ╚═╝  ╚═╝    ]],
				[[                                                      ]],
				[[                                                      ]],
			}

			require("alpha").setup(startify.config)
		end,
	},

	{
		"kevinhwang91/nvim-ufo",
		dependencies = "kevinhwang91/promise-async",
		config = function()
			local handler = function(virtText, lnum, endLnum, width, truncate)
				local newVirtText = {}
				local suffix = ("  %d "):format(endLnum - lnum) -- NOTE: Aquí se usa la flecha ''
				local sufWidth = vim.fn.strdisplaywidth(suffix)
				local targetWidth = width - sufWidth
				local curWidth = 0
				for _, chunk in ipairs(virtText) do
					local chunkText = chunk[1]
					local chunkWidth = vim.fn.strdisplaywidth(chunkText)
					if targetWidth > curWidth + chunkWidth then
						table.insert(newVirtText, chunk)
					else
						chunkText = truncate(chunkText, targetWidth - curWidth)
						local hlGroup = chunk[2]
						table.insert(newVirtText, { chunkText, hlGroup })
						chunkWidth = vim.fn.strdisplaywidth(chunkText)
						if curWidth + chunkWidth < targetWidth then
							suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
						end
						break
					end
					curWidth = curWidth + chunkWidth
				end
				table.insert(newVirtText, { suffix, "MoreMsg" })
				return newVirtText
			end

			require("ufo").setup({
				fold_virt_text_handler = handler,
				provider_selector = function()
					return { "treesitter", "indent" }
				end,
			})

			vim.keymap.set("n", "zR", require("ufo").openAllFolds)
			vim.keymap.set("n", "zM", require("ufo").closeAllFolds)
		end,
	},

	{
		"b0o/incline.nvim",
		config = function()
			local helpers = require("incline.helpers")
			local devicons = require("nvim-web-devicons")
			require("incline").setup({
				window = {
					padding = 0,
					margin = { horizontal = 2, vertical = 2 },
				},
				render = function(props)
					local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
					if filename == "" then
						filename = "[No Name]"
					end
					local ft_icon, ft_color = devicons.get_icon_color(filename)
					local modified = vim.bo[props.buf].modified
					return {
						ft_icon and { " ", ft_icon, " ", guibg = ft_color, guifg = helpers.contrast_color(ft_color) }
							or "",
						" ",
						{ filename, gui = modified and "bold,italic" or "bold" },
						" ",
						guibg = "#44406e",
					}
				end,
			})
		end,
		event = "VeryLazy",
	},

	{
		"NvChad/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup()
		end,
		event = "VeryLazy",
	},

	{
		"vague2k/huez.nvim",
		branch = "stable",
		event = "UIEnter",
		config = function()
			require("huez").setup({})
		end,
	},

	{
		"chrisgrieser/nvim-rip-substitute",
		cmd = "RipSubstitute",
		keys = {
			{
				"<leader>rs",
				function()
					require("rip-substitute").sub()
				end,
				mode = { "n", "x" },
				desc = " rip substitute",
			},
		},
	},
}
