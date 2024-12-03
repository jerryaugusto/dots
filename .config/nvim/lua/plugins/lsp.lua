return {
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			-- Lua stuffs
			{
				"folke/lazydev.nvim",
				ft = "lua", -- only load on lua files
				opts = {
					library = {
						-- See the configuration section for more details
						-- Load luvit types when the `vim.uv` word is found
						{ path = "luvit-meta/library", words = { "vim%.uv" } },
					},
				},
			},
			{
				"antosha417/nvim-lsp-file-operations",
				config = function ()
					require("lsp-file-operations").setup()
				end,
			},
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",
			-- "onsails/lspkind.nvim",
			"youssef-lr/lsp-overloads.nvim",
		},
		config = function()
			require("configs.lsp")
		end,
	},
}
