-- Builtin diagnostics prefix
vim.diagnostic.config({
  virtual_text = false,
})

local opt = vim.opt
local g = vim.g

-- Font family
if not vim.g.neovide then opt.guifont = "JetBrains Mono:h10" end

-- Set leader key
g.mapleader = " "
g.maplocalleader = " "
-- Disable netrw
g.loaded_netrw = 1
g.loaded_netrwPlugin = 1
-- vim.cmd("let g:netrw_liststyle = 3")

-- opt.spell = true
opt.spelllang = "en_us"
opt.incsearch = true          -- make search act like search in modern browsers
opt.backup = false            -- creates a backup file
opt.clipboard = "unnamedplus" -- allows neovim to access the system clipboard
opt.cmdheight = 1             -- more space in the neovim command line for displaying messages
opt.fileencoding = "utf-8"    -- the encoding written to a file
opt.hlsearch = true           -- highlight all matches on previous search pattern
opt.pumheight = 10            -- pop up menu height
opt.showmode = false          -- we don't need to see things like -- INSERT -- anymore
opt.showtabline = 0           -- always show tabs
opt.smartcase = true          -- if include mixed case, assumes you want case-sensitive
opt.smartindent = true        -- make indenting smarter again
opt.splitright = true         -- split vertical window to the right
opt.splitbelow = true         -- split horizontal window to the bottom
opt.tabstop = 2               -- insert 2 spaces for a tab
opt.shiftwidth = 2            -- the number of spaces inserted for each indentation
opt.expandtab = true          -- convert tabs to spaces
-- opt.autoindent = true
opt.ignorecase = true         -- ignore case when searching
opt.swapfile = false          -- creates a swapfile
opt.termguicolors = true      -- set term gui colors (most terminals support this)
-- opt.background = 'dark'
opt.signcolumn = 'yes'        -- always show the sign column, otherwise it would shift the text each time
opt.timeoutlen = 1000         -- time to wait for a mapped sequence to complete (in milliseconds)
opt.undofile = true           -- enable persistent undo
opt.updatetime = 100          -- faster completion (4000ms default)
opt.writebackup = false       -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
opt.number = true             -- set numbered lines
opt.relativenumber = true     -- and relative numbered lines to
opt.breakindent = true        -- wrap lines with indent
opt.wrap = false              -- display lines as one long line
opt.scrolloff = 18            -- makes sure there are always eight lines of context
opt.showcmd = false           -- Don't show the command in the last line
opt.ruler = false             -- Don't show the ruler
opt.title = true              -- set the title of window to the value of the titlestring
opt.confirm = true            -- save changes before exiting modified buffers
opt.laststatus = 0            -- always display the status line
opt.cursorline = true         -- highlight the current line
opt.cursorlineopt = "number"  -- set the cursorline as "line", "number" or "both"

-- mostly just for cmp
opt.completeopt = { "menu", "menuone", "noselect" }

-- allow backspace on indent
opt.backspace = "indent,eol,start"

-- Chars list
local space = "·"
opt.list = true
opt.fillchars = { eob = " " } -- 󰜥
opt.showbreak = "↪"
opt.listchars:append {
  eol = "¬",
  tab = " 󰍟 ", -- │─
  space = space,
  multispace = space,
  lead = " ",
  -- leadmultispace = space,
  trail = "󰄮",
  extends = "󰶻",
  precedes = "󰶺",
  conceal = "󰩽",
  nbsp = "󰟾",
}

local cmd = vim.cmd
local api = vim.api

-- Highlight trailing spaces
cmd [[match TrailingWhitespace /\s\+$/]]

api.nvim_set_hl(0, "TrailingWhitespace", { link = "Error" })

api.nvim_create_autocmd("InsertEnter", {
  callback = function()
    opt.listchars.trail = nil
    vim.api.nvim_set_hl(0, "TrailingWhitespace", { link = "Whitespace" })
  end,
})

api.nvim_create_autocmd("InsertLeave", {
  callback = function()
    opt.listchars.trail = space
    vim.api.nvim_set_hl(0, "TrailingWhitespace", { link = "Error" })
  end,
})

-- vim.diagnostic.config({
--   virtual_text = false,
--   signs = true,
--   underline = true,
--   update_in_insert = false,
--
--   float = {
--     border = "single",
--   },
-- })
