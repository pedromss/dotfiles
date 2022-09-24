local M = {}

function M.setup(config)
	vim.api.nvim_create_augroup("trigger_format_on_save", { clear = true })
	vim.api.nvim_create_autocmd("BufWritePre", {
		desc = "Format on save",
		group = "trigger_format_on_save",
		pattern = config.format.pattern,
		callback = function()
			vim.cmd(":Format")
			vim.cmd(":w")
		end,
	})

	vim.api.nvim_create_augroup("fold_management", { clear = true })
	for _, c in ipairs(config.folds) do
		vim.api.nvim_create_autocmd("BufAdd", {
			desc = "Set foldmethod",
			group = "fold_management",
			pattern = c.pattern,
			callback = function()
				vim.wo.foldmethod = "indent"
				vim.wo.wrap = true
				vim.wo.foldlevel = c.fold_level
			end,
		})
	end
end

return M
