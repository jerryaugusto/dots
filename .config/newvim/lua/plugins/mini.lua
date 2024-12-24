return {
	--- Mini stuffs
	"echasnovski/mini.nvim",
	name = "mini",
	version = false,
	keys = function()
		local function map(mode, keys, action, desc)
			desc = desc or ""
			local opts = { noremap = true, silent = true, desc = desc }
			vim.keymap.set(mode, keys, action, opts)
		end

		map({ "n" }, "<leader>e", function()
			local _ = require("mini.files").close() or require("mini.files").open()
		end, "Toggle minifiles")
	end,
	init = function()
		package.preload["nvim-web-devicons"] = function()
			package.loaded["nvim-web-devicons"] = {}
			require("mini.icons").mock_nvim_web_devicons()
			return package.loaded["nvim-web-devicons"]
		end
	end,
	event = function()
		if vim.fn.argc() == 0 then
			return "VimEnter"
		else
			return { "InsertEnter", "LspAttach" }
		end
	end,

	config = function()
		-- Modules to load
		local mini_modules = {
			-- "ai",
			"basics",
			"diff",
			-- "extra",
			"files",
			"hipatterns",
			"icons",
			"indentscope",
			-- "jump2d",
			-- "starter",
			"statusline",
			-- "surround",
			"trailspace",
			"tabline",
		}

		-- Modules configs
		-- local hipatterns = require("mini.hipatterns")
		local mini_config = {
			basics = {
				options = {
					extra_ui = true,
					win_borders = "single", -- single | double | default
				},
			},
			-- Minidiff stuffs
			-- diff = {
			--   view = {
			--     style = "sign",
			--     signs = { add = "│", change = "⸾", delete = "" }, --    ┋ 󰍵 󰇝 󰠵 󰇝 ▒ ␩ ┊ ⁞ ⦚ ⸾ 𜲐
			--   },
			-- },

			-- Minifiles stuffs
			files = {
				use_as_default_explorer = true,
				windows = {
					preview = true,
					width_preview = 50,
				},
			},

			-- Hipatterns stuffs
			hipatterns = {
				highlighters = {
					fixme = { pattern = "%f[%w]()FIXME()%f[%W]", group = "MiniHipatternsFixme" },
					hack = { pattern = "%f[%w]()HACK()%f[%W]", group = "MiniHipatternsHack" },
					todo = { pattern = "%f[%w]()TODO()%f[%W]", group = "MiniHipatternsTodo" },
					note = { pattern = "%f[%w]()NOTE()%f[%W]", group = "MiniHipatternsNote" },
					-- Highlight hex color strings (`#rrggbb`) using that color
					hex_color = require "mini.hipatterns".gen_highlighter.hex_color(),
				},
			},

			-- Indentscope stuffs
			indentscope = {
				symbol = "│", -- │ ▏
			},

			jump2d = {
				mappings = {
					start_jumping = "s",
				},
			},

			tabline = {
				-- tabpage_section = "right"
				tabpage_section = "none",
			},

			-- Starter stuffs
			-- starter = {
			--   evaluate_single = false,
			--   header = table.concat({
			--     " 𝙔𝘼𝙔!ーーーーー",
			--     " ☆  *    .      ☆",
			--     "     . ∧＿∧    ∩    * ☆",
			--     "*  ☆ ( ・∀・)/ .",
			--     "  .  ⊂         ノ* ☆",
			--     "  ☆ * (つ ノ  .☆",
			--     "       (ノ",
			--   }, "\n"),
			--   footer = os.date(),
			--   items = {
			--     {
			--       name = "Bookmarked files 󰃀",
			--       action = "lua MiniExtra.pickers.visit_paths { filter = 'todo' }",
			--       section = "Actions ",
			--     },
			--     { name = "Lazy update ", action = ":Lazy update", section = "Actions " }, -- 󰒲
			--     { name = "Open blank file 󰺪", action = ":enew", section = "Actions " },
			--     { name = "Find files 󰺮", action = "lua MiniPick.builtin.files()", section = "Actions " },
			--     { name = "Recent files 󰪷", action = "lua MiniExtra.pickers.oldfiles()", section = "Actions " },
			--     { name = "Quit ", action = ":q!", section = "Actions " }, -- 󰍃 󰗽
			--   },
			--   -- content_hooks = {
			--   --   starter.gen_hook.aligning("center", "center"),
			--   -- },
			-- },

			statusline = {
				set_vim_settings = false,
				content = {
					active = function()
						local MiniStatusline = require("mini.statusline")
						local mode, mode_hl = MiniStatusline.section_mode({ trunc_width = 120 })
						local git = MiniStatusline.section_git({ trunc_width = 40 })
						local filename = MiniStatusline.section_filename({ trunc_width = 140 })
						local diagnostics = MiniStatusline.section_diagnostics({ trunc_width = 75 })
						local lint_progress = function()
							local linters = require("lint").get_running()
							if #linters == 0 then
								return "󰦕"
							end
							return "󱉶 " .. table.concat(linters, ", ")
						end
						return MiniStatusline.combine_groups({
							{ hl = mode_hl, strings = { mode:upper() } },
							{ hl = "MiniStatuslineDevinfo", strings = { git, diagnostics, lint_progress() } },
							"%<", -- Mark general truncate point
							{ hl = "MiniStatuslineFilename", strings = { filename } },
							"%=", -- End left alignment
							{
								hl = "MiniStatuslineFileinfo",
								strings = {
									vim.bo.filetype ~= ""
										and require("mini.icons").get("filetype", vim.bo.filetype)
											.. " "
											.. vim.bo.filetype,
								},
							},
							{ hl = mode_hl, strings = { "%l:%v" } },
						})
					end,
				},
			},

			-- Icons stuffs
			icons = {
				default = {
					default = { glyph = "󰈚" },
					extension = { glyph = "󰈚" },
					file = { glyph = "󰈚" },
					filetype = { glyph = "󰈚" },
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
			},
		}
		for _, module in ipairs(mini_modules) do
			require("mini." .. module).setup(mini_config[module])
		end
	end,
}
