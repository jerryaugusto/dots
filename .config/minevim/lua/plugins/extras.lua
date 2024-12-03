local fn, fmt = vim.fn, string.format

return {
  'smjonas/inc-rename.nvim',
  enabled = false,
  opts = { hl_group = 'Visual', preview_empty_name = true },
  keys = {
    {
      '<leader>lR',
      function() return fmt(':IncRename %s', fn.expand('<cword>')) end,
      expr = true,
      silent = false,
      desc = 'Incremental Rename (LSP)',
    },
  },
}
