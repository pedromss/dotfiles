local M = {}

function M.setup()
	local plugin_dir = vim.env.HOME .. "/.config/nvim/lua/user/plugins/"
	local scan = require("plenary.scandir")
	local files = scan.scan_dir(plugin_dir, { hidden = false, depth = 1 })
	for _, fname in pairs(files) do
		local plugin_name = fname:gsub(plugin_dir, ""):gsub(".lua$", ""):gsub("/", ".")
		require("user.plugins" .. plugin_name)
	end
end

return M
