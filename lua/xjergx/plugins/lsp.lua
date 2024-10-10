return {
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end
	},
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = { "eslint", "ts_ls", "omnisharp_mono", "cssls", "lua_ls" },
			})
		end
	},
	{
		"neovim/nvim-lspconfig",
    dependencies = { "williamboman/mason-lspconfig.nvim", "hrsh7th/cmp-nvim-lsp" },
		config = function()
			local lspconfig = require("lspconfig")
      local capabilities = require('cmp_nvim_lsp').default_capabilities()

      lspconfig.omnisharp.setup({ capabilities = capabilities })

      lspconfig.cssls.setup({
        capabilities = capabilities
      })

			lspconfig.lua_ls.setup({ capabilities = capabilities })

      lspconfig.ts_ls.setup({ capabilities = capabilities })

      lspconfig.volar.setup({ capabilities = capabilities })

      vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, { desc = "LSP Rename" })
      vim.keymap.set('n', '<leader>cca', vim.lsp.buf.code_action, { desc = "LSP Code Action" })
      vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = "LSP Definition" })
      vim.keymap.set('n', 'gr', require('telescope.builtin').lsp_references, { desc = "LSP References" })
      vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, { desc = "LSP Implementation" })
      vim.keymap.set('n', 'K', vim.lsp.buf.hover, { desc = "LSP Hover" })
      vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, { desc = "LSP Signature Help" })
    end
	},
}




































