return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		{ "antosha417/nvim-lsp-file-operations", config = true },
		{ "j-hui/fidget.nvim", opts = {} },
	},
	config = function()
		local lspconfig = require("lspconfig")
		local mason_lspconfig = require("mason-lspconfig")
		local cmp_nvim_lsp = require("cmp_nvim_lsp")
		local keymap = vim.keymap.set

		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("UserLspConfig", {}),
			callback = function(ev)
				local opts = { buffer = ev.buf, silent = true }

				-- Jump to the definition of the word under your cursor.
				opts.desc = "Show LSP definitions"
				keymap("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)

				-- Find references for the word under your cursor.
				opts.desc = "Show LSP references"
				keymap("n", "gr", "<cmd>Telescope lsp_references<CR>", opts)

				-- Jump to the implementation of the word under your cursor.
				opts.desc = "Show LSP implementations"
				keymap("n", "gI", "<cmd>Telescope lsp_implementations<CR>", opts)

				-- Jump to the type of the word under your cursor.
				opts.desc = "Show LSP type definitions"
				keymap("n", "<leader>D", "<cmd>Telescope lsp_type_definitions<CR>", opts)

				-- Fuzzy find all the symbols in your current document.
				opts.desc = "Document symbols"
				keymap("n", "<leader>ds", "<cmd>Telescope lsp_document_symbols<CR>", opts)

				-- Fuzzy find all the symbols in your current workspace.
				opts.desc = "Workspace symbols (dynamic)"
				keymap("n", "<leader>ws", "<cmd>Telescope lsp_dynamic_workspace_symbols<CR>", opts)

				-- Fuzzy find all the symbols
				opts.desc = "Workspace symbols"
				keymap("n", "<leader>P", "<cmd>Telescope lsp_workspace_symbols<CR>", opts)

				-- Rename the variable under your cursor.
				opts.desc = "Smart rename"
				keymap("n", "<leader>rn", vim.lsp.buf.rename, opts)

				-- Execute a code action, usually your cursor needs to be on top of an error
				opts.desc = "See available code actions"
				keymap({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)

				-- Opens a popup that displays documentation about the word under your cursor
				opts.desc = "Show documentation for what is under cursor"
				keymap("n", "K", vim.lsp.buf.hover, opts)

				-- WARN: This is not Goto Definition, this is Goto Declaration.
				opts.desc = "Go to declaration"
				keymap("n", "gD", vim.lsp.buf.declaration, opts)

				opts.desc = "Signature documentation"
				keymap("n", "gS", vim.lsp.buf.signature_help, opts)

				opts.desc = "Go to definition in vertical split"
				keymap("n", "gv", "<cmd>vsplit | lua vim.lsp.buf.definition()<CR>", opts)

				opts.desc = "Show line diagnostics"
				keymap("n", "gl", vim.diagnostic.open_float, opts)

				opts.desc = "Show buffer diagnostics"
				keymap("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts)

				opts.desc = "Go to next diagnostic"
				keymap("n", "]d", vim.diagnostic.goto_next, opts)

				opts.desc = "Go to previous diagnostic"
				keymap("n", "[d", vim.diagnostic.goto_prev, opts)

				opts.desc = "Restart LSP"
				keymap("n", "<leader>rs", ">LspRestart", opts)

				-- Toggle enable inlay hints
				-- local client = vim.lsp.get_client_by_id(ev.data.client_id)
				-- if client and client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
				--   opts.desc = "Toggle inlay hints"
				--   keymap("n", '<leader>ih', function()
				--     vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled)
				--   end, opts)
				-- end
			end,
		})

		local capabilities = cmp_nvim_lsp.default_capabilities()
		-- vim.diagnostic.config({
		--   virtual_text = false,
		--   signs = {
		--     text = {
		--       [vim.diagnostic.severity.ERROR] = '',
		--       [vim.diagnostic.severity.WARN] = '',
		--       [vim.diagnostic.severity.INFO] = '',
		--       [vim.diagnostic.severity.HINT] = '',
		--     }
		--     text = { "", "", "", "" }
		--   }
		-- })
		local signs = { Error = "", Warn = "", Hint = "", Info = "" }
		for type, icon in pairs(signs) do
			local hl = "DiagnosticSign" .. type
			vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
		end

		mason_lspconfig.setup_handlers({
			function(server_name)
				lspconfig[server_name].setup({
					capabilities = capabilities,
				})
			end,
			["lua_ls"] = function()
				lspconfig["lua_ls"].setup({
					capabilities = capabilities,
					settings = {
						Lua = {
							diagnostics = {
								global = { "vim" },
							},
							completion = {
								callSnippet = "Replace",
							},
						},
					},
				})
			end,
		})
	end,
}
