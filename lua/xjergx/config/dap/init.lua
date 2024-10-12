local dap, dapui = require("dap"), require("dapui")
require("dap-go").setup()

-- Setup Virtual Text
require("nvim-dap-virtual-text").setup({
	virtual_text = true,
	enabled = true,
})

-- for _, ft_path in ipairs(vim.api.nvim_get_runtime_file("lua/xjergx/dap/configs/*.lua", true)) do
-- 	loadfile(ft_path)()
-- end

-- Signs
vim.fn.sign_define("DapBreakpoint", { text = "🛑", texthl = "", linehl = "", numhl = "" })
vim.fn.sign_define("DapStopped", { text = "▶", texthl = "", linehl = "", numhl = "" })
vim.fn.sign_define("DapBreakpointRejected", { text = "🚫", texthl = "", linehl = "", numhl = "" })
vim.fn.sign_define("DapBreakpointCondition", { text = "❓", texthl = "", linehl = "", numhl = "" })
vim.fn.sign_define("DapLogPoint", { text = "💬", texthl = "", linehl = "", numhl = "" })

require("xjergx.config.dap.configs.dotnet")
-- require("xjergx.config.dap.configs.go")
require("xjergx.config.dap.configs.javascript")

-- UI structure
-- dapui.setup({
-- 	icons = { expanded = "▾", collapsed = "▸" },
-- 	layouts = {
-- 		{
-- 			elements = {
-- 				"scopes",
-- 				"breakpoints",
-- 				"stacks",
-- 				"watches",
-- 			},
-- 			size = 80,
-- 			position = "right",
-- 		},
-- 		{
-- 			elements = {
-- 				"repl",
-- 				"console",
-- 			},
-- 			size = 10,
-- 			position = "bottom",
-- 		},
-- 	},
-- })
--
dapui.setup({
	layouts = {
		{
			elements = {
				"breakpoints",
				"scopes",
				"watches",
			},
			size = 40,
			position = "left",
		},
		{
			elements = {
				"repl",
				"console",
			},
			size = 0.25, -- 25% of total lines
			position = "bottom",
		},
	},
})

-- Events Listeners
dap.listeners.after.event_initialized["dapui_config"] = function()
	dapui.open()
end

-- Cerrar dap-ui automáticamente cuando termine la depuración
dap.listeners.before.event_terminated["dapui_config"] = function()
	dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
	dapui.close()
end

-- Configurar teclas para depuración y dap-ui
vim.api.nvim_set_keymap("n", "<F5>", '<cmd>lua require"dap".continue()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<F10>", '<cmd>lua require"dap".step_over()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<F11>", '<cmd>lua require"dap".step_into()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<F12>", '<cmd>lua require"dap".step_out()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap(
	"n",
	"<leader>b",
	'<cmd>lua require"dap".toggle_breakpoint()<CR>',
	{ noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
	"n",
	"<leader>B",
	'<cmd>lua require"dap".set_breakpoint(vim.fn.input("Breakpoint condition: "))<CR>',
	{ noremap = true, silent = true }
)
vim.api.nvim_set_keymap("n", "<leader>dr", '<cmd>lua require"dap".repl.open()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>dl", '<cmd>lua require"dap".run_last()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>du", '<cmd>lua require"dapui".toggle()<CR>', { noremap = true, silent = true })

vim.api.nvim_set_keymap("n", "<leader>de", '<cmd>lua require"dapui".eval()<CR>', { noremap = true, silent = true })
