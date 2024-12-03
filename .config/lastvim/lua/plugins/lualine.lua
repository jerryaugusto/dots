return {
	"nvim-lualine/lualine.nvim",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
		-- "meuter/lualine-so-fancy.nvim",
	},
	config = function()
		-- Eviline config for lualine
		-- Author: shadmansaleh
		-- Credit: glepnir
		local lualine = require("lualine")
		local lazy_status = require("lazy.status") -- lazy pending updates
		local icons = require("config.icons")
    local tinygit = require("tinygit.statusline")


    -- Color table for highlights
    -- stylua: ignore
    local colors = {
      bg          = '#191922',
      fg          = '#C8C093',
      yellow      = '#FF9E3B',
      cyan        = '#A3D4D5',
      darkblue    = '#223249',
      green       = '#98BB6C',
      orange      = '#FFA066',
      violet      = '#957FB8',
      magenta     = '#D27E99',
      blue        = '#7E9CD8',
      red         = '#FF5D62',
      fg_alt      = "#DCD7BA",
      dark_bg     = "#16161D",
      light_bg    = "#2A2A37",
      popup_bg    = "#223249",
      search      = "#2D4F67",
      info        = "#6A9589",
      hint        = "#658594",
      comments    = "#727169",
      builtins    = "#7FB4CA",
      types       = "#7AA89F",
      identifiers = "#E6C384",
      light_fg    = "#938AA9",
      deprecated  = "#717C7C",
    }

		local conditions = {
			buffer_not_empty = function()
				return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
			end,
			hide_in_width = function()
				return vim.fn.winwidth(0) > 80
			end,
			check_git_workspace = function()
				local filepath = vim.fn.expand("%:p:h")
				local gitdir = vim.fn.finddir(".git", filepath .. ";")
				return gitdir and #gitdir > 0 and #gitdir < #filepath
			end,
		}

		-- Config
		local config = {
			options = {
				-- Disable sections and component separators
				component_separators = "",
				section_separators = "",
				theme = {
					-- We are going to use lualine_c an lualine_x as left and
					-- right section. Both are highlighted by c theme .  So we
					-- are just setting default looks o statusline
					normal = { c = { fg = colors.fg, bg = colors.bg } },
					inactive = { c = { fg = colors.fg, bg = colors.bg } },
				},
			},
			sections = {
				-- these are to remove the defaults
				lualine_a = {},
				lualine_b = {},
				lualine_y = {},
				lualine_z = {},
				-- These will be filled later
				lualine_c = {},
				lualine_x = {},
			},
			inactive_sections = {
				-- these are to remove the defaults
				lualine_a = {},
				lualine_b = {},
				lualine_y = {},
				lualine_z = {},
				lualine_c = {},
				lualine_x = {},
			},
		}

		-- Inserts a component in lualine_c at left section
		local function ins_left(component)
			table.insert(config.sections.lualine_c, component)
		end

		-- Inserts a component in lualine_x at right section
		local function ins_right(component)
			table.insert(config.sections.lualine_x, component)
		end

		ins_left({
			function()
				return "" -- █ ▒ ▊  
			end,
			color = { fg = colors.blue }, -- Sets highlighting of component
			padding = { left = 0, right = 1 }, -- We don't need space before this
		})

		ins_left({
			-- mode component
			function()
				return " " .. icons.dev.Neovim
			end,
			color = function()
				-- auto change color according to neovims mode
				local mode_color = {
					n = colors.violet,
					i = colors.identifiers,
					v = colors.types,
					[""] = colors.blue,
					V = colors.hint,
					c = colors.fg_alt,
					no = colors.red,
					s = colors.orange,
					S = colors.orange,
					[""] = colors.orange,
					ic = colors.yellow,
					R = colors.red,
					Rv = colors.violet,
					cv = colors.red,
					ce = colors.red,
					r = colors.cyan,
					rm = colors.cyan,
					["r?"] = colors.cyan,
					["!"] = colors.red,
					t = colors.red,
				}
				return { fg = mode_color[vim.fn.mode()] }
			end,
			padding = { right = 1 },
		})

		-- ins_left({
		-- 	-- filesize component
		-- 	"filesize",
		-- 	cond = conditions.buffer_not_empty,
		-- })

		ins_left({
			"filename",
			icons_enabled = true,
			cond = conditions.buffer_not_empty,
			color = { fg = colors.magenta, gui = "bold" },
			icon_only = true,
		})

		ins_left({ "location" })

		ins_left({ "progress", color = { fg = colors.blue } })

		ins_left({
			"diagnostics",
			sources = { "nvim_diagnostic" },
			symbols = {
				error = "󰅙 ", --  
				warn = "󰀨 ", --    
				info = "󰋼 ", --  
			},
			diagnostics_color = {
				color_error = { fg = colors.red },
				color_warn = { fg = colors.yellow },
				color_info = { fg = colors.cyan },
			},
		})

		-- Insert mid section. You can make any number of sections in neovim :)
		-- for lualine it's any number greater then 2
		ins_left({
			function()
				return "%="
			end,
		})

		ins_left({
			-- Lsp server name .
			function()
				local msg = "No Active Lsp"
				local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
				local clients = vim.lsp.get_clients()
				if next(clients) == nil then
					return msg
				end
				for _, client in ipairs(clients) do
					local filetypes = client.config.filetypes
					if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
						return client.name
					end
				end
				return msg
			end,
			icon = "󰣖", -- 󰒓 󰒔   
			color = { fg = colors.fg },
		})

		ins_right({
			lazy_status.updates,
			cond = lazy_status.has_updates,
			-- icon = '',
			color = { fg = colors.blue, gui = "bold" },
		})

		ins_right({
			"branch",
			icon = "", --    󰘬
			color = { fg = colors.orange, gui = "bold" },
		})

		ins_right({
			"diff",
			-- Is it me or the symbol for modified us really weird
			symbols = {
				added = "󰐗 ", -- 󰐗 
				modified = "󰻂 ", -- 󰻂   
				removed = "󰍶 ", -- 󰍶 
			},
			diff_color = {
				added = { fg = colors.green },
				modified = { fg = colors.types },
				removed = { fg = colors.red },
			},
			cond = conditions.hide_in_width,
		})

    ins_right({
      tinygit.branchState,
      color = { fg = colors.types, gui = "bold" }
    })

    ins_right({
      tinygit.blame,
      color = { fg = colors.info }
    })

		-- Add components to right sections
		-- ins_right({
		-- 	"o:encoding", -- option component same as &encoding in viml
		-- 	-- fmt = string.upper, -- I'm not sure why it's upper case either ;)
		-- 	cond = conditions.hide_in_width,
		-- 	color = { fg = colors.green, gui = "bold" },
		-- })
		--
		-- ins_right({
		-- 	"fileformat",
		-- 	-- fmt = string.upper,
		-- 	icons_enabled = false, -- I think icons are cool but Eviline doesn't have them. sigh
		-- 	color = { fg = colors.green, gui = "bold" },
		-- })

		ins_right({
			function()
				return " " -- ▊  
			end,
			color = { fg = colors.blue },
			padding = { left = -2 },
		})

		-- Now don't forget to initialize lualine
		lualine.setup(config)
	end,
}
