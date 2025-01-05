local function map(mode, keys, action, desc)
	desc = desc or ""
	local opts = { noremap = true, silent = true, desc = desc }
	vim.keymap.set(mode, keys, action, opts)
end

local pick = require("mini.pick")
local builtin = pick.builtin
local extra = require("mini.extra")
local visits = require("mini.visits")

map({ "n" }, "<leader>ff", function()
	builtin.files()
end, "find files")

map({ "n" }, "<leader>fb", function()
	builtin.buffers()
end, "Find buffers")

map({ "n" }, "<leader>fr", function()
	builtin.resume()
end, "Resume finding")

map({ "n" }, "<leader>fw", function()
	builtin.grep_live()
end, "Grep live")

vim.b[0].miniindentscope_disable = true

map({ "n" }, "<leader>tB", function()
	vim.b[0].miniindentscope_disable = not vim.b[0].miniindentscope_disable -- Toggle blankline animations
end, "Toggle blankline animations")

map({ "n" }, "<leader>e", function()
	local _ = require("mini.files").close() or require("mini.files").open()
end, "Toggle minifiles")

map({ "n" }, "<leader>q", function()
	require("mini.bufremove").delete()
end, "Remove current buffer")

map("n", "<A-s>", function()
	extra.pickers.visit_paths({ filter = "todo" })
end, "Add file to todolist")

map("n", "<A-a>", function()
	visits.add_label("todo")
end, "Remove file from todolist")

map("n", "<A-A>", function()
	visits.remove_label()
end, "Remove label from file")

map("n", "<leader>gc", function()
	extra.pickers.git_commits()
end, "Show git commits")

map("n", "<leader>gh", function()
	extra.pickers.git_hunks()
end, "Show git hunks")

map("n", "<leader>dp", function()
	extra.pickers.diagnostic()
end, "Diagnostic in picker")

-- Language Server Protocol
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfig", {}),
	callback = function(ev)
		vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

		-- local conform = require("conform")
		--- Set minipick as default picker
		-- local pick = require("mini.pick")
		vim.ui.select = pick.ui_select

		-- Diagnostics mappings
		map("n", "dp", function()
			vim.diagnostic.goto_prev({ float = false })
		end, "Diagnostics goto_prev")

		map("n", "dn", function()
			vim.diagnostic.goto_next({ float = false })
		end, "Diagnostics goto_next")

		map("n", "<leader>ds", vim.diagnostic.setloclist, "Add buffer diagnostics to the location list.")

		-- map("n", "<leader>hi", function()
		-- 	modules.toggle_inlay_hint() -- toggle inlay hint
		-- end, "Toggle inlay hint")
		map("n", "<leader>hi", function()
			local is_enabled = vim.lsp.inlay_hint.is_enabled()
			vim.lsp.inlay_hint.enable(not is_enabled)
		end, "Toggle inlay hints")

		map("n", "<leader>K", vim.lsp.buf.hover, "Open lsp hover")
		map("n", "<leader>df", function()
			vim.diagnostic.open_float()
		end, "Open diagnostics float ")
		map("n", "<leader>ld", vim.lsp.buf.definition, "Goto lsp definition")
		map("n", "<leader>lh", vim.lsp.buf.declaration, "Goto lsp declaration")
		map("n", "<leader>lt", vim.lsp.buf.type_definition, "Goto lsp type definition")
		map("n", "<leader>lc", vim.lsp.buf.document_symbol, "Document symbols")
		map("n", "<leader>lw", vim.lsp.buf.workspace_symbol, "Workspace symbols")
		map("n", "<leader>li", vim.lsp.buf.implementation, "Goto lsp implementation")
		map("n", "<leader>lR", vim.lsp.buf.references, "Goto lsp reference")
		map({ "n", "v" }, "<leader>la", vim.lsp.buf.code_action, "Open lsp code action")
		-- map({ "n", "v" }, "<leader>lf", function()
		-- 	conform.format({
		-- 		lsp_fallback = true,
		-- 		async = false,
		-- 		timeout_ms = 1000,
		-- 	})
		-- end, "Conform format")
		-- map("n", "<leader>lF", function()
		-- 	vim.lsp.buf.format({ async = true })
		-- end, "Lsp format")
		map("n", "<leader>lr", vim.lsp.buf.rename, "Lsp rename")
		-- map({ "i", "x" }, "<c-space>", vim.lsp.buf.signature_help, "Lsp signature help")
	end,
})
