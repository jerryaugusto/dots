local modules = require("modules")

local function map(mode, keys, action, desc)
	desc = desc or ""
	local opts = { noremap = true, silent = true, desc = desc }
	vim.keymap.set(mode, keys, action, opts)
end

local M = {}

-- Expose the map function
M.map = map

M.general = function()
	map("i", "<C-h>", "<Left>")
	map("i", "<C-j>", "<Down>")
	map("i", "<C-k>", "<Up>")
	map("i", "<C-l>", "<Right>")
	map("n", ";", ":", "cmd enter command mode")
	map("i", "jk", "<ESC>")
	map("i", "jj", "<ESC>")
	map("n", "<Esc>", "<cmd>nohlsearch<CR>", "Clear highlights on search")
	map("n", "<C-h>", "<C-w>h")
	map("n", "<C-j>", "<C-w>j")
	map("n", "<C-k>", "<C-w>k")
	map("n", "<C-l>", "<C-w>l")
	map("n", "<C-s>", "<cmd>update<CR>")
	map("n", "<Tab>", "<cmd>bnext<CR>")
	map("n", "<s-Tab>", "<cmd>bprev<CR>")

	-- map("n", "<A-k>", ":resize +2<CR>")
	-- map("n", "<A-j>", ":resize -2<CR>")
	map("n", "<A-l>", ":vertical resize +2<CR>")
	map("n", "<A-h>", ":vertical resize -2<CR>")

	-- increment/decrement numbers
	map("n", "<leader>=", "<C-a>", "Increment number")
	map("n", "<leader>-", "<C-x>", "Decrement number")

	-- Select all
	map("n", "<C-a>", "ggVG")
	map({ "i", "v" }, "<C-a>", "<Esc>ggVG")

	-- VSCode-like 'alt+k/j' Move selected line / block of text in visual mode
	-- map("v", "<A-j>", ":m '>+1<CR>gv=gv")
	-- map("v", "<A-k>", ":m '<-2<CR>gv=gv")

	-- better indenting
	map("v", "<", "<gv")
	map("v", ">", ">gv")

	-- paste over currently selected text without yanking it
	map("v", "P", '"_dP')
	map("v", "p", '"_dp')

	-- Move line on the screen rather than by line in the file
	map("n", "j", "gj")
	map("n", "k", "gk")

	-- Move to start/end of line
	map({ "n", "x", "o" }, "H", "^")
	map({ "n", "x", "o" }, "L", "g_")

	-- Map enter to ciw in normal mode
	map("i", "<C-BS>", "<Esc>ciw", "Delete a word") -- Ctrl + backspace delete a word
	map("n", "<C-BS>", "hdiw", "Delete a word")
	map("n", "<CR>", "ciw")
	map("n", "<BS>", "ci")

	-- New line
	map("n", "<leader>o", "o<Esc>", "Create new line below without entering edit mode")
	map("n", "<leader>O", "O<Esc>", "Create new line above without entering edit mode")

	-- Debugger
	-- local dap = require("dap")
	-- local dapui = require("dapui")
	-- map("n", "<F5>", dap.continue, "Debug: Start/Continue")
	-- map("n", "<F1>", dap.step_into, "Debug: Step Into")
	-- map("n", "<F2>", dap.step_over, "Debug: Step Over")
	-- map("n", "<F3>", dap.step_out, "Debug: Step Out")
	-- map("n", "<leader>tb", dap.toggle_breakpoint, "Debug: Toggle Breakpoint")
	-- map("n", "<leader>B", function()
	-- 	dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
	-- end, "Debug: Set Breakpoint")
	-- map("n", "<F7>", dapui.toggle, "Debug: See last session result.")

	-- Disable arrow keys
	map({ "i", "n", "v" }, "<Left>", "<NOP>")
	map({ "i", "n", "v" }, "<Down>", "<NOP>")
	map({ "i", "n", "v" }, "<Up>", "<NOP>")
	map({ "i", "n", "v" }, "<Right>", "<NOP>")

	map("n", "<C-d>", "<C-d>zz")
	map("n", "<C-u>", "<C-u>zz")
	map("v", "??", 'y:h <C-R>"<cr>"') -- Show vim help
	map("v", "?/", 'y:/ <C-R>"<cr>"') -- Search across the buffer
