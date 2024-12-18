return {
	-- {
	-- 	"saghen/blink.cmp",
	-- 	event = { "InsertEnter", "CmdlineEnter" },
	-- 	-- lazy = false, -- lazy loading handled internally
	-- 	-- optional: provides snippets for the snippet source
	-- 	dependencies = {
	-- 		"hrsh7th/nvim-cmp",
	-- 		"rafamadriz/friendly-snippets",
	-- 	},
	--
	-- 	-- use a release tag to download pre-built binaries
	-- 	version = "v0.*",
	-- 	-- OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
	-- 	-- build = 'cargo build --release',
	-- 	-- If you use nix, you can build from source using latest nightly rust with:
	-- 	-- build = 'nix run .#build-plugin',
	--
	-- 	---@module 'blink.cmp'
	-- 	---@type blink.cmp.Config
	-- 	opts = {
	-- 		-- 'default' for mappings similar to built-in completion
	-- 		-- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys to navigate)
	-- 		-- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
	-- 		-- see the "default configuration" section below for full documentation on how to define
	-- 		-- your own keymap.
	-- 		-- keymap = { preset = "default" },
	-- 		keymap = {
	-- 			preset = "enter",
	-- 			["<Tab>"] = { "select_next", "fallback" },
	-- 			["<S-Tab>"] = { "select_prev", "fallback" },
	-- 			["<CR>"] = { "accept", "fallback" },
	-- 			["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
	-- 		},
	--
	-- 		appearance = {
	-- 			-- Sets the fallback highlight groups to nvim-cmp's highlight groups
	-- 			-- Useful for when your theme doesn't support blink.cmp
	-- 			-- will be removed in a future release
	-- 			use_nvim_cmp_as_default = true,
	-- 			-- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
	-- 			-- Adjusts spacing to ensure icons are aligned
	-- 			nerd_font_variant = "mono",
	-- 		},
	--
	-- 		-- default list of enabled providers defined so that you can extend it
	-- 		-- elsewhere in your config, without redefining it, via `opts_extend`
	-- 		sources = {
	-- 			completion = {
	-- 				enabled_providers = { "lsp", "path", "snippets", "buffer" },
	-- 			},
	-- 		},
	--
	-- 		-- experimental auto-brackets support
	-- 		-- completion = { accept = { auto_brackets = { enabled = true } } }
	--
	-- 		-- experimental signature help support
	-- 		-- signature = { enabled = true }
	-- 	},
	-- 	-- allows extending the enabled_providers array elsewhere in your config
	-- 	-- without having to redefine it
	-- 	opts_extend = { "sources.completion.enabled_providers" },
	-- },
	-- {
	-- 	"Saghen/blink.cmp",
	-- 	-- event = "VeryLazy",
	-- 	event = { "InsertEnter", "CmdlineEnter" },
	-- 	-- event = { "LspAttach", "InsertCharPre" },
	-- 	version = "v0.*",
	-- 	dependencies = {
	-- 		"hrsh7th/nvim-cmp",
	-- 		"rafamadriz/friendly-snippets",
	-- 		"saghen/blink.compat",
	-- 		-- { "chrisgrieser/cmp-nerdfont", lazy = true },
	-- 		-- { "hrsh7th/cmp-emoji", lazy = true },
	-- 	},
	-- 	-- opts = require "configs.blink"
	-- 	config = function()
	-- 		require("configs.blink")
	-- 	end,
	-- },
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			{
				"hrsh7th/cmp-cmdline",
				event = "VeryLazy",
				opts = function()
					local cmp = require("cmp")
					return {
						{
							type = "/",
							mapping = cmp.mapping.preset.cmdline(),
							sources = {
								{ name = "buffer" },
							},
						},
						{
							type = ":",
							mapping = cmp.mapping.preset.cmdline(),
							sources = cmp.config.sources({
								{ name = "path" },
							}, {
								{
									name = "cmdline",
									option = {
										ignore_cmds = { "Man", "!" },
									},
								},
							}),
						},
					}
				end,
				config = function(_, opts)
					local cmp = require("cmp")
					vim.tbl_map(function(val)
						cmp.setup.cmdline(val.type, val)
					end, opts)
				end,
			},
			{ "hrsh7th/cmp-nvim-lsp-signature-help" },
			{ "roobert/tailwindcss-colorizer-cmp.nvim", config = true },
			{ "hrsh7th/cmp-nvim-lsp" },
			{ "hrsh7th/cmp-buffer" },
			{ "hrsh7th/cmp-path" },
			{
				"L3MON4D3/LuaSnip",
				version = "v2.*",
				build = "make install_jsregexp",
			},
			{ "hrsh7th/cmp-nvim-lua" },
			{ "saadparwaiz1/cmp_luasnip" },
			{ "rafamadriz/friendly-snippets" },
			{ "lukas-reineke/cmp-rg" },
			{ "f3fora/cmp-spell", ft = { "gitcommit", "NeogitCommitMessage", "markdown", "norg", "org" } },
			{ "petertriho/cmp-git", opts = { filetypes = { "gitcommit", "NeogitCommitMessage" } } },
			-- { "rcarriga/cmp-dap" },
			{ "onsails/lspkind.nvim" },
		},
		config = function()
			require("configs.cmp")
		end,
	},
}
