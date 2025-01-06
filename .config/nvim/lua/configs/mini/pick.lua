local pick = require("mini.pick")

pick.setup({
	mappings = {
		move_down = "<Tab>",
		move_start = "<C-h>",
		move_up = "<S-Tab>",

		scroll_up = "<C-k>",
		scroll_down = "<C-j>",

		toggle_preview = "<C-p>",
		toggle_info = "<C-i>",
	},
	options = {
		use_cache = true,
	},
})
