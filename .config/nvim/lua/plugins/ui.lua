return {
  -- Neovim plugin to improve the default vim.ui interfaces
  {
    "stevearc/dressing.nvim",
    event = "VeryLazy",
    dependencies = { "MunifTanjim/nui.nvim" },
    opts = {},
    config = function()
      require("dressing").setup()
    end,
  },

  -- Neovim notifications and LSP progress messages
  -- {
  --   "j-hui/fidget.nvim",
  --   branch = "legacy",
  --   enabled = false,
  --   config = function()
  --     require("fidget").setup({
  --       window = { blend = 0 },
  --     })
  --   end,
  -- },

  -- Extensible Neovim Scrollbar
  {
    "petertriho/nvim-scrollbar",
    event = "VeryLazy",
    dependencies = {
      {
        "kevinhwang91/nvim-hlslens",
        config = function()
          require("hlslens").setup()
        end,
      },
    },
    config = function()
      require("scrollbar").setup()
    end,
  },
  -- VSCode-like lightbulb for neovim's built-in LSP
  -- {
  --   'kosayoda/nvim-lightbulb',
  --   event = 'LspAttach',
  --   opts = {
  --     autocmd = { enabled = true },
  --     sign = { enabled = false },
  --     float = { text = icons.ui.Lightbulb, enabled = true, win_opts = { border = 'none' } },
  --   },
  -- },
  {
    'Wansmer/symbol-usage.nvim',
    event = 'LspAttach',
    -- init = function()
    -- highlight.plugin('SymbolUsage', {
    --   { SymbolUsageRounding = { fg = { from = 'CursorLine', attr = 'bg' }, italic = true } },
    --   { SymbolUsageContent = { bg = { from = 'CursorLine' }, fg = { from = 'Comment' } } },
    --   { SymbolUsageRef = { fg = { from = 'Function' }, bg = { from = 'CursorLine' }, italic = true } },
    --   { SymbolUsageDef = { fg = { from = 'Type' }, bg = { from = 'CursorLine' }, italic = true } },
    --   { SymbolUsageImpl = { fg = { from = 'Keyword' }, bg = { from = 'CursorLine' }, italic = true } },
    -- })
    -- end,
    config = function()
      local function text_format(symbol)
        local fragments = {}

        -- Indicator that shows if there are any other symbols in the same line
        local stacked_functions = symbol.stacked_count > 0
        and (' | +%s'):format(symbol.stacked_count)
        or ''

        if symbol.references then
          local usage = symbol.references <= 1 and 'usage' or 'usages'
          local num = symbol.references == 0 and 'no' or symbol.references
          table.insert(fragments, ('%s %s'):format(num, usage))
        end

        if symbol.definition then
          table.insert(fragments, symbol.definition .. ' defs')
        end

        if symbol.implementation then
          table.insert(fragments, symbol.implementation .. ' impls')
        end

        return table.concat(fragments, ', ') .. stacked_functions
      end

      require('symbol-usage').setup({
        text_format = text_format,
      })
    end
  },
}
