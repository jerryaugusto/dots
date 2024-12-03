return {
  {
    "lewis6991/gitsigns.nvim",
    lazy = false,
    config = function()
      local icons = require("config.icons")
      require("gitsigns").setup({
        signs = {
          add = {
            -- hl = "GitSignsAdd",
            text = icons.ui.BoldLineLeft,
            -- numhl = "GitSignsAddNr",
            -- linehl = "GitSignsAddLn",
          },
          change = {
            -- hl = "GitSignsChange",
            text = icons.ui.BoldLineLeft,
            -- numhl = "GitSignsChangeNr",
            -- linehl = "GitSignsChangeLn",
          },
          delete = {
            -- hl = "GitSignsDelete",
            text = icons.ui.TriangleShortArrowRight,
            -- numhl = "GitSignsDeleteNr",
            -- linehl = "GitSignsDeleteLn",
          },
          topdelete = {
            -- hl = "GitSignsDelete",
            text = icons.ui.TriangleShortArrowRight,
            -- numhl = "GitSignsDeleteNr",
            -- linehl = "GitSignsDeleteLn",
          },
          changedelete = {
            -- hl = "GitSignsChange",
            text = icons.ui.BoldLineLeft,
            -- numhl = "GitSignsChangeNr",
            -- linehl = "GitSignsChangeLn",
          },
        },
        signcolumn = true,
        numhl = false,
        linehl = false,
        word_diff = false,
        watch_gitdir = {
          interval = 1000,
          follow_files = true,
        },
        attach_to_untracked = true,
        current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
        current_line_blame_opts = {
          virt_text = true,
          virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
          delay = 1000,
          ignore_whitespace = false,
        },
        current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
        sign_priority = 6,
        status_formatter = nil,
        update_debounce = 200,
        max_file_length = 40000,
        preview_config = {
          border = "rounded",
          style = "minimal",
          relative = "cursor",
          row = 0,
          col = 1,
        },
        -- yadm = { enable = false },

        on_attach = function(bufnr)
          vim.keymap.set(
            "n",
            "<leader>H",
            require("gitsigns").preview_hunk,
            { buffer = bufnr, desc = "Preview git hunk" }
          )

          vim.keymap.set("n", "]]", require("gitsigns").next_hunk, { buffer = bufnr, desc = "Next git hunk" })

          vim.keymap.set(
            "n",
            "[[",
            require("gitsigns").prev_hunk,
            { buffer = bufnr, desc = "Previous git hunk" }
          )
        end,
      })
    end,
  },
  {
    "sindrets/diffview.nvim",
    enabled = false,
    event = "VeryLazy",
    cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles" },
  },
  {
    "chrisgrieser/nvim-tinygit",
    event = "VeryLazy",
    ft = { "gitrebase", "gitcommit" },
    dependencies = { "stevearc/dressing.nvim" },
    opts = {
      commitMsg = {
        commitPreview = true,
        conventionalCommits = { enforce = true },
        spellcheck = true,
        keepAbortedMsgSecs = 60 * 10, -- 10 mins
        insertIssuesOnHash = { enabled = true, next = "#" },
      },
      historySearch = {
        autoUnshallowIfNeeded = true,
        diffPopup = {
          width = 0.9,
          height = 0.9,
          border = vim.g.borderStyle,
        },
      },
    },
  },
  {
    "SuperBo/fugit2.nvim",
    enabled = false,
    cmd = { "Fugit2", "Fugit2Diff ", "Fugit2Graph" },
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-tree/nvim-web-devicons",
      "nvim-lua/plenary.nvim",
      {
        'chrisgrieser/nvim-tinygit', -- optional: for Github PR view
        dependencies = { 'stevearc/dressing.nvim' }
      }
    },
    opts = {},
    commitMsg = {
      commitPreview = true,
      conventionalCommits = { enforce = true },
      spellcheck = true,
      keepAbortedMsgSecs = 60 * 10, -- 10 mins
      insertIssuesOnHash = { enabled = true },
    },
    historySearch = {
      autoUnshallowIfNeeded = true,
      diffPopup = {
        width = 0.9,
        height = 0.9,
        border = vim.g.borderStyle,
      },
    },
    statusline = {
      blame = {
        maxMsgLen = 15
      },
      branchState = {
        icons = {
          ahead = "󰬬", -- 󰶣
          behind = "󰬦", -- 󰶡
          diverge = "󰿣", -- 󰃻
        },
      },
    }
  },
  {
    "kdheepak/lazygit.nvim",
    enabled = true,
    cmd = {
      "LazyGit",
      "LazyGitConfig",
      "LazyGitCurrentFile",
      "LazyGitFilter",
      "LazyGitFilterCurrentFile",
    },
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
      { "<leader>Gg", "<cmd>LazyGit<cr>", desc = "Open LazyGit" }
    }
  }
}
