return {
  "numToStr/FTerm.nvim",
  keys = {
    { "<A-i>", "<cmd>lua require('FTerm').toggle()<cr>", "Terminal" },
    { "<A-i>", "<C-\\><C-n><cmd>lua require('FTerm').toggle()<cr>", "Terminal" },
  },
  config = function()
    require 'FTerm'.setup({
      border = 'rounded', -- none, single, double, rounded, solid or shadow
      dimensions  = {
        height = 0.9,
        width = 0.9,
      },
    })

    -- Example keybindings
    -- vim.keymap.set('n', '<A-i>', '<CMD>lua require("FTerm").toggle()<CR>')
    -- vim.keymap.set('t', '<A-i>', '<C-\\><C-n><CMD>lua require("FTerm").toggle()<CR>')
  end
}
