local uicons = require("ui")

local M = {}

M.handlers = {
	["textDocument/hover"] = vim.lsp.with(
		vim.lsp.handlers.hover,
		{ border = uicons.border.styled(uicons.glyph.ui.Info, "DiagnosticInfo", "Comment") }
	),
	["textDocument/signatureHelp"] = vim.lsp.with(
		vim.lsp.handlers.signature_help,
		{ border = uicons.border.styled(uicons.glyph.ui.Info, "DiagnosticInfo", "Comment") }
	),
}

return M
