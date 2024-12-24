local conform = require("conform")
local map = require("core.keymaps.map")

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
})

-- local function map(mode, keys, action, desc)
--   desc = desc or ""
--   local opts = { noremap = true, silent = true, desc = desc }
--   vim.keymap.set(mode, keys, action, opts)
-- end

map("n", "<leader>lf", function()
	conform.formatt({ async = true })
end, "Conform format")
