local M = {}

function M.setup()
	vim.filetype.add({
		extension = {
			cfg = "cfg",
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
