local conform = require("conform")

conform.setup({
	formatters_by_ft = {
		lua = { "stylua" },
		css = { "biome" },
		html = { "prettierd" },
		graphql = { "biome" },
		javascript = { "biome" },
		javascriptreact = { "rustywind", "biome" },
		json = { "biome" },
		jsonc = { "biome" },
		markdown = { "biome" },
		rust = { "rustfmt" },
		typescript = { "biome" },
		typescriptreact = { "rustywind", "biome" },
		toml = { "taplo" },
		["*"] = { "trim_whitespace" },
	},
	format_on_save = {
		timeout_ms = 500,
		lsp_fallback = true,
	},
	-- formatters = {
	--   biome = {
	--     condition = function()
	--       return vim.loop.fs_realpath(".prettierrc.js") ~= nil or vim.loop.fs_realpath(".prettierrc.mjs") ~= nil
	--     end,
	--   },
	-- },
})

vim.keymap.set("n", "<leader>cf", function()
	require("conform").format({
		async = true,
	})
end, { desc = "Conform Format" })
