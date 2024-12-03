vim.g.mapleader = " "

local function map(mode, keys, action, desc)
	desc = desc or ""
	local opts = { noremap = true, silent = true, desc = desc }
	vim.keymap.set(mode, keys, action, opts)
end

map("n", ";", ":", "cmd enter command mode")
map("i", "jj", "<Esc>", "Exit insert mode with jj")
map("i", "jk", "<Esc>", "Exit insert mode with jk")
map("i", "kj", "<Esc>", "Exit insert mode with kj")
map("i", "kk", "<Esc>", "Exit insert mode with kk")

map("n", "<leader>bq", "<C-w>o", "Close all windows except the focusd one")

map("n", "<Esc>", "<cmd>nohl<cr>", "Clear search highlight")

map("n", "<C-s>", "<cmd>update<CR>", "Update file")
map("n", "<Tab>", "<cmd>bnext<CR>", "Next buffer")
map("n", "<s-Tab>", "<cmd>bprev<CR>", "Previous buffer")

-- increment/decrement numbers
map("n", "<leader>=", "<C-a>", "Increment number")
map("n", "<leader>-", "<C-x>", "Decrement number")

-- Select all
map("n", "<C-a>", "ggVG")
map({ "i", "v" }, "<C-a>", "<Esc>ggVG")

-- VSCode-like 'alt+k/j' Move selected line / block of text in visual mode
map("v", "<A-j>", ":m '>+1<CR>gv=gv")
map("v", "<A-k>", ":m '<-2<CR>gv=gv")

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

map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")
map("v", "??", 'y:h <C-R>"<cr>"') -- Show vim help
map("v", "?/", 'y:/ <C-R>"<cr>"') -- Search across the buffer
