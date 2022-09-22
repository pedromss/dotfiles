local avail, p = pcall(require, "diffview")
if not avail then
	return
end
p.setup({
	view = {
		default = {
			layout = "diff2_horizontal",
		},
		merge_tool = {
			layout = "diff3_mixed",
			disable_diagnostics = true, -- Temporarily disable diagnostics for conflict buffers while in the view.
		},
		file_history = {
			layout = "diff2_horizontal",
		},
	},
})
