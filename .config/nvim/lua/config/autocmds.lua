local api = vim.api

-- don't auto comment new line
api.nvim_create_autocmd("BufEnter", { command = [[ set formatoptions-=cro ]] })

-- Highlight yanked selection
api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank()
  end
})
-- vim.cmd [[
-- augroup highlight_yank
--     autocmd!
--     au TextYankPost * silent! lua vim.highlight.on_yank({higroup="IncSearch", timeout=150})
-- augroup END
-- ]]

-- cursor persistence
api.nvim_create_autocmd("BufReadPost", {
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)

    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end
})
-- vim.api.nvim_create_autocmd("BufReadPost", {
--   pattern = "*",
--   callback = function()
--     local line = vim.fn.line "'\""
--     if
--         line > 1
--         and line <= vim.fn.line "$"
--         and vim.bo.filetype ~= "commit"
--         and vim.fn.index({ "xxd", "gitrebase" }, vim.bo.filetype) == -1
--     then
--       vim.cmd 'normal! g`"'
--     end
--   end,
-- })
