return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPost", "BufNewFile" },
    cmd = { "LspInfo", "LspInstall", "LspUninstall" },
    dependencies = {
      "saghen/blink.cmp",
      {
        "folke/lazydev.nvim",
        ft = "lua", -- only load on lua files
        opts = {
          library = {
            { path = "${3rd}/luv/library", words = { "vim%.uv" } },
          },
        },
      },
    },
    config = function()
      local capabilities = require("blink.cmp").get_lsp_capabilities()
      local on_attach = function(_, bufnr)
        local opts = { noremap = true, silent = true }
        local map = vim.api.nvim_buf_set_keymap
        -- map(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", opts)
        map(bufnr, "n", "<space>ld", "<cmd>lua vim.lsp.buf.definition()<cr>", opts)
        map(bufnr, "n", "<space>lr", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
        map(bufnr, "n", "<space>la", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)
      end
      require("lspconfig").cssls.setup { capabilities = capabilities, on_attach = on_attach }
      require("lspconfig").gopls.setup { capabilities = capabilities, on_attach = on_attach }
      require("lspconfig").lua_ls.setup { capabilities = capabilities, on_attach = on_attach }
      require("lspconfig").emmet_language_server.setup { capabilities = capabilities, on_attach = on_attach }
      require("lspconfig").tailwindcss.setup { capabilities = capabilities, on_attach = on_attach }
      require("lspconfig").html.setup { capabilities = capabilities, on_attach = on_attach }
      require("lspconfig").biome.setup { capabilities = capabilities, on_attach = on_attach }

      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if not client then return end

          if client.supports_method("textDocument/formatting") then
            -- Format the current buffer on save
            vim.api.nvim_create_autocmd("BufWritePre", {
              buffer = args.buf,
              callback = function()
                vim.lsp.buf.format({ bufnr = args.buf, id = client.id })
              end
            })
          end
        end
      })

      -- decreases the frequency of diagnoses.
      vim.diagnostic.config({
        update_in_insert = false, -- Does not update diagnostics in insert mode
        virtual_text = false,     -- Reduces visual noise
        signs = true,             -- Show error icons in gutter
      })
    end,
  },
}
