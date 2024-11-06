local api = vim.api
local autocmd = api.nvim_create_autocmd

-- don't auto comment new line
autocmd("BufEnter", { command = [[ set formatoptions-=cro ]] })

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	callback = function()
		vim.highlight.on_yank()
	end,
})

local function augroup(name)
	return vim.api.nvim_create_augroup("custom_" .. name, { clear = true })
end

-- auto set markdown filetype
autocmd({ "BufNewFile", "BufFilePre", "BufRead" }, {
	pattern = { "*.md" },
	callback = function()
		vim.cmd("set filetype=markdown")
	end,
})

-- atuo set http filetype
-- autocmd({ "BufNewFile", "BufFilePre", "BufRead" }, {
-- 	pattern = { "*.http" },
-- 	callback = function()
-- 		vim.cmd("set filetype=http")
-- 	end,
-- })

-- make sure you return to the same place you left.
autocmd("BufReadPost", {
	pattern = "*",
	callback = function()
		local line = vim.fn.line("'\"")
		if
			line > 1
			and line <= vim.fn.line("$")
			and vim.bo.filetype ~= "commit"
			and vim.fn.index({ "xxd", "gitrebase" }, vim.bo.filetype) == -1
		then
			vim.cmd('normal! g`"')
		end
	end,
})
