require("xjergx.config.options")
require("xjergx.config.lazy")
require("xjergx.config.keymaps")

-- Crear un grupo de autocmds para evitar duplicados
vim.api.nvim_create_augroup("set_catppuccin_theme", { clear = true })

-- Autocmd que se ejecuta al entrar en Neovim
vim.api.nvim_create_autocmd("VimEnter", {
	group = "set_catppuccin_theme",
	callback = function()
		-- Aquí estableces el tema catppuccin
		vim.cmd.colorscheme("catppuccin")
	end,
})
