local M = {}

function M.setup(config)
	augroup("trigger_format_on_save", { clear = true })
	cmd("BufWritePre", {
		desc = "Format on save",
		group = "trigger_format_on_save",
		pattern = config.pattern,
		callback = function()
			vim.cmd(":Format")
		end,
	})
end

return M
