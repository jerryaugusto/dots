return {
  "trstringer/psql.nvim",
  ft = "sql",
  config = function()
    local keymap = vim.keymap.set

    keymap("n", "<leader>db", "<cmd>lua require('psql').psql_run_curr_buf()<CR>",
      { desc = "Execute current buffer psql" })

    keymap("x", "<leader>db", "<ESC><cmd>lua require('psql').psql_run_visual()<CR>",
      { desc = "Execute selection with psql" })
  end
}
