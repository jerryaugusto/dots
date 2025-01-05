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
		trigger = {
			show_on_keyword = true,
			show_on_insert_on_trigger_character = false,
		},
		keyword = { range = "prefix" },
		menu = {
			min_width = vim.o.pumwidth,
			max_height = 30,
			winblend = vim.o.pumblend,
			scrollbar = false,
			draw = {
				columns = { { "kind_icon" }, { "item_idx" }, { "label", "label_description", gap = 1 } },
				components = {
					label = {
						text = require("colorful-menu").blink_components_text,
						highlight = require("colorful-menu").blink_components_highlight,
					},
					-- kind_icon = {
					--   ellipsis = false,
					--   text = function(ctx)
					--     local kind_icon, _, _ = require "mini.icons".get("lsp", ctx.kind)
					--     return kind_icon
					--   end
					-- },
					item_idx = {
						text = function(ctx)
							return ctx.idx == 10 and "0" or ctx.idx >= 10 and " " or tostring(ctx.idx)
						end,
						highlight = "BlinkCmpItemIdx", -- optional, only if you want to change its color
						-- Use the highlights from mini.icons
						-- highlight = function(ctx)
						--   local _, hl, _ = require "mini.icons".get("lsp", ctx.kind)
						--   return hl
						-- end
					},
				},
			},
			-- winhighlight = 'Normal:BlinkCmpDoc,FloatBorder:BlinkCmpDocBorder,CursorLine:BlinkCmpDocCursorLine,Search:None',
			winhighlight = "Normal:Comment,CursorLine:Search,Search:PmenuSel,FloatBorder:Comment", -- NvChad personal
		},
		documentation = {
			auto_show = true,
			auto_show_delay_ms = 250,
			window = {
				min_width = 15,
				max_width = 120,
				max_height = 40,
				winblend = vim.o.pumblend,
			},
		},
	},

	signature = {
		enabled = true,
		window = {
			min_width = 1,
			max_width = 100,
			max_height = 10,
			winblend = vim.o.pumblend,
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
				return { "lsp", "path", "snippets", "buffer" }
			end
		end,
	},

	appearance = {
		use_nvim_cmp_as_default = true,
		nerd_font_variant = "mono",

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
