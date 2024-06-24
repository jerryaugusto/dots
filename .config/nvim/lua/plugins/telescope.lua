return {
	"nvim-telescope/telescope.nvim",
	cmd = "Telescope",
	lazy = false,
	version = false,
	branch = "0.1.x",
	dependencies = {
		"nvim-telescope/telescope-ui-select.nvim",
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		"nvim-tree/nvim-web-devicons",
		"telescope-dap.nvim",
	},
	keys = {
		{ "<leader>ff", ":Telescope find_files<CR>", silent = true, desc = "Fuzzy find files" },
	},
	config = function()
		local telescope = require("telescope")
		local trouble = require("trouble.sources.telescope")
		local actions = require("telescope.actions")
		local icons = require("config.icons")

		vim.api.nvim_create_autocmd("FileType", {
			pattern = "TelescopeResults",
			callback = function(ctx)
				vim.api.nvim_buf_call(ctx.buf, function()
					vim.fn.matchadd("TelescopeParent", "\t\t.*$")
					vim.api.nvim_set_hl(0, "TelescopeParent", { link = "Comment" })
				end)
			end,
		})

		-- local function formattedName(_, path)
		--   local tail = vim.fs.basename(path)
		--   local parent = vim.fs.dirname(path)
		--
		--   if parent == "." then
		--     return tail
		--   end
		--
		--   return string.format("%s\t\t%s", tail, parent)
		-- end

		telescope.setup({
			file_ignore_patterns = { "%.git/." },
			defaults = {
				path_display = { "smart" },
				preview = true,
				prompt_prefix = "" .. icons.ui.Telescope .. " ",
				selection_caret = "" .. icons.ui.BoldArrowRight .. " ",
				file_ignore_patterns = { "node_modules", "package-lock.json" },
				initial_mode = "insert",
				select_strategy = "reset",
				sorting_strategy = "ascending",
				color_devicons = true,
				set_env = { ["COLORTERM"] = "truecolor" },
				layout_config = {
					horizontal = {
						prompt_position = "top",
						preview_width = 0.55,
					},
				},
				mappings = {
					i = {
						["<C-k>"] = actions.move_selection_previous,
						["<C-j>"] = actions.move_selection_next,
						["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
						["<C-t>"] = trouble.open,
					},
					n = {
						q = actions.close,
						["<C-t>"] = trouble.open,
					},
				},
			},
			extensions = {
				fzf = {
					fuzzy = true, -- false will only do exact matching
					override_generic_sorter = true, -- override the generic sorter
					override_file_sorter = true, -- override the file sorter
					case_mode = "smart_case", -- or "ignore_case" or "respect_case"
				},
				["ui-select"] = {
					require("telescope.themes").get_dropdown({
						previewer = false,
						initial_mode = "normal",
						sorting_strategy = "ascending",
						layout_strategy = "horizontal",
						layout_config = {
							horizontal = {
								width = 0.5,
								height = 0.4,
								preview_width = 0.6,
							},
						},
					}),
				},
			},
		})

		telescope.load_extension("fzf")
		telescope.load_extension("ui-select")
		telescope.load_extension("refactoring")
		telescope.load_extension("dap")

		-- keymaps
		-- local builtin = require("telescope.builtin")
		-- local keymap = vim.keymap.set

		-- keymap("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Fuzzy find files in cwd" })
		-- keymap("n", "<leader>fg", "<cmd>Telescope git_files<cr>", { desc = "Fuzzy find git files" })
		-- keymap("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Fuzzy find recent files" })
		-- keymap("n", "<leader>fs", "<cmd>Telescope live_grep<cr>", { desc = "Fuzzy find live grep" })
		-- keymap("n", "<leader>fw", "<cmd>Telescope grep_string<cr>", { desc = "Fuzzy find words" })
		-- keymap("n", "<leader>fW", function()
		--   builtin.grep_string({ search = vim.fn.input("  Grep 󰅂 ") })
		-- end, { desc = "Fuzzy find grep" })
		--
		-- keymap("n", "<leader>ft", "<cmd>TodoTelescope<cr>", { desc = "Find todos" })
	end,
}
