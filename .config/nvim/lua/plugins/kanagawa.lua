return {
  -- Kanagawa the - G O A T - colorscheme ever!
  {
    "rebelot/kanagawa.nvim",
    lazy = true,
    priority = 1000,
    init = function()
      vim.cmd.colorscheme("kanagawa")
    end,
    config = function()
      require("configs.kanagawa")
    end,
  },
}
