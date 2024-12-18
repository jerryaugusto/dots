local M = {}

M.border = {
	none = "none",

	default = function(hl_name)
		return {
      { "╭", hl_name },
			{ "─", hl_name },
			{ "╮", hl_name },
			{ "│", hl_name },
			{ "╯", hl_name },
			{ "─", hl_name },
			{ "╰", hl_name },
			{ "│", hl_name },
		}
	end,

	styled = function(glyph, msg_lvl, hl_name)
		return {
			{ glyph, msg_lvl },
			{ "─", hl_name },
			{ "╮", hl_name },
			{ "│", hl_name },
			{ "╯", hl_name },
			{ "─", hl_name },
			{ "╰", hl_name },
			{ "│", hl_name },
		}
	end,
}

M.glyph = {
	kind = {
		Namespace = "󰘦", -- 󰌗
		Text = "󰉿",
		Method = "", -- 󰆧
		Function = "󰡱", -- 󰆧
		Constructor = "", --  󱌣
		Field = "󰜢",
		Variable = "󰀫",
		Class = "󰆦", -- 󰠱
		Interface = "󰆩", -- 
		Module = "󰜋",
		Property = "󰜢",
		Unit = "󰘨", -- 󰑭
		Value = "󰆙", -- 󰎠
		Enum = "󰪚", --  ❐ 󰘷
		Keyword = "󱕵", -- 󰌋
		Snippet = "", --  󰅴
		Color = "󰏘",
		File = "󰈚",
		Reference = "", -- 󰈇 󰗽
		Folder = "󰉋",
		EnumMember = "", -- 
		Constant = "󰕶", -- 󰏿
		Struct = "󰜬", -- 󰙅
		Event = "󰙴", -- 
		Operator = "", -- 󰆕
		TypeParameter = "󰊄",
		Table = "󰓫", -- 
		Object = "󰅩",
		Tag = "",
		Array = "󰅪", -- [
		Boolean = "",
		Number = "", -- 
		Null = "󰒉", -- 󰟢
		Supermaven = "",
		String = "", -- 󰉿
		Calendar = "",
		Watch = "󰥔",
		Package = "󰏗",
		Copilot = "",
		Codeium = "",
		TabNine = "",
		BladeNav = "",
	},
	git = {
		Git = "󰊢",
		GitAlt = "",
		GitFolder = "",
		Blame = "",
		GitHub = "",
		GitHubBig = "󰊤",
		Commit = "󰜘",
		CommitAlt = "",
		CommitAmend = "󰕍",
		CommitAmendAlt = "󰑏",
		CommitUndo = "󰕌",
		CommitRedo = "󰑎",
		Pull = "",
		Push = "",
		Rebase = "",
		History = "",
		SmartCommit = "",
		LineAdded = "",
		LineModified = "",
		LineRemoved = "",
		FileDeleted = "",
		FileIgnored = "",
		FileRenamed = "",
		FileStaged = "S",
		FileUnmerged = "",
		FileUnstaged = "",
		FileUntracked = "U",
		Diff = "",
		Repo = "",
		Octoface = "",
		Branch = "",
	},
	dev = {
		Neovim = "",
		Golang = "󰟓",
		Gopher = "",
		Build = "󰏓",
		Ghost = "󰊠",
		ReplaceFind = "󰛔",
		Replace = "",
		ReplaceAll = "",
		Comment = "󱀡",
		Doc = "󰈚",
		Import = "󰈠",
		Lint = "",
		Tag = "󰓻",
		TestAB = "󰇉",
		TestTube = "󰙨",
		TestTubeEmpity = "󰤑",
		TestTubeOff = "󰤒",
		Split = "󰤼",
		Fzy = "󰈞",
		Signature = "󰈷",
	},
	ui = {
		ArrowCircleDown = "",
		ArrowCircleLeft = "",
		ArrowCircleRight = "",
		ArrowCircleUp = "",
		BoldArrowDown = "",
		BoldArrowLeft = "",
		BoldArrowRight = "󰅂", -- 
		BoldArrowUp = "",
		BoldClose = "",
		BoldDividerLeft = "",
		BoldDividerRight = "",
		BoldLineLeft = "▎",
		BookMark = "",
		BoxChecked = "",
		Stacks = "",
		Scopes = "",
		Watches = "",
		DebugConsole = "",
		Calendar = "",
		Check = "",
		ChevronRight = ">",
		ChevronShortDown = "",
		ChevronShortLeft = "",
		ChevronShortRight = "",
		ChevronShortUp = "",
		CircleLarge = "",
		Circle = "󰑊",
		CircleSmall = "",
		CircleSmallAlt = "",
		CircleBig = "",
		CircleBigAlt = "",
		Sync = "󰓦",
		SyncAlert = "󰓧",
		SyncBold = "󱍸",
		SyncOff = "󰓨",
		Pending = "󰑐",
		PendingBold = "󱍷",
		Close = "",
		CloudDownload = "",
		Code = "",
		Comment = "",
		Dashboard = "",
		DividerLeft = "",
		DividerRight = "",
		DoubleChevronRight = "»",
		Ellipsis = "",
		EmptyFolder = "",
		EmptyFolderOpen = "",
		Event = "",
		EventAlt = "󱐋",
		File = "",
		FileSymlink = "",
		Files = "",
		FindFile = "",
		FindText = "",
		Fire = "",
		Folder = "󰉋",
		FolderOpen = "",
		FolderSymlink = "",
		Forward = "",
		Gear = "",
		History = "",
		Info = "󰙎",
		InfoCircle = "󰗖",
		Lightbulb = "",
		LineLeft = "▏",
		LineMiddle = "│",
		ThreeDotLine = "",
		DottedLine = "",
		List = "",
		Lock = "",
		NewFile = "",
		Note = "",
		Package = "󰏗",
		Pencil = "",
		Plus = "",
		Project = "",
		Search = "󰍉", --   󰍉 
		SignIn = "",
		SignOut = "",
		Tab = "",
		Table = "󰓫",
		Target = "󰀘",
		Telescope = "", --    󰭎
		Explorer = "",
		Text = "",
		Tree = "",
		Triangle = "契",
		TriangleShortArrowDown = "",
		TriangleShortArrowLeft = "",
		TriangleShortArrowRight = "",
		TriangleShortArrowUp = "",
	},
	diagnostics = {
		BoldError = "",
		Error = "",
		BoldWarning = "",
		Warning = "",
		BoldInformation = "",
		Information = "",
		BoldQuestion = "",
		Question = "",
		BoldHint = "",
		Hint = "",
		Debug = "",
		LadyBug = "󰠭",
		BugLittle = "",
		BugOutAlt = "",
		BugAlt = "",
		Bug = "󰃤",
		BugCheck = "󰨮",
		BugOut = "󰨰",
		Trace = "✎",
	},
	misc = {
		Robot = "ﮧ",
		Squirrel = "",
		Tag = "󰓹",
		Watch = "",
		Smiley = "",
		Package = "",
		CircuitBoard = "",
	},
}

return M
