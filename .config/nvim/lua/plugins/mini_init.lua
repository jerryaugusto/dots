package.preload["nvim-web-devicons"] = function()
	package.loaded["nvim-web-devicons"] = {}
	require("mini.icons").mock_nvim_web_devicons()
	return package.loaded["nvim-web-devicons"]
end
