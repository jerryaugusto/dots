local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

-- don't auto comment new line
autocmd("BufEnter", { command = [[ set formatoptions-=cro ]] })

-- Highlight trailing whitespace as an error when leaving insert mode
autocmd("InsertLeave", {
	pattern = "*",
	callback = function()
		vim.fn.matchadd("Error", [[\s\+$]])
	end,
})

--Automatically highlight the copied text
autocmd("TextYankPost", {
	desc = "Highlight when yank (copying) test",
	group = augroup("highlight-yank", { clear = true }),
	-- pattern = "*",
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- Restore the cursor in the previous position when opening a file
autocmd("BufReadPost", {
	pattern = "*",
	callback = function()
		local last_pos = vim.fn.line([['"]])
		if last_pos > 0 and last_pos <= vim.fn.line("$") then
			vim.api.nvim_win_set_cursor(0, { last_pos, 0 })
		end
	end,
})

-- Automatically close the help window
autocmd("FileType", {
	pattern = "help",
	command = "nnoremap <buffer> q :q<CR>",
})

-- Automatically close floating and inactive terminal windows.
autocmd({ "WinLeave", "BufLeave" }, {
	pattern = { "help", "terminal", "nofile" },
	callback = function()
		if vim.bo.filetype == "help" or vim.bo.filetype == "terminal" then
			vim.cmd("quit")
		end
	end,
})

-- Automatically define the type of indentation based on the file
autocmd("BufReadPost", {
	pattern = "*",
	callback = function()
		local file_indent = vim.fn.search([[^\s*\t]], "n") > 0 and "tab" or "space"
		if file_indent == "tab" then
			vim.bo.expandtab = false
			vim.bo.shiftwidth = 4
			vim.bo.tabstop = 4
		else
			vim.bo.expandtab = true
			vim.bo.shiftwidth = 2
			vim.bo.tabstop = 2
		end
	end,
})

-- Automatically recharge the file if there are external changes
autocmd({ "FocusGained", "BufEnter" }, {
	pattern = "*",
	command = "checktime",
})

-- Automatically disable the mouse in insertion mode
autocmd("InsertEnter", {
	callback = function()
		vim.opt.mouse = ""
	end,
})
autocmd("InsertLeave", {
	callback = function()
		vim.opt.mouse = "a"
	end,
})
