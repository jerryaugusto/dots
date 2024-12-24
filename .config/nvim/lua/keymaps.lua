-- Functional wrapper for mapping custom keybindings
local function map(mode, keys, action, desc)
  desc = desc or ""
  local opts = { noremap = true, silent = true, desc = desc }
  vim.keymap.set(mode, keys, action, opts)
end

-- Convenience
map("n", ";", ":", "cmd enter command mode")

map("i", "jj", "<Esc>", "Exit insert mode with jj")
map("i", "jk", "<Esc>", "Exit insert mode with jk")
map("i", "kj", "<Esc>", "Exit insert mode with kj")
map("i", "kk", "<Esc>", "Exit insert mode with kk")

map("n", "<Esc>", "<cmd>nohl<cr>", "Clear search highlight")

-- Auto tags
map("i", "'", "''<left>")
map("i", "\"", "\"\"<left>")
map("i", "(", "()<left>")
map("i", "[", "[]<left>")
map("i", "{", "{}<left>")

-- Simple move
map("i", "<C-h>", "<left>", "Move cursor to the left")
map("i", "<M-h>", "<left>", "Move cursor to the left")
map("i", "<C-l>", "<right>", "Move cursor to the right")
map("i", "<M-l>", "<right>", "Move cursor to the right")

-- Reload management
map("n", "<leader><leader>r", "<cmd>source %<cr>", "Reload current file")
map("n", "<leader>R", ":.lua<cr>", "Reload lua file")
map("v", "<leader>R", ":lua<cr>", "Reload selected excerpt")
map("n", "<C-s>", "<cmd>update<CR>", "Update file")

-- Replaces all instances of highlightes words
map("n", "<C-S-s>", "viw\"hy:%s/<C-r>h//g<left><left>", "Replace all instances of highlighted words")
map("v", "<C-S-s>", "\"hy:%s/<C-r>h//g<left><left>", "Replace all instances of highlighted words")

map("v", "<C-M-s>", "<cmd>sort<cr>", "Sort highlighted text in visual mode")

-- Tab / Window / Buffer
map("n", "<Tab>", "<cmd>bnext<CR>", "Next buffer")
map("n", "<s-Tab>", "<cmd>bprev<CR>", "Previous buffer")
map("n", "<leader>bd", "<cmd>bdelete<cr>", "Delete buffer")
map("n", "<leader>bD", "<cmd>%bd|e#|bd#<cr>", "Close all other buffers")
map("n", "<leader>bl", "<cmd>ls<cr>:b<Space>", "List active buffers")
map("n", "<leader>bb", "<cmd>buffer<Space>", "Go to specific buffer")
map("n", "<leader>bq", "<C-w>o", "Close all windows except the focusd one")
-- Tab bindings
map("n", "<leader>tt", "<cmd>tabnew<cr>", "Creates new tab")
map("n", "<leader>tx", "<cmd>tabclose<cr>", "Closes current  tab")
map("n", "<leader>tn", "<cmd>tabnext<cr>", "Moves to next tab")
map("n", "<leader>tp", "<cmd>tabprevious", "Moves to previous tab")

map("n", "<M-j>", "<cmd>cnext<cr>")
map("n", "<M-k>", "<cmd>cprevious<cr>")

-- Slipt bindings
map("n", "<leader>sv", "<cmd>vsplit<cr>", "Creates a vertical split")
map("n", "<leader>sh", "<cmd>split<cr>", "Create a horizontal split")
-- Navigate
map("n", "<C-h>", "<C-w>h", "Switches to left split")
map("n", "<C-l>", "<C-w>l", "Switches to right split")
map("n", "<C-j>", "<C-w>j", "Switches to bottom split")
map("n", "<C-k>", "<C-w>k", "Switches to top split")
-- Resize
map("n", "<C-S-h>", "<cmd>vertical resize +1<cr>", "Resizes vertical split +")
map("n", "<C-S-l>", "<cmd>vertical resize -1<cr>", "Resizes vertical split -")
map("n", "<C-S-k>", "<cmd>horizontal resize +1<cr>", "Resizes horizontal split +")
map("n", "<C-S-j>", "<cmd>horizontal resize -1<cr>", "Resizes horizontal split -")

-- increment/decrement numbers
map("n", "<leader>=", "<C-a>", "Increment number")
map("n", "<leader>-", "<C-x>", "Decrement number")

-- Select all
map("n", "<C-a>", "ggVG")
map({ "i", "v" }, "<C-a>", "<Esc>ggVG")

-- VSCode-like 'alt+k/j' Move selected line / block of text in visual mode
map("v", "<M-j>", ":m '>+1<CR>gv=gv")
map("v", "<M-k>", ":m '<-2<CR>gv=gv")

-- better indenting
map("v", "<", "<gv")
map("v", ">", ">gv")

-- paste over currently selected text without yanking it
map("v", "P", '"_dP')
map("v", "p", '"_dp')

-- Move line on the screen rather than by line in the file
map("n", "j", "gj")
map("n", "k", "gk")

-- Command mode up/down remap
map("c", "<C-j>", "<Up>")
map("c", "<C-k>", "<Down>")

-- Move to start/end of line
map({ "n", "x", "o" }, "H", "^")
map({ "n", "x", "o" }, "L", "g_")

-- select line within its extension limits
map("n", "<leader>V", "^vg_", "Select line-only")

-- Avoid x and s to override the clipboard
map("n", "x", '"_x')
map("n", "X", '"_X')
map("n", "s", '"_s')

-- Replace a word with yanked text
map("n", "rw", "viwpyiw")

-- Replace till the end of line with yanked text
map("n", "rl", 'Pl"_D')

-- Toggle capitalise
map("n", "<leader>w", "g~iw", "Toggle capitalise")
map("v", "<leader>w", "~", "Toggle capitalise")

-- Copy file name
-- map("n", "<leader>yf", function()
-- 	local filename = vim.api.nvim_buf_getname(0)
-- 	vim.fn.setreg("+", filename)
-- 	print("copied " .. filename)
-- end, "Copy file name to clipboard")

-- Map enter to ciw in normal mode
map("i", "<C-BS>", "<Esc>ciw", "Delete a word") -- Ctrl + backspace delete a word
map("n", "<C-BS>", "hdiw", "Delete a word")
map("n", "<CR>", "ciw")
map("n", "<BS>", "ci")

-- redo
map("n", "U", "<C-r>", "Redo with S-u")

-- Disable arrow keys
map({ "i", "n", "v" }, "<Left>", "<NOP>")
map({ "i", "n", "v" }, "<Down>", "<NOP>")
map({ "i", "n", "v" }, "<Up>", "<NOP>")
map({ "i", "n", "v" }, "<Right>", "<NOP>")

map("n", "s", "<Plug>(leap)")
map("n", "S", "<Plug>(leap-from-window)")
map({ "x", "o" }, "s", "<Plug>(leap-forward)")
map({ "x", "o" }, "S", "<Plug>(leap-backward)")

map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")
map("v", "??", 'y:h <C-R>"<cr>"') -- Show vim help
map("v", "?/", 'y:/ <C-R>"<cr>"') -- Search across the buffer
