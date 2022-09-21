local M = {}

function M.setup(configs)
	local name = "fold_management"
	augroup(name, { clear = true })
	for _, c in ipairs(configs) do
		cmd("BufEnter", {
			desc = "Set foldmethod",
			group = name,
			pattern = c.pattern,
			callback = function()
				vim.wo.foldmethod = "indent"
				vim.wo.wrap = true
			end,
		})
		cmd("BufAdd", {
			desc = "Set foldlevel",
			group = name,
			pattern = c.pattern,
			callback = function()
				vim.wo.foldlevel = c.fold_level
			end,
		})
	end
end

return M
