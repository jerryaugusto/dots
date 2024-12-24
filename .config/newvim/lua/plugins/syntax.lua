return {
  {
    "mfussenegger/nvim-lint",
    config = function()
      require("configs.lint")
    end,
  },
  -- Treesitter stuffs
  {
    "nvim-treesitter/nvim-treesitter",
    version = false,
    event = { "BufReadPre", "BufNewFile" },
    build = ":TSUpdate",
    dependencies = {
      {
        "nvim-treesitter/nvim-treesitter-textobjects",
        event = "BufReadPre",
        enabled = true,
      },
      "windwp/nvim-ts-autotag",
    },
    config = function()
      require("configs.treesitter")
    end,
  },
  {
    "altermo/ultimate-autopair.nvim",
    lazy = false,
    event = { "InsertEnter", "CmdlineEnter" },
    branch = "v0.6",
    opts = {
      cmap = false,
      extension = {
        cond = {
          cond = {
            function(fn)
              return not fn.in_node("comment")
            end,
          },
        },
      },
    },
  },
}
