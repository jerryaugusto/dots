-- local icons = {
-- 	Namespace = "󰘦", -- 󰌗
-- 	Text = "󰉿",
-- 	Method = "", -- 󰆧
-- 	Function = "󰡱", -- 󰆧
-- 	Constructor = "", --  󱌣
-- 	Field = "󰜢",
-- 	Variable = "󰀫",
-- 	Class = "󰆦", -- 󰠱
-- 	Interface = "󰆩", -- 
-- 	Module = "󰜋",
-- 	Property = "󰜢",
-- 	Unit = "󰘨", -- 󰑭
-- 	Value = "󰆙", -- 󰎠
-- 	Enum = "󰪚", --  ❐ 󰘷
-- 	Keyword = "󱕵", -- 󰌋
-- 	Snippet = "", --  󰅴
-- 	Color = "󰏘",
-- 	File = "󰈚",
-- 	Reference = "", -- 󰈇 󰗽
-- 	Folder = "󰉋",
-- 	EnumMember = "", -- 
-- 	Constant = "󰕶", -- 󰏿
-- 	Struct = "󰜬", -- 󰙅
-- 	Event = "󰙴", -- 
-- 	Operator = "", -- 󰆕
-- 	TypeParameter = "󰊄",
-- 	Table = "󰓫", -- 
-- 	Object = "󰅩",
-- 	Tag = "",
-- 	Array = "󰅪", -- [
-- 	Boolean = "",
-- 	Number = "", -- 
-- 	Null = "󰒉", -- 󰟢
-- 	Supermaven = "",
-- 	String = "", -- 󰉿
-- 	Calendar = "",
-- 	Watch = "󰥔",
-- 	Package = "󰏗",
-- 	Copilot = "",
-- 	Codeium = "",
-- 	TabNine = "",
-- 	BladeNav = "",
-- }
local cmp = require("cmp")
local luasnip = require("luasnip")
local icons = require("ui")
-- local lspkind = require("lspkind")

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

require("luasnip.loaders.from_vscode").lazy_load()
luasnip.config.setup({})

cmp.setup({
	window = {
		completion = {
			-- border = "rounded", -- single|rounded|none
			border = border("󱐋", "WarningMsg", "Comment"),
			-- winhighlight = "Normal:CmpPmenu,CursorLine:Search,Search:PmenuSel,FloatBorder:Comment", -- NvChad personal
			winhighlight = "Normal:Normal,FloatBorder:FloatBorder", -- NvChad personal
			-- winhighlight = "Normal:CmpPmenu,CursorLine:Search,Search:None",
			side_padding = 1, -- padding at sides
			col_offset = -3, -- move floating box left or right
			scrollbar = false,
		},
		documentation = {
			border = border("󰙎", "DiagnosticHint", "Comment"),
			-- border = "rounded", -- single|rounded|none
			-- winhighlight = "Normal:CmpDoc",
			winhighlight = "Normal:Normal,FloatBorder:FloatBorder", -- NvChad personal
		},
	},
	completion = {
		completeopt = "menu,menuone,preview,noselect",
		-- completeopt = "menu,menuone"
	},
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	mapping = cmp.mapping.preset.insert({

		["<CR>"] = cmp.mapping.confirm({
			behavior = cmp.ConfirmBehavior.Insert,
			select = true,
		}),

		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif require("luasnip").expand_or_jumpable() then
				require("luasnip").expand_or_jump()
			else
				fallback()
			end
		end, { "i", "s" }),

		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif require("luasnip").jumpable(-1) then
				require("luasnip").jump(-1)
			else
				fallback()
			end
		end, { "i", "s" }),

		["<C-j>"] = cmp.mapping.scroll_docs(4),
		["<C-k>"] = cmp.mapping.scroll_docs(-4),
		["<C-space>"] = cmp.mapping.complete(),
		["<C-e>"] = cmp.mapping.abort(),
		-- ["<CR>"] = cmp.mapping.confirm({ select = false }),
	}),
	sources = cmp.config.sources({
		{ name = "nvim_lsp_signature_help", group_index = 1 },
		{ name = "nvim_lsp", priority = 1000, max_item_count = 10 },
		{ name = "luasnip", priority = 15 },
		{ name = "nvim_lua", group_index = 1 },
		{ name = "path" },
		{
			name = "buffer",
			keyword_length = 3,
			max_item_count = 5,
			group_index = 2,
			option = {
				get_bufnrs = function()
					return vim.api.nvim_list_bufs()
				end,
				keyword_pattern = [[\k\+]],
			},
		},
		{ name = "calc" },
		{ name = "treesitter" },
		{ name = "emoji" },
		{ name = "cmdline" },
	}),
	experimental = {
		ghost_text = true,
	},
	formatting = {
		format = function(entry, item)
			-- Prepend with a fancy icon from config.
			-- local icons = LazyVim.config.icons
			if entry.source.name == "git" then
				item.kind = icons.glyph.git.Octoface
			else
				local icon = icons.glyph.kind[item.kind]
				if icon ~= nil then
					item.kind = icon .. " ".. item.kind
				end
			end
			local widths = {
				abbr = vim.g.cmp_widths and vim.g.cmp_widths.abbr or 40,
				menu = vim.g.cmp_widths and vim.g.cmp_widths.menu or 30,
			}

			for key, width in pairs(widths) do
				if item[key] and vim.fn.strdisplaywidth(item[key]) > width then
					item[key] = vim.fn.strcharpart(item[key], 0, width - 1) .. "…"
				end
			end
			return item
		end,
	},
	-- formatting = {
	-- 	format = function(entry, item)
	-- 		item.kind = icons[item.kind]
	-- 		item.menu = ({
	-- 			nvim_lsp = "[LSP]",
	-- 			path = "[Path]",
	-- 			luasnip = "[Snip]",
	-- 			buffer = "[Bfr]",
	-- 			nvim_lua = "[Lua]",
	-- 		})[entry.source.name]
	-- 		return item
	-- 	end,
	-- },
})
