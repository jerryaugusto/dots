return {
	-- lua functions that many plugins use
	{
		"nvim-lua/plenary.nvim",
	},

	-- NvChad ui
	{
		"nvchad/ui",
		event = "VeryLazy",
		config = function()
			require("nvchad")
		end,
	},

	-- Kanagawa the G O A T colorscheme ever!
	{
		"rebelot/kanagawa.nvim",
		lazy = true,
		priority = 1000,
		init = function()
			vim.cmd.colorscheme("kanagawa")
		end,
		config = function()
			require("configs.kanagawa")
		end,
	},

	-- Which-key stuffs
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		init = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 500
		end,
		opts = require("configs.which-key"),
	},

	-- Telescope stuffs
	{
		"nvim-telescope/telescope.nvim",
		event = "VeryLazy",
		branch = "0.1.x",
		dependencies = {
			"nvim-telescope/telescope-frecency.nvim",
			"nvim-lua/plenary.nvim",
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "make",
			},
		},
		config = function()
			require("configs.telescope")
		end,
	},
	{
		"prochri/telescope-all-recent.nvim",
		dependencies = {
			"nvim-telescope/telescope.nvim",
			"kkharji/sqlite.lua",
			-- optional, if using telescope for vim.ui.select
			"stevearc/dressing.nvim",
		},
		opts = {
			-- your config goes here
		},
	},
	-- Telescope file browser
	{
		"nvim-telescope/telescope-file-browser.nvim",
		dependencies = {
			"nvim-telescope/telescope.nvim",
			"nvim-lua/plenary.nvim",
		},
	},

	-- Statusline stuffs
	{
		"nvim-lualine/lualine.nvim",
		event = "VeryLazy",
		dependencies = {
			"linrongbin16/lsp-progress.nvim",
			config = function()
				require("configs.lsp-progress")
				-- require "lsp-progress".setup()
			end,
		},
		config = function()
			require("configs.lualine")
		end,
	},
}
