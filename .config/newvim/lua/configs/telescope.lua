local telescope = require("telescope")
local actions = require("telescope.actions")
local ui = require("ui")

telescope.setup({

	vim.api.nvim_create_autocmd("FileType", {
		pattern = "TelescopeResults",
		callback = function(ctx)
			vim.api.nvim_buf_call(ctx.buf, function()
				vim.fn.matchadd("TelescopeParent", "\t\t.*$")
				vim.api.nvim_set_hl(0, "TelescopeParent", { link = "Comment" })
			end)
		end,
	}),

	file_ignore_patterns = { "%.git/." },
	defaults = {
		prompt_prefix = ui.glyph.ui.Search .. " ",
		selection_caret = ui.glyph.ui.TriangleShortArrowRight .. " ",
		sorting_strategy = "ascending",
		path_display = { "smart" },
		file_ignore_patterns = { "node_modules", "package-lock.json" },
		layout_config = {
			horizontal = {
				prompt_position = "top",
				preview_width = 0.55,
			},
		},
		mappings = {
			i = {
				["<Up>"] = false,
				["<Down>"] = false,
				["<C-j>"] = actions.move_selection_next,
				["<C-k>"] = actions.move_selection_previous,
				["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
			},
			n = { ["q"] = actions.close },
		},
	},

	-- Extension stuffs
	extensions = {
		frecency = {
			workspaces = {
				conf = "~/dots/.config/nvim",
				project = "~/dev",
			},
			show_score = true,
			show_unindexed = false,
			matcher = "fuzzy",
			ignore_patterns = { "*/.git", "*.git/*", "*/tmp/*", "*/node_modules/*", "term://*" },
		},
		file_browser = {
			-- disables netrw and use telescope-file-browser in its place
			hijack_netrw = true,
		},
		fzf = {
			fuzzy = true, -- false will only do exact matching
			override_generic_sorter = true, -- override the generic sorter
			override_file_sorter = true, -- override the file sorter
			case_mode = "smart_case", -- or "ignore_case" or "respect_case"
			-- the default case_mode is "smart_case"
		},
	},
})

-- Telescopr extensions
telescope.load_extension("frecency")
telescope.load_extension("file_browser")
telescope.load_extension("fzf")

-- Keyma stuffs
local function map(mode, keys, action, desc)
	desc = desc or ""
	local opts = { noremap = true, silent = true, desc = desc }
	vim.keymap.set(mode, keys, action, opts)
end

local builtin = require("telescope.builtin")
map("n", "<leader>ff", builtin.find_files, "Fuzzy find files")
map("n", "<leader>fo", builtin.oldfiles, "Fuzzy recent files")
map("n", "<leader>fg", builtin.live_grep, "Fuzzy live grep")
map("n", "<leader>fw", builtin.grep_string, "Fuzzy find cursor word")
map("n", "<leader>ft", builtin.current_buffer_fuzzy_find, "Fuzzy in current file")
map("n", "<leader>fc", builtin.command_history, "Command history")
map("n", "<leader>fk", builtin.keymaps, "Fuzzy keymaps")
map("n", "<leader>fs", builtin.lsp_document_symbols, "Document symbols")
map("n", "<leader>fD", builtin.diagnostics, "Project diagnostics")
-- Frecency
map(
	"n",
	"<leader>fR",
	"<cmd>lua require('telescope').extensions.frecency.frecency({ignore_patterns = {'node_modules', '.git'}})<cr>",
	"Frecency all files"
)
map(
	"n",
	"<leader>fr",
	"<cmd>lua require('telescope').extensions.frecency.frecency({ cwd = vim.fn.getcwd(), ignore_patterns = {'node_modules', '.git'} })<cr>",
	"Frecency current directory"
)
map(
	"n",
	"<leader>fW",
	"<cmd>lua require('telescope').extensions.frecency.frecency({ workspace = '~/dev', ignore_patterns = {'node_modules', '.git'} })<cr>",
	"Frecency dev workspace"
)
map(
	"n",
	"<leader>fx",
	"<cmd>lua require('telescope').extensions.frecency.frecency({ default_text = '.tsx', ignore_patterns = {'node_modules', '.git'} })<cr>",
	"Frecency '.tsx' files"
)
map(
	"n",
	"<leader>ft",
	"<cmd>lua require('telescope').extensions.frecency.frecency({ default_text = '.ts', ignore_patterns = {'node_modules', '.git'}})<cr>",
	"Frecency '.tsx' files"
)
map(
	"n",
	"<leader>fl",
	"<cmd>lua require('telescope').extensions.frecency.frecency({ default_text = '.lua', ignore_patterns = {'node_modules', '.git'} })<cr>",
	"Frecency '.tsx' files"
)
-- Telescope buffer management
map("n", "<leader>fb", builtin.buffers, "Fuzzy buffers")
map("n", "<leader>bf", builtin.buffers, "Fuzzy buffers")
-- map("n", "<leader>bx", builtin.buffers({ sort_lastused = true }), "Close selected buffer")
-- Telescope file browser
map("n", "<leader>fe", "<cmd>Telescope file_browser<cr>", "Telescope file browser")
map("n", "<leader>fE", "<cmd>Telescope file_browser path=%:p:h select_buffer=true<cr>", "Telescope browser cwd")
