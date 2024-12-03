local ui = require("ui")
local tst = require("typescript-tools")
-- local lsp = require("core.lsp")

tst.setup({
	handlers = {
		["textDocument/hover"] = vim.lsp.with(
			vim.lsp.handlers.hover,
			{ border = ui.border.styled(ui.glyph.ui.Info, "DiagnosticInfo", "Comment") }
		),
		["textDocument/signatureHelp"] = vim.lsp.with(
			vim.lsp.handlers.signature_help,
			{ border = ui.border.styled(ui.glyph.ui.Info, "DiagnosticInfo", "Comment") }
		),
	},
	on_attach = function(client, _)
		client.server_capabilities.documentFormattingProvider = true
		client.server_capabilities.documentRangeFormattingProvider = true

		-- lsp.on_attach(client, bufnr)
	end,
	settings = {
		separate_diagnostic_server = true,
		composite_mode = "separate_diagnostic",
		publish_diagnostic_on = "insert_leave",
		-- tsserver_logs = "verbose",
		tsserver_file_preferences = {
			importModuleSpecifierPreference = "non-relative",
		},
		complete_function_calls = true,
		code_lens = "all", -- "off" | "all" | "implementations_only" | "references_only"
		disable_member_code_lens = false,
		jsx_close_tag = {
			enable = true,
			filetypes = { "javascriptreact", "typescriptreact" },
		}
	},
})
