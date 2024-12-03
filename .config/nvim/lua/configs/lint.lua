local lint = require("lint")
local map = require("core.keymaps.map")

lint.linters_by_ft = {
	css = { "biomejs" },
	-- html = { "biomejs" },
	markdown = { "markdownlint" },
	fish = { "fish" },
	javascript = { "biomejs" },
	javascriptreact = { "biomejs" },
	typescript = { "biomejs" },
	typescriptreact = { "biomejs" },
	lua = { "selene" },
	yaml = { "yamllint" },
	json = { "biomejs" },
	jsonc = { "biomejs" },
}

local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
	group = lint_augroup,
	callback = function()
		lint.try_lint()
	end,
})

map("n", "<leader>lt", function()
	require("lint").try_lint()
end, "Trigger linting for current file")
