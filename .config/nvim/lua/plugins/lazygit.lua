return {
  "kdheepak/lazygit.nvim",
  enabled = false,
  cmd = {
    "LazyGit",
    "LazyGitConfig",
    "LazyGitCurrentFile",
    "LazyGitFilter",
    "LazyGitFilterCurrentFile",
  },
  dependencies = { "nvim-lua/plenary.nvim" },
  keys = {
    { "<leader>gl", "<cmd>LazyGit<cr>", desc = "Open LazyGit" }
  }
}
