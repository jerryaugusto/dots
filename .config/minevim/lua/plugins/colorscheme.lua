return {
  "rebelot/kanagawa.nvim",
  priority = 1000,
  config = function()
    require "kanagawa".setup({
      compile = true,
      keywordStyle = { italic = false },
      colors = {
        palette = {
          samuraiRed = "#C34043",
          fujiGray = "#4c4c55",      -- NvChad
          springViolet1 = "#9c86bf", -- Nvchad
          sumiInk4 = "#957FB8",
        },
        theme = {
          all = {
            ui = {
              bg_gutter = "none"
            }
          }
        }
      }
    })
    vim.cmd("colorscheme kanagawa")
  end
}
