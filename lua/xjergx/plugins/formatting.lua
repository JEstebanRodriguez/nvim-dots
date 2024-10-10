return {
	{
		"stevearc/conform.nvim",
		config = function()
			require("conform").setup({
				formatters_by_ft = {
					lua = { "stylua" },
					python = { "isort", "black" },
					html = { "prettierd", "prettier", stop_after_first = true },
					csharp = { "csharpier", "dotnet-format" },
					javascript = { "prettierd", "prettier", stop_after_first = true },
					vue = { "prettierd", "prettier", stop_after_first = true },
					typescript = { "prettierd", "prettier", stop_after_first = true },
					css = { "prettierd", "prettier" },
					["*"] = { "prettierd", "prettier" },
				},
			})
			vim.api.nvim_create_autocmd("BufWritePre", {
				pattern = "*",
				callback = function(args)
					require("conform").format({ bufnr = args.buf })
				end,
			})
		end,
	},
}
