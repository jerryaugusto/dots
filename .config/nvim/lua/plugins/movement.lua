return {
  -- Enhanced f/t motions for Leap
  {
    "ggandor/flit.nvim",
    config = function()
      require('flit').setup {
        keys = { f = 'f', F = 'F', t = 't', T = 'T' },
        -- A string like "nv", "nvo", "o", etc.
        labeled_modes = "v",
        -- Repeat with the trigger key itself.
        clever_repeat = true,
        multiline = true,
        -- Like `leap`s similar argument (call-specific overrides).
        -- E.g.: opts = { equivalence_classes = {} }
        opts = {}
      }
    end
  },
  -- Mouse replacement
  {
    "ggandor/leap.nvim",
    config = function() require("leap").create_default_mappings() end,
  },

  -- Find and replace
  {
    "windwp/nvim-spectre",
    event = "BufRead"
  }
}
