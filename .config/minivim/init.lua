-- Bootstrap lazy.nvim (automatically installs it if not present)
local lazy_path = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazy_path) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazy_path,
  })
end
vim.opt.rtp:prepend(lazy_path)

-- Lazy.nvim setup
require('lazy').setup({
  -- LSP Config
  {
    'neovim/nvim-lspconfig',
    dependencies = { 'williamboman/mason.nvim', 'williamboman/mason-lspconfig.nvim' },
    config = function()
      require('mason').setup()
      require('mason-lspconfig').setup({
        ensure_installed = { 'tsserver', 'eslint' },
      })

      local lspconfig = require('lspconfig')
      local on_attach = function(_, bufnr)
        local opts = { noremap = true, silent = true }
        local map = vim.api.nvim_buf_set_keymap
        map(bufnr, 'n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts) -- Go to definition
        map(bufnr, 'n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)       -- Hover docs
        map(bufnr, 'n', '<leader>rn', '<Cmd>lua vim.lsp.buf.rename()<CR>', opts) -- Rename
        map(bufnr, 'n', '<leader>ca', '<Cmd>lua vim.lsp.buf.code_action()<CR>', opts) -- Code actions
      end

      lspconfig.tsserver.setup({
        on_attach = on_attach,
        flags = { debounce_text_changes = 150 },
      })
      lspconfig.eslint.setup({
        on_attach = function(client, bufnr)
          on_attach(client, bufnr)
          vim.api.nvim_create_autocmd('BufWritePre', {
            buffer = bufnr,
            command = 'EslintFixAll',
          })
        end,
      })
    end,
  },

  -- Completion
  {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',
    },
    config = function()
      local cmp = require('cmp')
      cmp.setup({
        mapping = {
          ['<Tab>'] = cmp.mapping.select_next_item(),
          ['<S-Tab>'] = cmp.mapping.select_prev_item(),
          ['<CR>'] = cmp.mapping.confirm({ select = true }),
        },
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'buffer' },
          { name = 'path' },
          { name = 'luasnip' },
        }),
      })
    end,
  },

  -- Treesitter for syntax highlighting and indenting
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    event = 'BufReadPost',
    config = function()
      require('nvim-treesitter.configs').setup({
        ensure_installed = { 'typescript', 'javascript', 'html', 'css', 'json', 'lua' },
        highlight = { enable = true, additional_vim_regex_highlighting = false },
        indent = { enable = true },
      })
    end,
  },

  -- Context (sticky headers for functions/classes)
  {
    'nvim-treesitter/nvim-treesitter-context',
    event = 'BufReadPost',
  },

  -- Surround text objects
  {
    'tpope/vim-surround',
    event = 'BufRead',
  },

  -- Commenting
  {
    'tpope/vim-commentary',
    event = 'BufRead',
  },

  -- Prettier and ESLint integration
  {
    'jose-elias-alvarez/null-ls.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      local null_ls = require('null-ls')
      null_ls.setup({
        sources = {
          null_ls.builtins.formatting.prettier,
          null_ls.builtins.diagnostics.eslint,
          null_ls.builtins.code_actions.eslint,
        },
      })
    end,
  },

  -- Theme
  {
    "rebelot/kanagawa.nvim",
    lazy = true,
    priority = 1000,
    init = function()
      vim.cmd.colorscheme("kanagawa")
    end,
    config = function()
	    require("kanagawa").setup({
		    compile = true,
		    compile_path = vim.fn.stdpath("cache") .. "/kanagawa",
		    commentStyle = { italic = false },
		    keywordStyle = { italic = false },
		    transparent = false,
		    colors = {
			    palette = {
				    samuraiRed = "#C34043",
				    fujiGray = "#4c4c55", -- NvChad
				    fujiWhite = "#C8C093",
				    springViolet1 = "#9c86bf", -- Nvchad
				    -- sumiInk4 = "#957FB8",
			    },
			    theme = {
				    all = {
					    ui = {
						    bg_gutter = "none",
					    },
				    },
			    },
		    },

	    })
    end,
  },

  -- File icons
  { 'kyazdani42/nvim-web-devicons', lazy = true },
}, {
  defaults = { lazy = true }, -- Lazy load all plugins by default
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        "netrwPlugin", -- Disable netrw for faster startup
        "tarPlugin",
        "tohtml",
        "zipPlugin",
        "matchit",
        "matchparen",
      },
    },
  },
})

-- Global settings
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.mouse = 'a'
vim.opt.termguicolors = true
vim.opt.clipboard = 'unnamedplus'
vim.opt.smartcase = true
vim.opt.ignorecase = true
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.smartindent = true
vim.opt.updatetime = 300
vim.opt.swapfile = false
vim.opt.foldmethod = 'manual'
vim.opt.foldenable = false

-- Handle large files
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "*",
  callback = function()
    if vim.fn.line("$") > 10000 then
      vim.wo.relativenumber = false
      vim.wo.cursorline = false
      vim.opt.foldmethod = 'manual'
    end
  end,
})

-- Keymaps
vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, { desc = 'Rename' })
vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { desc = 'Code action' })
vim.keymap.set('n', '<leader>f', function() vim.lsp.buf.format({ async = true }) end, { desc = 'Format code' })
