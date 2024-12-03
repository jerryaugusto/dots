local opts = { noremap = true, silent = true }
local keymap = vim.keymap.set

keymap("n", "<leader>S", ":so<CR>", { desc = "Resource current file" })

-- write file in current directory
-- :w %:h/<new-file-name>
keymap("n", "<C-s>", ":w %:h/", opts)

-- exit on 'jj' and 'jk'
keymap("i", "jj", "<Esc>", opts)
keymap("i", "jk", "<Esc>", opts)

-- clear highlighted text
keymap("n", "<Esc>", ":nohlsearch<CR>", opts)
-- keymap("n", "<Esc><Esc>", ":nohl<CR>", opts)

-- Select all
keymap("n", "<C-a>", "ggVG", opts)
keymap({ "i", "v" }, "<C-a>", "<Esc>ggVG", opts)

-- VSCode-like 'alt+k/j' Move selected line / block of text in visual mode
keymap("v", "J", ":m '>+1<CR>gv=gv", opts)
keymap("v", "K", ":m '<-2<CR>gv=gv", opts)

-- better indenting
keymap("v", "<", "<gv")
keymap("v", ">", ">gv")

-- paste over currently selected text without yanking it
keymap("v", "P", '"_dP')
keymap("v", "p", '"_dp')

-- Move line on the screen rather than by line in the file
keymap("n", "j", "gj", opts)
keymap("n", "k", "gk", opts)

-- increment/decrement numbers
keymap("n", "<leader>=", "<C-a>", { desc = "Increment number" })
keymap("n", "<leader>-", "<C-x>", { desc = "Decrement number" })

-- Move to start/end of line
keymap({ "n", "x", "o" }, "H", "^", opts)
keymap({ "n", "x", "o" }, "L", "g_", opts)

-- Map enter to ciw in normal mode
keymap("n", "<CR>", "ciw", opts)
keymap("n", "<BS>", "ci", opts)

-- Panes resizing
keymap("n", "+", ":vertical resize +5<CR>")
keymap("n", "_", ":vertical resize -5<CR>")
keymap("n", "=", ":resize +5<CR>")
keymap("n", "-", ":resize -5<CR>")

-- window manager
keymap("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" })
keymap("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" })
keymap("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" })
keymap("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" })
-- and navigate
keymap("n", "<C-k>", ":wincmd k<CR>", { desc = "Navigate to upper window" })
keymap("n", "<C-j>", ":wincmd j<CR>", { desc = "Navigate to bottom window" })
keymap("n", "<C-h>", ":wincmd h<CR>", { desc = "Navigate to left window" })
keymap("n", "<C-l>", ":wincmd l<CR>", { desc = "Navigate to right window" })

-- Tabs
keymap("n", "<leader>To", "<cmd>tabnew<CR>", { desc = "Open new tab" })
keymap("n", "<leader>Tx", "<cmd>tabclose<CR>", { desc = "Close current tab" })
keymap("n", "<leader>Tn", "<cmd>tabn<CR>", { desc = "Go to next tab" })
keymap("n", "<leader>Tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" })
keymap("n", "<leader>Tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" })

-- buffers navigatoin
keymap("n", "<Tab>", "<cmd>bnext<CR>", { desc = "Go to next buffer" })
keymap("n", "<S-Tab>", "<cmd>bprevious<CR>", { desc = "Go to previous buffer" })
keymap("n", "<leader>bd", "<cmd>bdelete<CR>", { desc = "Delete current buffer" })

keymap("n", "<leader>ff", ":Telescope find_files<CR>", { desc = "Find File (CWD)" })
-- keymap("n", "<leader>fF", ":Telescope current_buffer_fuzzy_find<CR>", opts)
-- keymap("n", "<leader>fg", ":Telescope git_status<CR>", opts)

-- Terminal
-- keymap("n", "<leader>th", "<cmd>:split term://fish<CR>")

-- Disable arrow keys
keymap({ "i", "n", "v" }, "<Left>", "<NOP>")
keymap({ "i", "n", "v" }, "<Down>", "<NOP>")
keymap({ "i", "n", "v" }, "<Up>", "<NOP>")
keymap({ "i", "n", "v" }, "<Right>", "<NOP>")
