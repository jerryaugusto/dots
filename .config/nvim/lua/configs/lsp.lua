-- Same ui dialog to lsp hover
vim.cmd(":set winhighlight=" .. "Normal:CmpDoc,FloatBorder:CmpDocBorder")

-- local lspconfig_defaults = require("lspconfig").util.default_config
-- lspconfig_defaults.capabilities =
-- 	vim.tbl_deep_extend("force", lspconfig_defaults.capabilities, require("cmp").get_lsp_capabilities())

local uicons = require("ui")
local handler = {
	["textDocument/hover"] = vim.lsp.with(
		vim.lsp.handlers.hover,
		{ border = uicons.border.styled(uicons.glyph.ui.Info, "DiagnosticInfo", "Comment") }
	),
	["textDocument/signatureHelp"] = vim.lsp.with(
		vim.lsp.handlers.signature_help,
		{ border = uicons.border.styled(uicons.glyph.ui.Info, "DiagnosticInfo", "Comment") }
	),
}
require("mason").setup({
	ui = {
		icons = {
			package_installed = uicons.glyph.ui.Circle,
			package_pending = uicons.glyph.ui.SyncAlert,
			package_uninstalled = uicons.glyph.ui.CircleSmallAlt,
		},
	},
})
require("mason-lspconfig").setup({
	handlers = {
		function(server_name)
			require("lspconfig")[server_name].setup({
				handlers = handler,
			})
		end,
	},
	ensure_installed = {
		"lua_ls",
		"tailwindcss",
		"prismals",
		"cssls",
		"html",
		"emmet_language_server",
		"vtsls",
	},
})

require("mason-tool-installer").setup({
	ensure_installed = {
		"stylua",
		"selene",
	},
})

-- Lsp Autocmds
vim.api.nvim_create_autocmd("LspAttach", {
	desc = "LSP Actions",
	callback = function(event)
		-- Lsp Overloads Signature
		local client = vim.lsp.get_client_by_id(event.data.client_id)
		if client and client.server_capabilities.signatureHelpProvider then
			require("lsp-overloads").setup(client, {
				-- UI options are mostly the same as those passed to vim.lsp.util.open_floating_preview
				silent = true,
				floating_window_above_cur_line = true,
				ui = {
					border = uicons.border.styled(uicons.glyph.ui.Info, "DiagnosticInfo", "Comment"), -- The border to use for the signature popup window. Accepts same border values as |nvim_open_win()|.
					max_width = 130, -- Maximum signature popup width
					focusable = true, -- Make the popup float focusable
					focus = false, -- If focusable is also true, and this is set to true, navigating through overloads will focus into the popup window (probably not what you want)
					silent = true, -- Prevents noisy notifications (make false to help debug why signature isn't working)
					highlight = {
						italic = true,
						bold = true,
						fg = "#ffffff",
					},
				},
				keymaps = {
					next_signature = "<M-j>",
					previous_signature = "<M-k>",
					next_parameter = "<M-l>",
					previous_parameter = "<M-h>",
				},
				display_automatically = true, -- Uses trigger characters to automatically display the signature overloads when typing a method signature
			})
		end
		local function map(mode, keys, action, desc)
			desc = desc or ""
			local opts = { noremap = true, silent = true, desc = desc }
			vim.keymap.set(mode, keys, action, opts)
		end

		vim.api.nvim_set_keymap(
			"i",
			"<C-l>",
			"<cmd>LspOverloadsSignature<CR>",
			{ noremap = true, silent = true, buffer = event.bufnr }
		)
		vim.api.nvim_set_keymap(
			"n",
			"<C-l>",
			"<cmd>LspOverloadsSignature<CR>",
			{ noremap = true, silent = true, buffer = event.bufnr }
		)
		local builtin = require("telescope.builtin")
		map("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", "Hover")
		-- map("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>", "Go to definition")
		map("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", "Go to declarationn")
		map("n", "gd", function()
			builtin.lsp_definitions()
		end, "Go to definition")
		map("n", "gi", function()
			builtin.lsp_implementations()
		end, "Go to implementation")
		map("n", "gt", function()
			builtin.lsp_type_definitions()
		end, "Go to type definition")
		map("n", "go", "<cmd>lua vim.lsp.buf.type_definition()<cr>", "Go to type definition")
		map("n", "gs", "<cmd>lua vim.lsp.buf.signature_help()<cr>", "Go to Signature help")
		map("n", "gr", function()
			builtin.lsp_references()
		end, "Go to References")
		map("n", "gR", "<cmd>lua vim.lsp.buf.references()<cr>", "Go to References")
		map("n", "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<cr>", "Lsp Rename")
		map({ "n", "x" }, "<leader>lF", "<cmd>lua vim.lsp.buf.format({async = true})<cr>", "Lsp Format")
		map("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<cr>", "Open buffer diagnostics")
		map("n", "<leader>d", vim.diagnostic.open_float, "Open diagnostics window")
		map("n", "[d", vim.diagnostic.goto_next, "Go to next diagnostic")
		map("n", "]d", vim.diagnostic.goto_prev, "Go to previous diagnostic")
		map("n", "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<cr>", "Lsp Coda actions")
		map("n", "<leader>rs", "<cmd>LspRestart<cr>", "Restart LSP")

		-- if client then
		-- 	client.server_capabilities.semanticTokensProvider = nil
		-- end
	end,
})
