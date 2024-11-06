local mini_config = require("plugins.mini_nvim")
local mini_modules = {
	"ai",
	"basics",
	"bufremove",
	"clue",
	"comment",
	"cursorword",
	"deps",
	"diff",
	"extra",
	"files",
	"git",
	"hipatterns",
	"icons",
	"indentscope",
	"move",
	"notify",
	"pick",
	"starter",
	"statusline",
	"surround",
	"tabline",
	"test",
	"trailspace",
	"visits",
}
for _, module in ipairs(mini_modules) do
	require("mini." .. module).setup(mini_config[module])
end
