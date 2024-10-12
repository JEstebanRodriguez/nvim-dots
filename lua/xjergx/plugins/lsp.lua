return {
	{ "folke/neoconf.nvim" },
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			{ "williamboman/mason.nvim", config = true },
			"williamboman/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",
			"pmizio/typescript-tools.nvim",
			{ "j-hui/fidget.nvim", opts = {} },
			"hrsh7th/cmp-nvim-lsp",
		},
		config = function()
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("attach", { clear = true }),
				callback = function(event)
					local map = function(keys, func, desc, mode)
						mode = mode or "n"
						vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
					end
					map("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
					map("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
					map("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")
					map("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")
					map("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
					map(
						"<leader>ws",
						require("telescope.builtin").lsp_dynamic_workspace_symbols,
						"[W]orkspace [S]ymbols"
					)
					map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
					map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

					local client = vim.lsp.get_client_by_id(event.data.client_id)
					if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
						local highlight_augroup = vim.api.nvim_create_augroup("lsp-highlight", { clear = false })
						vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
							buffer = event.buf,
							group = highlight_augroup,
							callback = vim.lsp.buf.document_highlight,
						})

						vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
							buffer = event.buf,
							group = highlight_augroup,
							callback = vim.lsp.buf.clear_references,
						})

						vim.api.nvim_create_autocmd("LspDetach", {
							group = vim.api.nvim_create_augroup("lsp-detach", { clear = true }),
							callback = function(event2)
								vim.lsp.buf.clear_references()
								vim.api.nvim_clear_autocmds({ group = "lsp-highlight", buffer = event2.buf })
							end,
						})
					end
					if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
						map("<leader>th", function()
							vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
						end, "[T]oggle Inlay [H]ints")
					end
				end,
			})

			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

			local lspconfig = require("lspconfig")
			local neoconf = require("neoconf")
			local is_vue3_project = neoconf.get("is-vue3-project")

			if is_vue3_project then
				-- Configuración de Volar para proyectos Vue 3
				lspconfig.volar.setup({
					capabilities = capabilities,
					filetypes = { "vue", "typescript", "javascript", "typescriptreact", "javascriptreact" },
					init_options = {
						typescript = {
							tsdk = "@volar/language-server",
						},
					},
					settings = {
						volar = {
							languageFeatures = {
								diagnostics = true,
								completion = {
									defaultTagNameCase = "kebab",
									defaultAttrNameCase = "kebab",
								},
								format = {
									enable = true,
								},
							},
						},
					},
				})
			else
				-- Configuración de Vetur para proyectos Vue 2 y Nuxt 2
				lspconfig.vuels.setup({
					cmd = { "/home/juan/.nvm/versions/node/v16.20.2/bin/vls", "--stdio" },
					capabilities = capabilities,
					settings = {
						vetur = {
							validation = {
								template = true,
								script = true,
								style = true,
								typeCheck = true, -- Agrega esta línea para habilitar el chequeo de tipos
							},
							experimental = {
								templateInterpolationService = true,
							},
							completion = {
								autoImport = true,
								useScaffoldSnippets = true,
							},
							format = {
								enable = true,
								options = {
									tabSize = 2,
									useTabs = false,
								},
							},
							languageFeatures = {
								codeActions = true,
								diagnostics = true, -- Mantén esta opción habilitada
								completion = {
									defaultTagNameCase = "kebab",
									defaultAttrNameCase = "kebab",
								},
							},
						},
					},
					filetypes = { "vue", "javascript", "typescript" },
				})
			end

			-- Configuración para otros servidores LSP
			lspconfig.lua_ls.setup({
				capabilities = capabilities,
				settings = {
					Lua = {
						completion = {
							callSnippet = "Replace",
						},
					},
				},
			})

			lspconfig.omnisharp.setup({
				capabilities = capabilities,
				filetypes = { "cs", "vb" },
				root_dir = function(fname)
					return lspconfig.util.root_pattern("*.sln", "*.csproj", "project.json")(fname)
				end,
				settings = {
					omnisharp = {
						enable_editorconfig_support = true,
						enable_ms_build_load_projects_on_demand = true,
						enable_roslyn_analyzers = true,
						organize_imports_on_format = true,
						enable_import_completion = true,
						enable_roslyn_diagnostics = true,
					},
				},
			})
		end,
	},
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = { "eslint", "ts_ls", "omnisharp_mono", "cssls", "lua_ls", "volar", "vuels" },
			})
		end,
	},
}

