require("kanagawa").setup({
	compile = true,
	compile_path = vim.fn.stdpath("cache") .. "/kanagawa",
	keywordStyle = { italic = false },
	colors = {
		palette = {
			samuraiRed = "#C34043",
			fujiGray = "#4c4c55", -- NvChad
			-- springViolet1 = "#9c86bf", -- Nvchad
			-- sumiInk4 = "#957FB8",
		},
		theme = {
			all = {
				ui = {
					bg_gutter = "none",
				},
			},
		},
	},
})
