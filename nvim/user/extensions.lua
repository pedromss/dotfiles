local M = {}

function M.setup()
	vim.filetype.add({
		extension = {
			cfg = "cfg",
			heex = "html",
		},
		--   filename = {
		--     ["Foofile"] = "fooscript",
		--   },
		--   pattern = {
		--     ["~/%.config/foo/.*"] = "fooscript",
		--   },
	})
end

return M
