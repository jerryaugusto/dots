local M = {}

M.basics = {
	options = {
		extra_ui = true,
		win_borders = "single",
	},
}

-- M.completion = {
-- 	mappings = "",
-- }

M.pairs = {
	-- mappings = {
	--   ["<"] = { action = "closeopen", pair = "<>", neigh_pattern = "[^\\].", register = { cr = false } },
	-- },
}

M.files = {
	use_as_default_explorer = true,
	windows = {
		max_number = math.huge,
		preview = true,
		width_focus = 30,
		width_nofocus = 20,
		width_preview = 25,
	},
}

local hipatterns = require("mini.hipatterns")
M.hipatterns = {
	highlighters = {
		fixme = { pattern = "%f[%w]()FIXME()%f[%W]", group = "MiniHipatternsFixme" },
		hack = { pattern = "%f[%w]()HACK()%f[%W]", group = "MiniHipatternsHack" },
		todo = { pattern = "%f[%w]()TODO()%f[%W]", group = "MiniHipatternsTodo" },
		note = { pattern = "%f[%w]()NOTE()%f[%W]", group = "MiniHipatternsNote" },
		hex_color = hipatterns.gen_highlighter.hex_color(),
	},
}

M.bufremove = {
	silent = true,
}

M.comment = {}

M.pick = {
	options = {
		use_cache = true,
	},
}

M.move = {
	mappings = {
		left = "<S-h>",
		right = "<S-l>",
		down = "<S-j>",
		up = "<S-k>",
		line_left = "<S-h>",
		line_right = "<S-l>",
		line_down = "<S-j>",
		line_up = "<S-k>",
	},
}

M.indentscope = {
	symbol = "│", -- ┋
}

M.ai = {}

M.visits = {
	store = {
		path = vim.fn.stdpath("cache") .. "mini-visits-index",
	},
}

local miniclue = require("mini.clue")
M.clue = {
	triggers = {
		{ mode = "n", keys = "<Leader>" },
		{ mode = "x", keys = "<Leader>" },

		{ mode = "i", keys = "<C-x>" },

		{ mode = "n", keys = "g" },
		{ mode = "x", keys = "g" },

		{ mode = "n", keys = "'" },
		{ mode = "n", keys = "`" },
		{ mode = "x", keys = "'" },
		{ mode = "x", keys = "`" },

		{ mode = "n", keys = '"' },
		{ mode = "x", keys = '"' },
		{ mode = "i", keys = "<C-r>" },
		{ mode = "c", keys = "<C-r>" },

		{ mode = "n", keys = "<C-w>" },

		{ mode = "n", keys = "z" },
		{ mode = "x", keys = "z" },
	},

	clues = {
		miniclue.gen_clues.builtin_completion(),
		miniclue.gen_clues.g(),
		miniclue.gen_clues.marks(),
		miniclue.gen_clues.registers(),
		miniclue.gen_clues.windows(),
		miniclue.gen_clues.z(),
	},
}

M.notify = {
	window = {
		winblend = 0,
	},
}

M.git = {}

M.diff = {
	view = {
		style = "sign",
		signs = { add = "│ ", change = "󰇝", delete = "" }, --    ┋ 󰍵 󰇝 󰠵
	},
}

local starter = require("mini.starter")

M.starter = {
	evaluate_single = false,
	header = table.concat({
		" 𝙔𝘼𝙔!ーーーーー",
		" ☆  *    .      ☆",
		"     . ∧＿∧    ∩    * ☆",
		"*  ☆ ( ・∀・)/ .",
		"  .  ⊂         ノ* ☆",
		"  ☆ * (つ ノ  .☆",
		"       (ノ",
	}, "\n"),
	footer = os.date(),
	items = {
		{
			name = "Bookmarked files 󰃀",
			action = "lua MiniExtra.pickers.visit_paths { filter = 'todo' }",
			section = "Actions ",
		},
		{ name = "Lazy update ", action = ":Lazy update", section = "Actions " }, -- 󰒲
		{ name = "Open blank file 󰺪", action = ":enew", section = "Actions " },
		{ name = "Find files 󰺮", action = "lua MiniPick.builtin.files()", section = "Actions " },
		{ name = "Recent files 󰪷", action = "lua MiniExtra.pickers.oldfiles()", section = "Actions " },
		{ name = "Quit ", action = ":q!", section = "Actions " }, -- 󰍃 󰗽
	},
	content_hooks = {
		starter.gen_hook.aligning("center", "center"),
	},
}

