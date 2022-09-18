local M = {}

function M.setup()
	vim.opt.background = "dark"
	vim.opt.relativenumber = true
	vim.cmd(":set laststatus=3")
end

return M
