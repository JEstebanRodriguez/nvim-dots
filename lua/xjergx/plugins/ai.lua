return {
	{
		"Exafunction/codeium.vim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"hrsh7th/nvim-cmp",
		},
		commit = "289eb724e5d6fab2263e94a1ad6e54afebefafb2",
		event = "BufEnter",
		config = function()
			-- vim.keymap.set("i", "<C-g>", function()
			-- 	return vim.fn["codeium#Accept"]()
			-- end, { expr = true })
			-- vim.keymap.set("i", "<C-l>", function()
			-- 	return vim.fn["codeium#CycleCompletions"](1)
			-- end, { expr = true })
			-- vim.keymap.set("i", "<C-M>", function()
			-- 	return vim.fn["codeium#Complete"]()
			-- end, { expr = true })
			-- vim.keymap.set("i", "<C-x>", function()
			-- 	return vim.fn["codeium#Clear"]()
			-- end, { expr = true })
		end,
	},
}
