local conf_path = vim.fn.stdpath("config") --[[@as string]]

local plugins = {
	-- Rest client stuffs
	{
		"mistweaverco/kulala.nvim",
		ft = "url",
		opts = require("plugins.kulala"),
	},

	-- Linter stuffs
	{
		"mfussenegger/nvim-lint",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("plugins.lint")
		end,
	},

	-- Formatter stuffs
	{
		"stevearc/conform.nvim",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("plugins.conform")
		end,
	},

	-- Tests stuffs
	-- {
	-- 	"nvim-neotest/neotest",
	-- 	dependencies = {
	-- 		"nvim-neotest/neotest-jest",
	-- 	},
	-- 	config = function()
	-- 		require("plugins.neotest")
	-- 	end,
	-- },

	-- Debugger stuffs
	-- {
	-- 	-- NOTE: Yes, you can install new plugins here!
	-- 	"mfussenegger/nvim-dap",
	-- 	-- NOTE: And you can specify dependencies as well
	-- 	dependencies = {
	-- 		-- Creates a beautiful debugger UI
	-- 		"rcarriga/nvim-dap-ui",
	--
	-- 		-- Required dependency for nvim-dap-ui
	-- 		"nvim-neotest/nvim-nio",
	--
	-- 		-- Installs the debug adapters for you
	-- 		"williamboman/mason.nvim",
	-- 		"jay-babu/mason-nvim-dap.nvim",
	--
	-- 		-- Add your own debuggers here
	-- 		"mxsdev/nvim-dap-vscode-js",
	-- 		"leoluz/nvim-dap-go",
	-- 	},
	-- 	config = function()
	-- 		require("plugins.dap")
	-- 	end,
	-- },

	-- Go stuffs
	{
		"ray-x/go.nvim",
		ft = { "go", "gomod" },
		dependencies = { -- optional packages
			"ray-x/guihua.lua",
			"neovim/nvim-lspconfig",
			"nvim-treesitter/nvim-treesitter",

			"leoluz/nvim-dap-go",
		},

		config = function()
			require("plugins.go")
		end,

		-- event = { "CmdlineEnter" },
		build = ':lua require("go.install").update_all_sync()',
	},

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

	-- Rust stuffs
	{
		"mrcjkb/rustaceanvim",
		ft = "rust",
		version = "^5", -- Recommended
		-- lazy = false, -- This plugin is already lazy
	},

	-- Typescript stuffs
	{
		"pmizio/typescript-tools.nvim",
		ft = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
		dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
		opts = {},
		config = function()
			require("plugins.typescript-tools")
		end,
	},
	{
		"dmmulroy/tsc.nvim",
		ft = "typescript",
		cmd = "TSC",
		opts = {},
	},

	-- Markdown stuffs
	{
		"MeanderingProgrammer/render-markdown.nvim",
		ft = "markdown",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
		},
	},

	{
		"ggandor/leap.nvim",
		dependencies = { "tpope/vim-repeat" },
		init = function()
			require("leap").create_default_mappings()
		end,
	},

	-- Autopair stuffs
	{
		"altermo/ultimate-autopair.nvim",
		lazy = false,
		event = { "InsertEnter", "CmdlineEnter" },
		branch = "v0.6",
		opts = require("plugins.ultimate-autopair"),
	},

	-- Completion stuffs
	{
		"saghen/blink.cmp",
		-- FIXME "lazy = false" doesn't work
		event = { "LspAttach", "InsertCharPre" }, -- NOTE required to work
		version = "v0.*",
		dependencies = {
			"saghen/blink.compat",
			"rafamadriz/friendly-snippets",
		},
		sources = {
			completion = {
				enabled_providers = { "lsp", "path", "snippets", "buffer", "lazydev" },
			},
		},
		providers = {
			lazydev = {
				name = "lazydev",
				module = "blink.compact",
				score_offset = 0,
			},
		},

		opts = require("plugins.blink"),
	},

	-- Syntax highlight stuffs
	{
		"nvim-treesitter/nvim-treesitter",
		name = "treesitter",
		dependencies = {
			-- "JoosepAlviste/nvim-ts-context-commentstring",
			"nvim-treesitter/nvim-treesitter-textobjects",
			"windwp/nvim-ts-autotag",
		},
		cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
		build = ":TSUpdate",
		event = {
			"BufReadPost",
			"BufNewFile",
		},
		config = function()
			require("plugins.tree-sitter")
		end,
	},

	-- Colorscheme stuffs
	{
		"rebelot/kanagawa.nvim",
		lazy = true,
		priority = 1000,
		init = function()
			vim.cmd.colorscheme("kanagawa")
		end,
		config = function()
			require("plugins.kanagawa")
		end,
	},

	--- Mini stuffs
	{
		"echasnovski/mini.nvim",
		name = "mini",
		version = false,

		keys = function()
			require("mappings").mini()
		end,

		init = function()
			require("plugins.mini_init")
		end,

		event = function()
			require("plugins.mini_event")
		end,

		config = function()
			require("plugins.mini_modules")
		end,
	},

	-- {
	--   "Bekaboo/dropbar.nvim",
	--   enabled = false,
	--   name = "dropbar",
	--   keys = {
	--     require("mappings").map({ "n" }, "<leader>p", function()
	--       require("dropbar.api").pick(vim.v.count ~= 0 and vim.v.count)
	--     end, "Toggle dropbar menu"),
	--   },
	--   event = { "BufReadPost", "BufNewFile" },
	--   config = function()
	--     require("dropbar").setup()
	--   end,
	-- },

	--- Language server stuffs
	{
		"neovim/nvim-lspconfig",
		name = "lspconfig",
		cmd = { "LspInfo", "LspInstall", "LspUninstall" },
		event = { "BufReadPost", "BufNewFile" },
		keys = function()
			require("mappings").lsp()
		end,
		config = function()
			require("plugins.lsp")
		end,
	},

	{
		name = "options",
		event = "VeryLazy",
		dir = conf_path,
		config = function()
			require("opts").final()
			require("mappings").general()
			require("mappings").misc()
			require("modules").autocmds()
		end,
	},
}

require("lazy").setup(plugins, {
	concurrency = 4,
	defaults = {
		lazy = true,
	},
	install = {
		missing = true,
		colorscheme = { "kanagawa" },
	},
	dev = {
		path = vim.env.NVIM_DEV,
	},
	performance = {
		cache = {
			enabled = true,
		},
		reset_packpath = true,
		rtp = {
			disabled_plugins = {
				"2html_plugin",
				"tohtml",
				"getscript",
				"getscriptPlugin",
				"gzip",
				"logipat",
				"netrw",
				"netrwPlugin",
				"netrwSettings",
				"netrwFileHandlers",
				"tar",
				"rrhelper",
				"spellfile_plugin",
				"vimball",
				"vimballPlugin",
				"zip",
				"zipPlugin",
				"tutor",
				"rplugin",
				"syntax",
				"synmenu",
				"optwin",
				"compiler",
				"bugreport",
				"ftplugin",
				"osc52",
				"parser",
				"health",
				"man",
				"matchit",
				"tarPlugin",
				"shadafile",
				"spellfile",
				"editorconfig",
			},
		},
	},
	checker = {
		enabled = true,
		notify = false,
	},
	change_detection = {
		enabled = true,
		notify = true,
	},
	ui = {
		border = "rounded",
		title = "lazy.nvim",
		size = { width = 0.8, height = 0.8 },
		icons = {
			ft = "󰈚", -- 
			lazy = "󰒲 ", -- 󰂠
			loaded = "", -- 
			not_loaded = "", -- 
		},
	},
})
