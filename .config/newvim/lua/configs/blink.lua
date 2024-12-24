---@module 'blink.cmp'
---@type blink.cmp.Config

local blink = require("blink.cmp")
local ui = require("ui")

blink.setup({
	keymap = {
		preset = "enter", -- default | super-tab | enter
		-- ["<Tab>"] = {
		-- 	function(cmp)
		-- 		if cmp.is_in_snippet() then
		-- 			return cmp.accept()
		-- 		else
		-- 			return cmp.select_next()
		-- 		end
		-- 	end,
		-- 	"snippet_forward",
		-- 	"fallback",
		-- },
		["<C-Space>"] = { "show", "show_documentation", "hide_documentation" },
		["<Tab>"] = { "select_next", "fallback" },
		["<S-Tab>"] = { "select_prev", "fallback" },
		["<CR>"] = { "accept", "fallback" },
		-- ["<Space>"] = { "accept", "fallback" }
	},

	blocked_filetypes = { "firenvim" },

	completion = {
		trigger = { show_on_insert_on_trigger_character = false },
		accept = {
			auto_brackets = {
				enabled = true,
			},
		},
		menu = {
			min_width = vim.o.pumwidth,
			max_height = 30,
			border = ui.border.styled(ui.glyph.ui.Event, "DiagnosticWarn", "Comment"),
			winblend = vim.o.pumblend,
			winhighlight = "Normal:Comment,CursorLine:Search,Search:PmenuSel,FloatBorder:Comment", -- NvChad personal
			scrollbar = false,
			-- winhighlight = "Normal:BlinkCmpMenu,FloatBorder:BlinkCmpMenuBorder,CursorLine:BlinkCmpMenuSelection,Search:None",
			-- draw = {}
		},
		documentation = {
			auto_show = true,
			auto_show_delay_ms = 250,
			window = {
				min_width = 15,
				max_width = 120,
				max_height = 20,
				border = ui.border.styled(ui.glyph.ui.Info, "DiagnosticInfo", "Comment"),
				winblend = vim.o.pumblend,
				-- winhighlight = "Normal:CmpDoc,FloatBorder:CmpDocBorder", -- NvChad
				winhighlight = "Normal:Normal,FloatBorder:FloatBorder", -- NvChad personal
			},
		},
		-- Displays a preview of the selected item on the current line
		ghost_text = {
			enabled = true,
		},
	},

	-- Experimental signature help support
	signature = {
		enabled = true,
		window = {
			min_width = 1,
			max_width = 100,
			max_height = 10,
			winblend = vim.o.pumblend,
			border = ui.border.styled(ui.glyph.ui.Lightbulb, "DiagnosticHint", "Comment"),
			-- winhighlight = "Normal:CmpPmenu,CursorLine:Search,Search:None,FloatBorder:CmpBorder", -- NvChad personal
			winhighlight = "Normal:Normal,FloatBorder:FloatBorder", -- NvChad personal
		},
	},

	fuzzy = {
		use_frecency = true,
		use_proximity = true,
		max_items = 200,
		sorts = { "label", "kind", "score" },
		prebuiltBinaries = {
			download = true,
			forceVersion = nil,
		},
	},

	sources = {
		-- add lazydev to your completion providers
		completion = {
			enabled_providers = {
				"lsp",
				"path",
				"snippets",
				"buffer",
				"lazydev",
				-- "nerdfont",
				-- "emoji",
			},
		},
		providers = {
			-- dont show LuaLS require statements when lazydev has items
			lsp = {
				name = "LSP",
				module = "blink.cmp.sources.lsp",
				enabled = true,
				-- transform_items = false,
				should_show_items = true,
				max_items = nil,
				min_keyword_length = 0,
				fallback_for = { "lazydev" },
				score_offsetr = 0,
				override = nil,
			},
			path = {
				name = "Path",
				module = "blink.cmp.sources.path",
				score_offset = 3,
				opts = {
					trailing_slash = false,
					label_trainling_slash = true,
					get_cwd = function(context)
						return vim.fn.expand(("#%d:p:h"):format(context.bufnr))
					end,
					show_hidden_files_by_default = false,
				},
			},
			snippets = {
				name = "Snippets",
				module = "blink.cmp.sources.snippets",
				score_offset = -3,
				opts = {
					friendly_snippets = true,
					search_paths = { vim.fn.stdpath("config") .. "/snippets" },
					global_snippets = { "all" },
					extended_filetypes = {},
					ignored_filetypes = {},
				},
			},
			buffer = {
				name = "Buffer",
				module = "blink.cmp.sources.buffer",
				fallback_for = { "lsp" },
			},
			lazydev = { name = "LazyDev", module = "lazydev.integrations.blink" },
			-- nerdfont = {
			-- 	name = "nerdfont",
			-- 	module = "blink.compat.source",
			-- 	transform_items = function(ctx, items)
			-- 		-- TODO: check https://github.com/Saghen/blink.cmp/pull/253#issuecomment-2454984622
			-- 		local kind = require("blink.cmp.types").CompletionItemKind.Text
			--
			-- 		for i = 1, #items do
			-- 			items[i].kind = kind
			-- 		end
			--
			-- 		return items
			-- 	end,
			-- },
			-- emoji = {
			-- 	name = "emoji",
			-- 	module = "blink.compat.source",
			-- 	transform_items = function(ctx, items)
			-- 		-- TODO: check https://github.com/Saghen/blink.cmp/pull/253#issuecomment-2454984622
			-- 		local kind = require("blink.cmp.types").CompletionItemKind.Text
			--
			-- 		for i = 1, #items do
			-- 			items[i].kind = kind
			-- 		end
			--
			-- 		return items
			-- 	end,
			-- },
		},
	},

	appearance = {
		highlight_ns = vim.api.nvim_create_namespace("blink_cmp"),
		use_nvim_cmp_as_default = true,
		nerd_font_variant = "normal",

		kind_icons = ui.glyph.kind,
	},

	-- accept = {
	-- 	auto_brackets = { enabled = true },
	-- 	semantic_token_resolution = { enabled = true },
	-- },
	--
	-- trigger = {
	-- 	signature_help = { enabled = true },
	-- },
	--
	-- highlight = {
	-- 	ns = vim.api.nvim_create_namespace("blink_cmp"),
	-- 	use_nvim_cmp_as_default = true,
	-- },
	--
	-- nerd_font_variant = "normal",
	--
	-- windows = {
	-- 	completion = {
	-- 		autocomplete = false,
	-- 		scrollbar = false,
	-- 		-- winblend = 0,
	-- 		winblend = vim.o.pumblend,
	-- 	},
	-- 	documentation = {
	-- 		auto_show = true,
	-- 		auto_show_delay_ms = 250,
	-- 		window = {
	-- 			min_width = 15,
	-- 			max_width = 120,
	-- 			max_height = 20,
	-- 			border = ui.border.styled(ui.glyph.ui.Info, "DiagnosticInfo", "Comment"),
	-- 			winblend = vim.o.pumblend,
	-- 			-- winhighlight = "Normal:CmpDoc,FloatBorder:CmpDocBorder", -- NvChad
	-- 			winhighlight = "Normal:Normal,FloatBorder:FloatBorder", -- NvChad personal
	-- 		},
	-- 	},
	-- 	signature_help = {
	-- 		enabled = true,
	-- 		border = ui.border.styled(ui.glyph.ui.Lightbulb, "DiagnosticHint", "Comment"),
	-- 		-- winhighlight = "Normal:CmpPmenu,CursorLine:Search,Search:None,FloatBorder:CmpBorder", -- NvChad personal
	-- 		winhighlight = "Normal:Normal,FloatBorder:FloatBorder", -- NvChad personal
	-- 		-- border = SETTINGS.borders.blink_empty,
	-- 	},
	-- 	autocomplete = {
	-- 		-- min_width = 25,
	-- 		min_width = vim.o.pumwidth,
	-- 		max_height = 30,
	-- 		scrollbar = true,
	-- 		border = ui.border.styled(ui.glyph.ui.Event, "DiagnosticWarn", "Comment"),
	-- 		winblend = vim.o.pumblend,
	-- 		-- winhighlight = "Normal:Comment,CursorLine:Search,Search:PmenuSel,FloatBorder:Comment", -- NvChad personal
	-- 		winhighlight = "Normal:BlinkCmpMenu,FloatBorder:BlinkCmpMenuBorder,CursorLine:BlinkCmpMenuSelection,Search:None",
	-- 		-- winhighlight = "Normal:Normal,FloatBorder:FloatBorder", -- NvChad personal
	-- 		selection = "manual", -- alts: preselect, manual, auto_insert
	-- 		draw = { columns = { { "label", "label_description", gap = 1 }, { "kind_icon", "kind" } } },
	-- 		cycle = {
	-- 			-- When `true`, calling `select_next` at the *bottom* of the completion list will select the *first* completion item.
	-- 			from_bottom = true,
	-- 			-- When `true`, calling `select_prev` at the *top* of the completion list will select the *last* completion item.
	-- 			from_top = true,
	-- 		},
	-- 		-- draw = "label",
	-- 		-- draw = function(ctx)
	-- 		-- 	local icon = ctx.kind_icon
	-- 		-- 	local icon_hl = vim.api.nvim_get_hl_by_name("BlinkCmpKind", true) and "BlinkCmpKind" .. ctx.kind
	-- 		-- 		or "BlinkCmpKind"
	-- 		--
	-- 		-- 	local source, client = ctx.item.source_id, ctx.item.client_id
	-- 		-- 	if client and vim.lsp.get_client_by_id(client).name then
	-- 		-- 		source = vim.lsp.get_client_by_id(client).name
	-- 		-- 	end
	-- 		--
	-- 		-- 	return {
	-- 		-- 		{
	-- 		-- 			" " .. ctx.item.label .. " ",
	-- 		-- 			fill = true,
	-- 		-- 			hl_group = ctx.deprecated and "BlinkCmpLabelDeprecated" or "BlinkCmpLabel",
	-- 		-- 			max_width = 35,
	-- 		-- 		},
	-- 		-- 		{
	-- 		-- 			icon .. ctx.icon_gap .. ctx.kind .. " ",
	-- 		-- 			fill = true,
	-- 		-- 			hl_group = icon_hl,
	-- 		-- 			max_width = 25,
	-- 		-- 		},
	-- 		-- 		{
	-- 		-- 			" [" .. string.lower(source) .. "] ",
	-- 		-- 			fill = true,
	-- 		-- 			hl_group = ctx.deprecated and "BlinkCmpLabelDeprecated" or "CmpItemMenu",
	-- 		-- 			max_width = 15,
	-- 		-- 		},
	-- 		-- 	}
	-- 		-- end,
	-- 	},
	-- },
})
