local M = {}

function M.setup(configs)
	augroup("fold_management", { clear = true })
	for _, c in ipairs(configs) do
		cmd("BufEnter", {
			desc = "Set foldmethod",
			group = "fold_management",
			pattern = c.pattern,
			callback = function()
				vim.wo.foldmethod = "indent"
				vim.wo.wrap = true
			end,
		})
		cmd("BufAdd", {
			desc = "Set foldmethod",
			group = "fold_management",
			pattern = c.pattern,
			callback = function()
				vim.wo.foldlevel = c.fold_level
			end,
		})
	end
end

return M
