local ui = require("ui")

vim.diagnostic.config({
	virtual_text = {
		prefix = "",
		suffix = "",
		format = function(diagnostic)
			return " " .. diagnostic.message .. " " -- 󰍡 󱓻  
		end,
	},
	underline = {
		severity = { min = vim.diagnostic.severity.WARN },
	},
	signs = {
		text = {
			[vim.diagnostic.severity.HINT] = "󰌶", -- 󱐮     󱧢 󱠃 󰌶
			[vim.diagnostic.severity.ERROR] = "", -- ✘
			[vim.diagnostic.severity.INFO] = "󰋽", --   ◉    
			[vim.diagnostic.severity.WARN] = "", --   󰗖
		},
	},

	float = {
		show_header = true,
		source = "always",
		border = ui.border.styled(ui.glyph.ui.Lightbulb, "DiagnosticHint", "Comment"),
		focusable = false,
		format = function(d)
			local t = vim.deepcopy(d)
			local code = d.code or (d.user_data and d.user_data.lsp.code)
			if code and not string.find(t.message, code, 1, true) then
				t.message = string.format("%s [%s]", t.message, code):gsub("1. ", "")
			end
			return t.message
		end,
	},
})
