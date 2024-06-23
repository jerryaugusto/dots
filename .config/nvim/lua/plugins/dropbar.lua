local symbols = {
  Array = '󰅪 ',
  Boolean = ' ',
  BreakStatement = '󰙧 ',
  Call = '󰃷 ',
  CaseStatement = '󱃙 ',
  Class = '󰆦 ',
  Color = '󰏘 ',
  Constant = '󰕶 ',
  Constructor = '󰒓 ',
  ContinueStatement = '→ ',
  Copilot = ' ',
  Declaration = '󰙠 ',
  Delete = '󰩺 ',
  DoStatement = '󰑖 ',
  Enum = '❐ ',
  EnumMember = '󰞄 ',
  Event = '󰙴 ',
  Field = '󰓹 ',
  File = '󰈚 ',
  Folder = '󰉋 ',
  ForStatement = '󰑖 ',
  Function = '󰊕 ',
  H1Marker = '󰉫 ', -- Used by markdown treesitter parser
  H2Marker = '󰉬 ',
  H3Marker = '󰉭 ',
  H4Marker = '󰉮 ',
  H5Marker = '󰉯 ',
  H6Marker = '󰉰 ',
  Identifier = '󰀫 ',
  IfStatement = '󰇉 ',
  Interface = '󰆩 ',
  Keyword = '󱕵 ',
  List = '󰅪 ',
  Log = '󰦪 ',
  Lsp = ' ',
  Macro = '󰁌 ',
  MarkdownH1 = '󰉫 ', -- Used by builtin markdown source
  MarkdownH2 = '󰉬 ',
  MarkdownH3 = '󰉭 ',
  MarkdownH4 = '󰉮 ',
  MarkdownH5 = '󰉯 ',
  MarkdownH6 = '󰉰 ',
  Method = '󰆧 ',
  Module = '󰜋 ',
  Namespace = '󰘦 ',
  Null = '󰒉 ',
  Number = ' ',
  Object = '󰅩 ',
  Operator = '󰆕 ',
  Package = '󰏗 ',
  Pair = '󰅪 ',
  Property = '󰩧 ',
  Reference = ' ',
  Regex = '󰑑 ',
  Repeat = '󰑖 ',
  Scope = '󰅩 ',
  Snippet = '󰅴 ',
  Specifier = '󰦪 ',
  Statement = '󰅩 ',
  String = ' ',
  Struct = '󰜬 ',
  SwitchStatement = '󰺟 ',
  Terminal = ' ',
  Text = '󰉿 ',
  Type = ' ',
  TypeParameter = '󰘨 ',
  Unit = ' ',
  Value = '󰆙 ',
  Variable = '󰀫 ',
  WhileStatement = '󰑖 ',
}

return {
  'Bekaboo/dropbar.nvim',
  enabled = false,
  event = 'VeryLazy',
  keys = { { '<leader>wp', function() require('dropbar.api').pick() end, desc = 'winbar: pick' } },
  -- init = function()
  --   highlight.plugin('DropBar', {
  --     { DropBarIconUISeparator = { link = 'Delimiter' } },
  --     { DropBarMenuNormalFloat = { inherit = 'Pmenu' } },
  --   })
  -- end,
  config = {
    general = {
      update_interval = 100,
      -- enable = function(buf, win)
      --   local b, w = vim.bo[buf], vim.wo[win]
      --   local decor = ui.decorations.get({ ft = b.ft, bt = b.bt, setting = 'winbar' })
      --   return decor.ft ~= false
      --       and decor.bt ~= false
      --       and b.bt == ''
      --       and not w.diff
      --       and not api.nvim_win_get_config(win).zindex
      --       and api.nvim_buf_get_name(buf) ~= ''
      -- end,
    },
    icons = {
      ui = { bar = { separator = " 󰍟 " } },
      kinds = { symbols = vim.tbl_map(function(value) return value .. ' ' end, symbols) },
    },
    menu = {
      win_configs = {
        border = 'shadow',
        col = function(menu) return menu.prev_menu and menu.prev_menu._win_configs.width + 1 or 0 end,
      },
    },
  },
}