end

M.mini = function()
	local minipick = require("mini.pick")
	local miniextra = require("mini.extra")
	local minivisits = require("mini.visits")
	local builtin = minipick.builtin

	map({ "n" }, "<leader>ff", function()
		builtin.files()
	end, "find files")

	map({ "n" }, "<leader>b", function()
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
		miniextra.pickers.visit_paths({ filter = "todo" })
	end, "Add file to todolist")

	map("n", "<A-a>", function()
		minivisits.add_label("todo")
	end, "Remove file from todolist")

	map("n", "<A-A>", function()
		minivisits.remove_label()
	end, "Remove label from file")

	map("n", "<leader>gc", function()
		miniextra.pickers.git_commits()
	end, "Show git commits")

	map("n", "<leader>gh", function()
		miniextra.pickers.git_hunks()
	end, "Show git hunks")

	map("n", "<leader>dp", function()
		miniextra.pickers.diagnostic()
	end, "Diagnostic in picker")
end

M.misc = function()
	map("n", "<leader>n", function()
		modules.toggle_numbering()
	end, "Toggle line numbering")

	map("n", "<leader>tf", function()
		modules.toggle_flow()
	end, "Toggle flow")
end

M.lsp = function()
	-- map the following keys on lsp attach only
	vim.api.nvim_create_autocmd("LspAttach", {
		group = vim.api.nvim_create_augroup("UserLspConfig", {}),
		callback = function(ev)
			vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

			local conform = require("conform")
			--- Set minipick as default picker
			local minipick = require("mini.pick")
			vim.ui.select = minipick.ui_select

			-- Diagnostics mappings
			map("n", "dp", function()
				vim.diagnostic.goto_prev({ float = false })
			end, "Diagnostics goto_prev")

			map("n", "dn", function()
				vim.diagnostic.goto_next({ float = false })
			end, "Diagnostics goto_next")

			map("n", "<leader>ds", vim.diagnostic.setloclist, "Add buffer diagnostics to the location list.")

			map("n", "<leader>hi", function()
				modules.toggle_inlay_hint() -- toggle inlay hint
			end, "Toggle inlay hint")

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
			map({ "n", "v" }, "<leader>lf", function()
				conform.format({
					lsp_fallback = true,
					async = false,
					timeout_ms = 1000,
				})
			end, "Conform format")
			map("n", "<leader>lF", function()
				vim.lsp.buf.format({ async = true })
			end, "Lsp format")
			map("n", "<leader>lr", vim.lsp.buf.rename, "Lsp rename")
			map({ "i", "x" }, "<c-space>", vim.lsp.buf.signature_help, "Lsp signature help")
		end,
	})
end

-- Rest Client
local kulala = require("kulala")

map({ "n" }, "<leader>kr", function()
	kulala.run()
end, "Kulala run")

map({ "n" }, "<leader>kc", function()
	kulala.close()
end, "Kulala close")

map({ "n" }, "<leader>ka", function()
	kulala.run_all()
end, "Kulala run all")

map({ "n" }, "<leader>kk", function()
	kulala.replay()
end, "Kulala rerun")

map({ "n" }, "<leader>ki", function()
	kulala.inspect()
end, "Kulala inspect")

map({ "n" }, "<leader>ks", function()
	kulala.show_stats()
end, "Kulala show status")

map({ "n" }, "<leader>kt", function()
	kulala.toggle_view()
end, "Kulala toggle view")

map({ "n" }, "<leader>kp", function()
	kulala.scratchpad()
end, "Kulala scratchpad")

return M
