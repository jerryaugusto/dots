return {
	"echasnovski/mini.indentscope",
	event = "VeryLazy",
	version = "*",
	config = function()
		require("mini.indentscope").setup({
			symbol = "│", -- 󰇙   ▏  │
		})
	end,
}
