local lspconfig = require("lspconfig")
local capabilities = require("blink.cmp").get_lsp_capabilities()
local on_attach = function(client, bufnr)
	if client.server_capabilities.documentFormattingProvider then
		vim.api.nvim_create_autocmd("BufWritePre", {
			buffer = bufnr,
			callback = function()
				require("conform").format({
					lsp_fallback = true,
					async = false,
				})
			end,
		})
	end
end

local servers = {
	biome = {},
	gopls = {},
	cssls = {},
	vtsls = {},
	-- ts_ls = {},
	emmet_language_server = {},
	tailwindcss = {},
	html = {},
	lua_ls = {
		settings = {
			Lua = {
				diagnostics = {
					globals = { "vim" },
				},
			},
		},
	},
}

for server, opts in pairs(servers) do
	lspconfig[server].setup(vim.tbl_deep_extend("force", {
		on_attach = on_attach,
		capabilities = capabilities,
	}, opts))
end

-- require("lspconfig").biome.setup { capabilities = capabilities }
-- require("lspconfig").cssls.setup { capabilities = capabilities }
-- require("lspconfig").gopls.setup { capabilities = capabilities }
-- require("lspconfig").lua_ls.setup { capabilities = capabilities }
-- require("lspconfig").emmet_language_server.setup { capabilities = capabilities }
-- require("lspconfig").tailwindcss.setup { capabilities = capabilities }
-- require("lspconfig").html.setup { capabilities = capabilities }

-- vim.api.nvim_create_autocmd("LspAttach", {
--   callback = function(args)
--     local client = vim.lsp.get_client_by_id(args.data.client_id)
--     if not client then
--       return
--     end
--
--     if client.supports_method("textDocument/formatting") then
--       -- Format the current buffer on save
--       vim.api.nvim_create_autocmd("BufWritePre", {
--         buffer = args.buf,
--         callback = function()
--           require("conform").format({
--             lsp_fallback = true,
--             async = false,
--           })
--           -- vim.lsp.buf.format({ bufnr = args.buf, id = client.id })
--         end,
--       })
--     end
--   end,
-- })

-- decreases the frequency of diagnoses.
vim.diagnostic.config({
	update_in_insert = false, -- Does not update diagnostics in insert mode
	virtual_text = false, -- Reduces visual noise
	signs = true, -- Show error icons in gutter
	underline = true,
	severity_sort = true,
	float = {
		focusable = true,
		style = "minimal",
		border = "rounded",
		source = "always",
		header = "",
		prefix = "",
	},
})
