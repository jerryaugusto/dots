local icons = {
  Namespace = " 󰘦  Namespace", -- 󰌗
  Text = " 󰉿  Text",
  Method = " 󰆧  Method", --  󰆧
  Function = " 󰡱  Function", -- 󰆧 󰊕 󰡱 󱃗 󰅲
  Constructor = " 󱌣  Constructor", --   󰡢 󰮐 󰑦 󰦬 󰒓
  Field = " 󰑆 Field", --  󰵮 󱪲 󰒡  󰽐
  Variable = " 󰀫  Variable", --  󰀫
  Class = " 󰆦  Class", -- 󰗦 󰠱
  Interface = " 󰆩  Interface", -- 
  Module = " 󰜋  Module", --  󰕳 󰙀 󰄮 󰝘 󰨑
  Property = " 󰩧  Property", -- 󰜢  󰩧 󰗼 󰡪 󰯁
  Unit = " 󰘨  Unit", -- 󰑭 
  Value = " 󰆙  Value", -- 󰎠
  Enum = " ❐  Enum",
  Keyword = " 󱇖  Keyword", -- 󰌋 󱕴 󱕵
  Snippet = " 󰅴  Snippet", -- 
  Color = " 󰏘  Color", -- 
  File = " 󰈚  File",
  Reference = "   Reference", -- 󰈇 󰣙 󰌧 󰌷
  Folder = " 󰉋  Folder",
  EnumMember = " 󰞄  EnumMember", --  󰑑
  Constant = " 󰕶  Constant", -- 󰏿 󰐀 󰛤
  Struct = " 󰜬  Struct", -- 󰙅
  Event = " 󰙴  Event", -- 
  Operator = " 󰆕  Operator", -- 󰎂 󰥮
  TypeParameter = " 󰊄  TypeParameter",
  Table = " 󰓫  Table",
  Object = " 󰅩  Object", -- 󱃖
  Tag = " 󰓹  Tag", -- 
  Array = " 󰅪  Array", -- 󰅨
  Boolean = "   Boolean", --   
  Number = "   Number", --  
  Null = " 󰒉  Null", -- 󰟢  󱏘
  String = "   String", -- 󰚞 󰉿   󰗧 󰝗
  Calendar = "   Calendar",
  Watch = " 󰥔  Watch",
  Package = " 󰏗  Package", -- 
  Copilot = "   Copilot",
  Codeium = "   Codeium",
  TabNine = "   TabNine",
}

return {
  "hrsh7th/nvim-cmp",
  event = "InsertEnter",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    {
      "L3MON4D3/LuaSnip",
      version = "v2.*",
      build = "make install_jsregexp"
    },
    "hrsh7th/cmp-nvim-lua",
    "saadparwaiz1/cmp_luasnip",
    "rafamadriz/friendly-snippets",
    "onsails/lspkind.nvim"
  },
  config = function()
    local cmp = require("cmp")
    local luasnip = require("luasnip")
    -- local lspkind = require("lspkind")

    local function border(glyph, msg_lvl, hl_name)
      return {
        { glyph, msg_lvl },
        { "─", hl_name },
        { "╮", hl_name },
        { "│", hl_name },
        { "╯", hl_name },
        { "─", hl_name },
        { "╰", hl_name },
        { "│", hl_name },
      }
    end

    require("luasnip.loaders.from_vscode").lazy_load()
    luasnip.config.setup({})

    cmp.setup({
      window = {
        completion = {
          -- border = "rounded", -- single|rounded|none
          border = border("󱐋", "WarningMsg", "Comment"),
			    winhighlight = "Normal:CmpPmenu,CursorLine:Search,Search:PmenuSel,FloatBorder:Comment", -- NvChad personal
          -- winhighlight = "Normal:CmpPmenu,CursorLine:Search,Search:None",
          side_padding = 1,   -- padding at sides
          col_offset = -3,    -- move floating box left or right
          scrollbar = false
        },
        documentation = {
          border = border("󰙎", "DiagnosticHint", "Comment" ),
          -- border = "rounded", -- single|rounded|none
          winhighlight = "Normal:CmpDoc",
        },
      },
      completion = {
        completeopt = "menu,menuone,preview,noselect",
        -- completeopt = "menu,menuone"
      },
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end
      },
      mapping = cmp.mapping.preset.insert({
        ["<Tab>"] = cmp.mapping.select_next_item(),
        ["<S-Tab>"] = cmp.mapping.select_prev_item(),
        ["<C-j>"] = cmp.mapping.scroll_docs(4),
        ["<C-k>"] = cmp.mapping.scroll_docs(-4),
        ["<C-space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.abort(),
        ["<CR>"] = cmp.mapping.confirm({ select = false }),
      }),
      sources = cmp.config.sources({
        { name = "nvim_lsp_signature_help" },
        { name = "nvim_lsp",               priority = 1000, max_item_count = 10 },
        { name = "luasnip",                priority = 15 },
        {
          name = "buffer",
          keyword_length = 3,
          max_item_count = 5,
          priority = 1,
          option = {
            get_bufnrs = function() return vim.api.nvim_list_bufs() end,
            keyword_pattern = [[\k\+]],
          },
        },
        { name = "path" },
        { name = "calc" },
        { name = "treesitter" },
        { name = "emoji" }
      }),
      experimental = {
        ghost_text = true,
      },
      formatting = {
        format = function(entry, item)
          item.kind = icons[item.kind]
          item.menu = ({
            nvim_lsp = "[LSP]",
            path = "[Path]",
            luasnip = "[Snip]",
            buffer = "[Bfr]",
            nvim_lua = "[Lua]"
          })[entry.source.name]
          return item
        end
      }
    })
  end
}
