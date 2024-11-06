local options = {
	cmap = false,
	extension = {
		cond = {
			cond = {
				function(fn)
					return not fn.in_node("comment")
				end,
			},
		},
	},
}

return options