-- return {
-- 	{
-- 		"williamboman/mason.nvim",
-- 		config = function()
-- 			require("mason").setup()
-- 		end,
-- 	},
-- 	{
-- 		"williamboman/mason-lspconfig.nvim",
-- 		config = function()
-- 			require("mason-lspconfig").setup({
-- 				ensure_installed = { "eslint", "ts_ls", "omnisharp_mono", "cssls", "lua_ls" },
-- 			})
-- 		end,
-- 	},
-- 	{
-- 		"neovim/nvim-lspconfig",
-- 		dependencies = {
-- 			"williamboman/mason-lspconfig.nvim",
-- 			"hrsh7th/cmp-nvim-lsp",
-- 			"hrsh7th/cmp-vsnip",
-- 			"hrsh7th/vim-vsnip",
-- 			"jose-elias-alvarez/null-ls.nvim",
-- 			"jayp0521/mason-null-ls.nvim",
-- 		},
-- 		config = function()
-- 			local lspconfig = require("lspconfig")
--
-- 			local capabilities = require("cmp_nvim_lsp").default_capabilities()
--
-- 			lspconfig.omnisharp.setup({ capabilities = capabilities })
--
-- 			lspconfig.cssls.setup({
-- 				capabilities = capabilities,
-- 			})
--
-- 			lspconfig.lua_ls.setup({ capabilities = capabilities })
--
-- 			lspconfig.ts_ls.setup({
-- 				capabilities = capabilities,
-- 				init_options = {
-- 					plugins = {
-- 						{
-- 							name = "@vue/typescript-plugin",
-- 							languages = { "vue" },
-- 						},
-- 					},
-- 				},
-- 				filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "json" },
-- 			})
--
-- 			lspconfig.volar.setup({
-- 				capabilities = capabilities,
-- 				root_dir = lspconfig.util.root_pattern("tsconfig.json", ".git"),
-- 				filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue", "json" },
-- 				init_options = {
-- 					typescript = {
-- 						serverPath = vim.fn.stdpath("data")
-- 							.. "/mason/packages/typescript-language-server/node_modules/typescript/lib/tsserverlibrary.js",
-- 					},
-- 				},
-- 				settings = {
-- 					volar = {
-- 						vueVersion = 2,
-- 						languageFeatures = {
-- 							diagnostics = true, -- Habilita los diagnósticos de TypeScript
-- 							completion = true, -- Habilita la autocompletación
-- 							format = true, -- Habilita el formateo
-- 						},
-- 					},
-- 				},
-- 			})
--
-- 			vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "LSP Rename" })
-- 			vim.keymap.set("n", "<leader>cca", vim.lsp.buf.code_action, { desc = "LSP Code Action" })
-- 			vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "LSP Definition" })
-- 			vim.keymap.set("n", "gr", require("telescope.builtin").lsp_references, { desc = "LSP References" })
-- 			vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { desc = "LSP Implementation" })
-- 			vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "LSP Hover" })
-- 			vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, { desc = "LSP Signature Help" })
-- 		end,
-- 	},
-- 	-- {
-- 	-- 	{
-- 	-- 		"folke/lazydev.nvim",
-- 	-- 		ft = "lua", -- only load on lua files
-- 	-- 		opts = {
-- 	-- 			library = {
-- 	-- 				-- See the configuration section for more details
-- 	-- 				-- Load luvit types when the `vim.uv` word is found
-- 	-- 				{ path = "luvit-meta/library", words = { "vim%.uv" } },
-- 	-- 			},
-- 	-- 		},
-- 	-- 	},
-- 	-- 	{ "Bilal2453/luvit-meta", lazy = true }, -- optional `vim.uv` typings
-- 	-- 	{ -- optional completion source for require statements and module annotations
-- 	-- 		"hrsh7th/nvim-cmp",
-- 	-- 		opts = function(_, opts)
-- 	-- 			opts.sources = opts.sources or {}
-- 	-- 			table.insert(opts.sources, {
-- 	-- 				name = "lazydev",
-- 	-- 				group_index = 0, -- set group index to 0 to skip loading LuaLS completions
-- 	-- 			})
-- 	-- 		end,
-- 	-- 	},
-- 	-- 	-- { "folke/neodev.nvim", enabled = false }, -- make sure to uninstall or disable neodev.nvim
-- 	-- },
-- }
