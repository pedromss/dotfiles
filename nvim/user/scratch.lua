-- Following https://teukka.tech/luanvim.html
local api = vim.api
local M = {}

local function make_scratch()
	api.nvim_command("enew")

	vim.bo[0].buftype = "nofile"
	vim.bo[0].bufhidden = "hide"
	vim.bo[0].swapfile = false

	-- TODO popup to choose the filetype
end

function M.setup()
	vim.api.nvim_create_user_command("Scratch", make_scratch, { desc = "Reload config" })
end

return M
