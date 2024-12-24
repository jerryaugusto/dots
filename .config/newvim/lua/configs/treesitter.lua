local treesitter = require("nvim-treesitter.configs")

treesitter.setup({
	autotag = { enabled = true },
	auto_install = true,
	sync_install = false,
	ignore_install = { "javascript" },
	modules = {},
	indent = { enabled = true },
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
	},
	matchup = {
		enable = true,
	},
	{
		context_commentstring = {
			enable = true,
			enable_autocmd = true,
		},
	},
	incremental_selection = {
		enable = true,
		keymaps = {
			init_selection = "<leader>v",
			node_incremental = "v",
			scope_incremental = false,
			node_decremental = "V",
		},
	},
	textobjects = {
		lsp_interop = {
			enabled = true,
			border = "rounded",
			floating_preview_opts = {},
			peek_definition_code = {
				["<leader>df"] = "@function.outer",
				["<leader>dF"] = "@class.outer",
			},
		},
		select = {
			enable = true,
			lookahead = true,

			keymaps = {
				-- You can use the capture groups defined in textobjects.scm
				["af"] = { query = "@function.outer", desc = "around a function" },
				["if"] = { query = "@function.inner", desc = "inner part of a function" },
				["ac"] = { query = "@class.outer", desc = "around a class" },
				["ic"] = { query = "@class.inner", desc = "inner part of a class" },
				["ai"] = { query = "@conditional.outer", desc = "around an if statement" },
				["ii"] = { query = "@conditional.inner", desc = "inner part of an if statement" },
				["al"] = { query = "@loop.outer", desc = "around a loop" },
				["il"] = { query = "@loop.inner", desc = "inner part of a loop" },
				["ap"] = { query = "@parameter.outer", desc = "around parameter" },
				["ip"] = { query = "@parameter.inner", desc = "inside a parameter" },
			},
			selection_modes = {
				["@parameter.outer"] = "v", -- charwise
				["@parameter.inner"] = "v", -- charwise
				["@function.outer"] = "v", -- charwise
				["@conditional.outer"] = "V", -- linewise
				["@loop.outer"] = "V", -- linewise
				["@class.outer"] = "<c-v>", -- blockwise
			},
			include_surrounding_whitespace = false,
		},
		move = {
			enable = true,
			set_jumps = true, -- whether to set jumps in the jumplist
			goto_previous_start = {
				["[f"] = { query = "@function.outer", desc = "Previous function" },
				["[c"] = { query = "@class.outer", desc = "Previous class" },
				["[p"] = { query = "@parameter.inner", desc = "Previous parameter" },
			},
			goto_next_start = {
				["]f"] = { query = "@function.outer", desc = "Next function" },
				["]c"] = { query = "@class.outer", desc = "Next class" },
				["]p"] = { query = "@parameter.inner", desc = "Next parameter" },
			},
		},
		swap = {
			enable = true,
			swap_next = {
				["<leader>a"] = "@parameter.inner",
			},
			swap_previous = {
				["<leader>A"] = "@parameter.inner",
			},
		},
	},
	ensure_installed = {
		"bash",
		"css",
		"dockerfile",
		"fish",
		"git_config",
		"git_rebase",
		"gitattributes",
		"gitcommit",
		"gitignore",
		"go",
		"html",
		"http",
		"javascript",
		"xml",
		"jq",
		"json",
		"jsonc",
		"lua",
		"luap",
		"make",
		"markdown",
		"markdown_inline",
		"query",
		"regex",
		"scheme",
		"scss",
		"sql",
		"toml",
		"typescript",
		"tsx",
		"templ",
		"vim",
		"vimdoc",
		"yaml",
	},
})
