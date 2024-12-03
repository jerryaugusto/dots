vim.cmd("let g:netrw_liststyle = 3")

local opt = vim.opt
local o = vim.o
local g = vim.g
-- local opts = {}

local space = "·"
-- opts.initial = function()
-- g.mapleader = " "
opt.guifont = "JetBrainsMono Nerd Font:h10"
opt.laststatus = 3
opt.clipboard = "unnamedplus"
opt.termguicolors = true
opt.fileencoding = "utf-8"
opt.fillchars:append({
	eob = " ",
})
opt.showbreak = "↪"
opt.list = true
opt.listchars:append({
	eol = "¬",
	tab = "  ", -- :▷⋮ 󰍟 │─
	trail = " ", -- 󰄮 󰿦
	space = space,
	multispace = space,
	lead = " ",
	-- leadmultispace = space,
	extends = "󰄾",
	precedes = "󰄽",
	conceal = "─", -- 󰩽
	nbsp = "󰄮", -- 󰟾
})
opt.shortmess:append("aIF")
opt.cursorline = true
opt.cursorlineopt = "both"
opt.ruler = true
opt.breakindent = true
opt.linebreak = true
opt.swapfile = false
opt.undofile = true
opt.cmdheight = 0
opt.confirm = true
-- opt.number = true
opt.relativenumber = true
opt.scrolloff = 100

-- end

-- o.undofile = true
-- opt.undofile = true

-- opt.guifont = "JetBrainsMono Nerd Font:h10"
--
-- opt.number = true
-- opt.relativenumber = true

-- tabs & indentation
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.autoindent = true

opt.wrap = false

-- search stuff
opt.ignorecase = true
opt.smartcase = true

opt.cursorline = true

opt.termguicolors = true
opt.background = "dark"
opt.signcolumn = "yes"

opt.backspace = "indent,eol,start"

opt.clipboard:append("unnamedplus")

opt.splitright = true
opt.splitbelow = true

-- disable some default providers
g.loaded_node_provider = 0
g.loaded_python3_provider = 0
g.loaded_perl_provider = 0
g.loaded_ruby_provider = 0

--- Load shada after ui-enter
local shada = vim.o.shada
vim.o.shada = ""
vim.api.nvim_create_autocmd("User", {
	pattern = "VeryLazy",
	callback = function()
		vim.o.shada = shada
		pcall(vim.cmd.rshada, { bang = true })
	end,
})

-- add binaries installed by mason.nvim to path
local is_windows = vim.fn.has "win32" ~= 0
local sep = is_windows and "\\" or "/"
local delim = is_windows and ";" or ":"
vim.env.PATH = table.concat({ vim.fn.stdpath "data", "mason", "bin" }, sep) .. delim .. vim.env.PATH

-- return opts
