local M = {}

function M.toggle_background()
	local bg = "dark"
	if vim.opt.background:get() == bg then
		bg = "light"
	end
	vim.cmd(":set background=" .. bg)
end

function M.setup()
	vim.cmd("command! ToggleBackground lua require'user.colors'.toggle_background()")
end

return M
