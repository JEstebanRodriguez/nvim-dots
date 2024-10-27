return { -- Autoformat
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },
	keys = {
		{
			"<leader>cf",
			function()
				require("conform").format({ async = true, lsp_format = "fallback" })
			end,
			mode = "",
			desc = "[F]ormat buffer",
		},
	},
	opts = {
		notify_on_error = false,
		format_on_save = function(bufnr)
			-- Disable "format_on_save lsp_fallback" for languages that don't
			-- have a well standardized coding style. You can add additional
			-- languages here or re-enable it for the disabled ones.
			local disable_filetypes = { c = true, cpp = true }
			local lsp_format_opt
			if disable_filetypes[vim.bo[bufnr].filetype] then
				lsp_format_opt = "never"
			else
				lsp_format_opt = "fallback"
			end
			return {
				timeout_ms = 500,
				lsp_format = lsp_format_opt,
			}
		end,
		formatters_by_ft = {
			lua = { "stylua" },
			cs = { "csharpier" },
			javascript = { "prettierd", "prettier", stop_after_first = true },
			-- vue = { "prettierd", "prettier", stop_after_first = true },
			vue = { "eslint_d", "eslint", stop_after_first = true },
			typescript = { "prettierd", "prettier", stop_after_first = true },
		},

		vim.api.nvim_create_autocmd("BufWritePre", {
			pattern = "*",
			callback = function(args)
				require("conform").format({ bufnr = args.buf })
			end,
		}),
	},
}
-- return {
-- 	{
-- 		"stevearc/conform.nvim",
-- 		config = function()
-- 			require("conform").setup({
-- 				formatters_by_ft = {
-- 					lua = { "stylua" },
-- 					python = { "isort", "black" },
-- 					html = { "prettierd", "prettier", stop_after_first = true },
-- 					cs = { "csharpier" },
-- 					javascript = { "prettierd", "prettier", stop_after_first = true },
-- 					vue = { "prettierd", "prettier", stop_after_first = true },
-- 					typescript = { "prettierd", "prettier", stop_after_first = true },
-- 					css = { "prettierd", "prettier" },
-- 					["*"] = { "prettierd", "prettier" },
-- 				},
-- 			})
-- 			vim.api.nvim_create_autocmd("BufWritePre", {
-- 				pattern = "*",
-- 				callback = function(args)
-- 					require("conform").format({ bufnr = args.buf })
-- 				end,
-- 			})
-- 		end,
-- 	},
-- }
