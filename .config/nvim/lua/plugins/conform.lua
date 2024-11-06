require("conform").setup({
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
		lsp_fallback = true,
		timeout_ms = 500,
		async = false,
	},
	-- formatters = {
	-- 	biome = {
	-- 		condition = function()
	-- 			return vim.loop.fs_realpath("boime.json") ~= nil
	-- 				or vim.loop.fs_realpath("biome.jsonc") ~= nil
	-- 		end,
	-- 	},
	-- },
})
