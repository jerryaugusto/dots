return {
  -- Neovim plugin to improve the default vim.ui interfaces
  {
    "stevearc/dressing.nvim",
    enabled = false,
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
      local function h(name) return vim.api.nvim_get_hl(0, { name = name }) end

      -- hl-groups can have any name
      vim.api.nvim_set_hl(0, 'SymbolUsageRounding', { fg = h('CursorLine').bg, italic = true })
      vim.api.nvim_set_hl(0, 'SymbolUsageContent', { bg = h('CursorLine').bg, fg = h('Type').fg, italic = true })
      vim.api.nvim_set_hl(0, 'SymbolUsageRef', { fg = h('Function').fg, bg = h('CursorLine').bg, italic = true })
      vim.api.nvim_set_hl(0, 'SymbolUsageDef', { fg = h('Type').fg, bg = h('CursorLine').bg, italic = true })
      vim.api.nvim_set_hl(0, 'SymbolUsageImpl', { fg = h('@keyword').fg, bg = h('CursorLine').bg, italic = true })

      local function text_format(symbol)
        local res = {}

        local round_start = { '', 'SymbolUsageRounding' }
        local round_end = { '', 'SymbolUsageRounding' }

        -- Indicator that shows if there are any other symbols in the same line
        local stacked_functions_content = symbol.stacked_count > 0
        and ("+%s"):format(symbol.stacked_count)
        or ''

        if symbol.references then
          local usage = symbol.references <= 1 and 'usage' or 'usages'
          local num = symbol.references == 0 and 'no' or symbol.references
          table.insert(res, round_start)
          table.insert(res, { '󰌹 ', 'SymbolUsageRef' })
          table.insert(res, { ('%s %s'):format(num, usage), 'SymbolUsageContent' })
          table.insert(res, round_end)
        end

        if symbol.definition then
          if #res > 0 then
            table.insert(res, { ' ', 'NonText' })
          end
          table.insert(res, round_start)
          table.insert(res, { '󰳽 ', 'SymbolUsageDef' })
          table.insert(res, { symbol.definition .. ' defs', 'SymbolUsageContent' })
          table.insert(res, round_end)
        end

        if symbol.implementation then
          if #res > 0 then
            table.insert(res, { ' ', 'NonText' })
          end
          table.insert(res, round_start)
          table.insert(res, { '󰡱 ', 'SymbolUsageImpl' })
          table.insert(res, { symbol.implementation .. ' impls', 'SymbolUsageContent' })
          table.insert(res, round_end)
        end

        if stacked_functions_content ~= '' then
          if #res > 0 then
            table.insert(res, { ' ', 'NonText' })
          end
          table.insert(res, round_start)
          table.insert(res, { ' ', 'SymbolUsageImpl' })
          table.insert(res, { stacked_functions_content, 'SymbolUsageContent' })
          table.insert(res, round_end)
        end

        return res
      end

      require('symbol-usage').setup({
        text_format = text_format,
        vt_position = 'end_of_line'
      })
    end
  },
}
