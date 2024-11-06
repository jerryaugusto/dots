if vim.fn.argc() == 0 then
	return "VimEnter"
else
	return { "InsertEnter", "LspAttach" }
end