M.icons = {
	default = {
		file = { glyph = "󰈚" },
	},
	directory = {
		public = { glyph = "󰉌", hl = "MiniIconsBlue" },
	},
	extension = {
		ocaml = { glyph = "", hl = "MiniIconsOrange" },
		re = { glyph = "", hl = "MiniIconsRed" },
		res = { glyph = "", hl = "MiniIconsRed" },
		txt = { glyph = "󰈚", hl = "MiniIconsMagenta" },
		go = { glyph = "", hl = "MiniIconsBlue" },
		yml = { glyph = "󰰳", hl = "MiniIconsMagenta" },
		yaml = { glyph = "󰰳", hl = "MiniIconsMagenta" },
		toml = { glyph = "󰰤", hl = "MiniIconsMagenta" },
		png = { glyph = "󰸭", hl = "MiniIconsGreen" },
		jpg = { glyph = "󰈥", hl = "MiniIconsBlue" },
		gif = { glyph = "󰵸", hl = "MiniIconsMagenta" },
		csv = { glyph = "󱃡", hl = "MiniIconsGreen" },
		mp4 = { glyph = "󰌲", hl = "MiniIconsCyan" },
		mkv = { glyph = "󰌲", hl = "MiniIconsOrange" },
		doc = { glyph = "󰈭", hl = "MiniIconsBlue" },
		zip = { glyph = "󰗄", hl = "MiniIconsGreen" },
		fish = { glyph = "" }, --   󱆃
		lock = { glyph = "󰌾", hl = "MiniIconsRed" },
		-- jsx = { hl = "MiniIconsBlue" },
		-- tsx = { hl = "MiniIconsPurple" },
	},
	file = {
		["Makefile"] = { glyph = "󰦬", hl = "MiniIconsOrange" }, --   󱌢
		["makefile"] = { glyph = "󰦬", hl = "MiniIconsOrange" }, --   󱌢
		["COPYING"] = { glyph = "", hl = "MiniIconsBlue" },
		["LICENSE"] = { glyph = "󰑺", hl = "MiniIconsYellow" }, -- 󰯂
		[".eslintrc.js"] = { glyph = "󰱺", hl = "MiniIconsYellow" },
		[".node-version"] = { glyph = "󰋘", hl = "MiniIconsGreen" },
		[".prettierrc"] = { glyph = "", hl = "MiniIconsPurple" },
		[".yarnrc.yml"] = { glyph = "", hl = "MiniIconsBlue" },
		["eslint.config.js"] = { glyph = "󰱺", hl = "MiniIconsYellow" },
		[".eslintrc.cjs"] = { glyph = "󰱺", hl = "MiniIconsYellow" },
		["package.json"] = { glyph = "", hl = "MiniIconsGreen" },
		["tsconfig.json"] = { glyph = "", hl = "MiniIconsAzure" },
		["tsconfig.build.json"] = { glyph = "", hl = "MiniIconsAzure" },
		["yarn.lock"] = { glyph = "", hl = "MiniIconsBlue" },
		["lazy-lock.json"] = { hl = "MiniIconsRed" },
		["kitty.conf"] = { glyph = "" },
		[".tmux.conf"] = { glyph = "", hl = "MiniIconsMagenta" },
		["tmux.conf"] = { glyph = "", hl = "MiniIconsMagenta" },
		[".terraformrc"] = { glyph = "󱁢", hl = "MiniIconsBlue" },
		["terraform.rc"] = { glyph = "󱁢", hl = "MiniIconsBlue" },
		["Dockerfile"] = { glyph = "󰡨", hl = "MiniIconsBlue" },
		["compose.yml"] = { glyph = "", hl = "MiniIconsOrange" },
		["compose.yaml"] = { glyph = "", hl = "MiniIconsOrange" },
		["docker-compose.yml"] = { glyph = "", hl = "MiniIconsOrange" },
		["docker-compose.yaml"] = { glyph = "", hl = "MiniIconsOrange" },
		["go.mod"] = { glyph = "", hl = "MiniIconsBlue" },
		["go.sum"] = { glyph = "", hl = "MiniIconsRed" },
		["biome.json"] = { glyph = "", hl = "MiniIconsBlue" }, -- 󱘗 󰒔 󰾒 
		[".eslintrc.json"] = { glyph = "", hl = "MiniIconsBlue" },
		["tailwind.config.ts"] = { glyph = "󱏿", hl = "MiniIconsCyan" },
		["package-lock.json"] = { glyph = "", hl = "MiniIconsRed" },
		["README.md"] = { glyph = "", hl = "MiniIconsBlue" },
		["init.lua"] = { glyph = "", hl = "MiniIconsGreen" },
		[".env"] = { glyph = "", hl = "MiniIconsMagenta" },
		[".toml "] = { glyph = "󰰤", hl = "MiniIconsMagenta" },
	},
	lsp = {
		["function"] = { glyph = "󰡱", hl = "MiniIconsCyan" },
	},
}

return M
