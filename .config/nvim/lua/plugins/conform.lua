return {
	"stevearc/conform.nvim",
  enabled = false,
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local conform = require("conform")
		local keymap = vim.keymap.set

		conform.setup({
			formaters_by_ft = {
				go = { "goimports", "gofumpt" },
				lua = { "stylua" },
			},
			format_on_save = {
				lsp_fallback = true,
				async = false,
				timeout_ms = 1000,
			},
		})

		keymap({ "n", "v" }, "<leader>lF", function()
			conform.format({
				lsp_fallback = true,
				async = false,
				timeout_ms = 1000,
			})
		end, { desc = "Format file or range (in visual mode)" })
	end,
}
