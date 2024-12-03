return {
	-- Flah stuffs
	{
		"folke/flash.nvim",
		event = "VeryLazy",
		---@type Flash.Config
		opts = {},
		-- stylua: ignore
		keys = {
			{ "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
			{ "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
			{ "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
			{ "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
			{ "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
		},
	},

	-- Eyeline stuffs
	{
		"jinh0/eyeliner.nvim",
		keys = { "f", "F", "t", "T" },
		config = function()
			require("eyeliner").setup({
				highlight_on_key = true,
				match = "[%w]",
			})

			vim.api.nvim_set_hl(0, "EyelinerPrimary", { fg = "#FFA066", underline = true })
			vim.api.nvim_set_hl(0, "EyelinerSecondary", { fg = "#717C7C", underline = true })
		end,
	},

	-- Substitue stuffs
	{
		"gbprod/substitute.nvim",
		keys = { "<leader>s", "<leader>S", "<leader>x", "<leader>X" },
		config = function()
			local map = vim.keymap.set

			local substitute = require("substitute")
			local substitute_exchange = require("substitute.exchange")

			substitute.setup({})

			map("n", "<leader>s", substitute.operator)
			map("n", "<leader>ss", substitute.line)
			map("n", "<leader>S", substitute.eol)
			map("x", "<leader>s", substitute.visual)

			map("n", "<leader>x", substitute_exchange.operator)
			map("n", "<leader>xx", substitute_exchange.line)
			map("n", "<leader>xc", substitute_exchange.cancel)
			map("n", "<leader>X", substitute_exchange.visual)
		end,
	},
}
