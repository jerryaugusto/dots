return {
	-- LaTex stuffs
	-- {
	-- 	"lervag/vimtex",
	-- 	ft = "latex",
	-- 	-- lazy = false, -- we don't want to lazy load VimTeX
	-- 	-- tag = "v2.15", -- uncomment to pin to a specific release
	-- 	init = function()
	-- 		-- VimTeX configuration goes here, e.g.
	-- 		vim.g.vimtex_view_method = "zathura"
	-- 	end,
	-- },
	-- Golang stuffs
	{
		"ray-x/go.nvim",
		-- enabled = false,
		-- event = { "CmdlineEnter" },
		ft = { "go", "gomod" },
		build = ':lua require("go.install").update_all_sync()',
		config = function()
			-- require("go").setup()
			require("configs.go")
		end,
		-- dependencies = { -- optional packages
		-- "ray-x/guihua.lua",
		-- "neovim/nvim-lspconfig",
		-- "nvim-treesitter/nvim-treesitter",
		--
		-- "leoluz/nvim-dap-go",
		-- },
	},

	-- TypeScript stuffs
	-- {
	-- 	"pmizio/typescript-tools.nvim",
	-- 	ft = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
	-- 	dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
	-- 	opts = {},
	-- 	config = function()
	-- 		require("configs.typescript")
	-- 	end,
	-- },
	-- {
	-- 	"yioneko/nvim-vtsls",
	-- 	ft = { "typescript", "typescriptreact", "javascript", "javascriptreact" }
	-- },
	-- {
	-- 	"dmmulroy/tsc.nvim",
	-- 	cmd = "TSC",
	-- 	config = function()
	-- 		require("tsc").setup()
	-- 	end,
	-- },
}
