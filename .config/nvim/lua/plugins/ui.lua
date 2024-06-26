local icons = require "config.icons"

return {
	-- Neovim plugin to improve the default vim.ui interfaces
	{
		"stevearc/dressing.nvim",
		event = "VeryLazy",
		dependencies = { "MunifTanjim/nui.nvim" },
		opts = {},
		config = function()
			require("dressing").setup()
		end,
	},

	-- Neovim notifications and LSP progress messages
	-- {
	--   "j-hui/fidget.nvim",
	--   branch = "legacy",
	--   enabled = false,
	--   config = function()
	--     require("fidget").setup({
	--       window = { blend = 0 },
	--     })
	--   end,
	-- },

	-- Extensible Neovim Scrollbar
	{
		"petertriho/nvim-scrollbar",
		event = "VeryLazy",
		dependencies = {
			{
				"kevinhwang91/nvim-hlslens",
				config = function()
					require("hlslens").setup()
				end,
			},
		},
		config = function()
			require("scrollbar").setup()
		end,
	},
  -- VSCode-like lightbulb for neovim's built-in LSP
  {
    'kosayoda/nvim-lightbulb',
    event = 'LspAttach',
    opts = {
      autocmd = { enabled = true },
      sign = { enabled = false },
      float = { text = icons.ui.Lightbulb, enabled = true, win_opts = { border = 'none' } },
    },
  },
}
