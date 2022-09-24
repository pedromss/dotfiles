local M = {}

local function reload()
	for name, _ in pairs(package.loaded) do
		if name:match("^user") or name:match("^configs") or name:match("^core") then
			package.loaded[name] = nil
		end
	end

	dofile(vim.env.MYVIMRC)
end

function M.setup()
	vim.api.nvim_create_user_command("Reload", reload, { desc = "Reload config" })
end

return M
