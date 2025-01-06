local function border(glyph, msg_lvl, hl_name)
	return {
		{ glyph, msg_lvl },
		{ "─", hl_name },
		{ "╮", hl_name },
		{ "│", hl_name },
		{ "╯", hl_name },
		{ "─", hl_name },
		{ "╰", hl_name },
		{ "│", hl_name },
	}
end

local blink = require("blink.cmp")

blink.setup({
	enabled = function()
		return not vim.tbl_contains({ "markdown" }, vim.bo.filetype)
			and vim.bo.buftype ~= "prompt"
			and vim.b.completion ~= false
	end,

	keymap = {
		preset = "default",

		-- NOTE This is required to use Enter only once to select
		cmdline = {
			preset = "default",
		},

		["<CR>"] = { "accept", "fallback" },
		["<M-1>"] = {
			function(cmp)
				cmp.accept({ index = 1 })
			end,
		},
		["<M-2>"] = {
			function(cmp)
				cmp.accept({ index = 2 })
			end,
		},
		["<M-3>"] = {
			function(cmp)
				cmp.accept({ index = 3 })
			end,
		},
		["<M-4>"] = {
			function(cmp)
				cmp.accept({ index = 4 })
			end,
		},
		["<M-5>"] = {
			function(cmp)
				cmp.accept({ index = 5 })
			end,
		},
		["<M-6>"] = {
			function(cmp)
				cmp.accept({ index = 6 })
			end,
		},
		["<M-7>"] = {
			function(cmp)
				cmp.accept({ index = 7 })
			end,
		},
		["<M-8>"] = {
			function(cmp)
				cmp.accept({ index = 8 })
			end,
		},
		["<M-9>"] = {
			function(cmp)
				cmp.accept({ index = 9 })
			end,
		},
		["<M-0>"] = {
			function(cmp)
				cmp.accept({ index = 10 })
			end,
		},

		["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
		["<C-e>"] = { "hide", "fallback" },

		-- ['<CR>'] = { 'select_and_accept', 'fallback' },
		["<Tab>"] = { "select_next", "fallback" },
		["<S-Tab>"] = { "select_prev", "fallback" },
	},
	completion = {
		accept = { auto_brackets = { enabled = true } },
		trigger = {
			show_on_keyword = true,
			show_on_insert_on_trigger_character = false,
		},
		keyword = { range = "full" },
		menu = {
			border = border("󱐋", "DiagnosticWarn", "Comment"), -- 
			min_width = vim.o.pumwidth,
			max_height = 30,
			winblend = vim.o.pumblend,
			scrollbar = false,

			-- cmdline_position = function()
			-- 	if vim.g.ui_cmdline_pos ~= nil then
			-- 		local pos = vim.g.ui_cmdline_pos -- (1, 0)-indexed
			-- 		return { pos[1] - 1, pos[2] }
			-- 	end
			-- 	local height = (vim.o.cmdheight == 0) and 1 or vim.o.cmdheight
			-- 	return { vim.o.lines - height, 0 }
			-- end,

			draw = {
				columns = {
					{ "kind_icon" },
					{ "item_idx" },
					{ "label", "label_description", gap = 1 },
					{ "kind" },
				},
				components = {
					kind_icon = {
						-- highlight = "BlinkCmpKind",
						ellipsis = false,
					},
					item_idx = {
						text = function(ctx)
							return ctx.idx == 10 and "0" or ctx.idx >= 10 and " " or tostring(ctx.idx)
						end,
						highlight = "BlinkCmpGhostText", -- optional, only if you want to change its color
					},
					label = {
						text = require("colorful-menu").blink_components_text,
						highlight = require("colorful-menu").blink_components_highlight,
					},
					label_description = { highlight = "BlinkCmpLabelDescription" },
				},
			},
			-- winhighlight = "Normal:BlinkCmpDoc,FloatBorder:BlinkCmpDocBorder,CursorLine:BlinkCmpDocCursorLine,Search:None",
			winhighlight = "Normal:Comment,CursorLine:Search,Search:PmenuSel,FloatBorder:Comment", -- NvChad personal
			-- winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,Search:None",
		},
		documentation = {
			auto_show = true,
			auto_show_delay_ms = 250,
			-- treesitter_highlighting = true,
			window = {
				min_width = 15,
				max_width = 120,
				max_height = 40,
				winblend = vim.o.pumblend,
				-- winhighlight = "Normal:BlinkCmpDoc,FloatBorder:BlinkCmpDocBorder,CursorLine:BlinkCmpDocCursorLine,Search:None",
				winhighlight = "Normal:Comment,CursorLine:Search,Search:PmenuSel,FloatBorder:Comment", -- NvChad personal
				-- winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,Search:None",
				border = border("", "DiagnosticInfo", "Comment"),
			},
		},
		list = {
			selection = function(ctx)
				return ctx.mode == "cmdline" and "auto_insert" or "preselect"
			end,
		},
	},

	signature = {
		enabled = true,
		window = {
			min_width = 1,
			max_width = 100,
			max_height = 10,
			winblend = vim.o.pumblend,
			border = border("󰷼", "DiagnosticInfo", "Comment"),
			-- winhighlight = "Normal:BlinkCmpDoc,FloatBorder:BlinkCmpDocBorder,CursorLine:BlinkCmpDocCursorLine,Search:None",
			winhighlight = "Normal:Comment,CursorLine:Search,Search:PmenuSel,FloatBorder:Comment", -- NvChad personal
			-- winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,Search:None",
		},
	},

	sources = {
		-- Dynamically picking providers by treesitter node/filetype
		default = function()
			local success, node = pcall(vim.treesitter.get_node)
			if vim.bo.filetype == "lua" then
				return { "lsp", "path" }
			elseif
				success
				and node
				and vim.tbl_contains({ "comment", "line_comment", "block_comment" }, node:type())
			then
				return { "buffer" }
			else
				return { "lsp", "path", "buffer", "snippets" }
			end
		end,
		cmdline = {},
		providers = {
			snippets = {
				min_keyword_length = 3,
			},
		},
	},

	appearance = {
		use_nvim_cmp_as_default = true, -- required for custom color-types
		nerd_font_variant = "normal", -- "normal" for nerd fonts

		kind_icons = {
			Namespace = "󰘦", -- 󰌗
			Text = "󰉿",
			Method = "", -- 󰆧
			Function = "󰡱", -- 󰆧
			Constructor = "", --  󱌣
			Field = "", -- 󰜢  
			Variable = "󰏫", -- 󰀫
			Class = "󰆦", -- 󰠱
			Interface = "󰆩", -- 
			Module = "󰜋",
			Property = "󰀫", -- 󰜢 󱍔 󱌢 󰴕 󰋜 󰷔 󱇯 
			Unit = "󰘨", -- 󰑭
			Value = "󰆙", -- 󰎠
			Enum = "󰪚", --  ❐ 󰘷
			Keyword = "󱕵", -- 󰌋
			Snippet = "󰴹", --  󰅴 
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
			Tag = "󰜢", -- 
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
	},
})
