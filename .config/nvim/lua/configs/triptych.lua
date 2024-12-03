local ui = require("ui")
local triptych = require("triptych")

triptych.setup({
	mappings = {
		add = { "a", "o" },
		toggle_hidden = { "H", "<leader>." },
	},

	options = {
		highlights = {
			file_names = "TermCursorNC",
			directory_names = "SpecialKey",
		},
		file_icons = {
			fallback_file_icon = ui.glyph.kind.File,
		},
		border = ui.border.default("Comment"),
	},
})

vim.keymap.set("n", "<leader>-", "<cmd>Triptych<cr>", { silent = true, desc = "Toggle Triptych" })
