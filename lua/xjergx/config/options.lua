vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.mouse = "a"
vim.opt.numberwidth = 2
vim.opt.signcolumn = "yes:3"
vim.opt.colorcolumn = "120"
vim.opt.cursorline = true
vim.opt.wrap = true
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.hlsearch = false
vim.opt.hidden = true
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8
vim.opt.updatetime = 250
vim.opt.cmdheight = 1
vim.opt.showmode = false
vim.opt.laststatus = 3
vim.opt.wrap = true
vim.opt.clipboard = "unnamedplus"
vim.opt.ignorecase = true

vim.opt.foldmethod = "syntax"
vim.opt.foldcolumn = "1"
vim.g.statuscolumn = {
	folds_open = false,
	folds_githl = false,
}

vim.opt.foldlevel = 99
vim.opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp", "folds" }
vim.opt.fillchars = {
	foldopen = "▼",
	foldclose = "▶",
	fold = " ",
	foldsep = " ",
	diff = "╱",
	eob = " ",
	stlnc = "—",
}

local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end
