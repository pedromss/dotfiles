local avail, p = pcall(require, "lualine")
if not avail then
	return
end
p.setup({
	sections = {
		lualine_c = {
			{
				"filename",
				path = 1,
				shorting_target = 80,
			},
		},
	},
	extensions = { "neo-tree", "aerial", "toggleterm" },
})
