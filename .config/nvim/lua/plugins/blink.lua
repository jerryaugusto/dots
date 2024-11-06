local options = {
	highlight = {
		use_nvim_cmp_as_default = true,
	},
	nerd_font_variant = "normal",
	accept = { auto_brackets = { enabled = true } },

	trigger = { signature_help = { enabled = true } },

	-- "default | super-tab or table of keys"
	keymap = {
		["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
		["<C-e>"] = { "hide" },
		["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
		["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
		["<cr>"] = { "accept", "snippet_forward", "fallback" },
		["<Space>"] = { "accept", "fallback" },
	},

	windows = {
		autocomplete = {
			border = "none",
			-- border = "none",
			winhighlight = "Normal:CmpPmenu,CursorLine:Search,Search:None,FloatBorder:CmpBorder",
			-- winhighlight = 'Normal:BlinkCmpMenu,FloatBorder:BlinkCmpMenuBorder,CursorLine:BlinkCmpMenuSelection,Search:None',
			selection = "manual",
			-- draw = "reversed"
		},
		documentation = {
			max_width = 80,
			max_height = 30,
			border = "padded",
			-- border = "rounded",
			-- winhighlight = "Normal:CmpDoc,FloatBorder:CmpDocBorder",
			-- winhighlight = "Normal:CmpPmenu,CursorLine:Search,Search:None,FloatBorder:CmpBorder",
			-- auto_show = true,
		},
		ghost_text = {
			enabled = true,
		},
	},

	kind_icons = {
		Namespace = "󰘦", -- 󰌗
		Text = "󰉿",
		Method = "", -- 󰆧
		Function = "󰡱", -- 󰆧
		Constructor = "", --  󱌣
		Field = "󰜢",
		Variable = "󰀫",
		Class = "󰆦", -- 󰠱
		Interface = "󰆩", -- 
		Module = "󰜋",
		Property = "󰜢",
		Unit = "󰘨", -- 󰑭
		Value = "󰆙", -- 󰎠
		Enum = "󰪚", --  ❐ 󰘷
		Keyword = "󱕵", -- 󰌋
		Snippet = "", --  󰅴
		Color = "󰏘",
		File = "󰈚",
		Reference = "", -- 󰈇 󰗽
		Folder = "󰉋",
		EnumMember = "", -- 
		Constant = "󰕶", -- 󰏿
		Struct = "󰜬", -- 󰙅
		Event = "󰙴", -- 
		Operator = "", -- 󰆕
		TypeParameter = "󰊄",
		Table = "󰓫", -- 
		Object = "󰅩",
		Tag = "",
		Array = "󰅪", -- [
		Boolean = "",
		Number = "", -- 
		Null = "󰒉", -- 󰟢
		Supermaven = "",
		String = "", -- 󰉿
		Calendar = "",
		Watch = "󰥔",
		Package = "󰏗",
		Copilot = "",
		Codeium = "",
		TabNine = "",
		BladeNav = "",
	},
}

return options
