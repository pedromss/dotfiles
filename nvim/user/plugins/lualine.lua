return require("lualine").setup({
	options = {
		icons_enabled = true,
		theme = "nord",
		component_separators = { left = "", right = "" },
		section_separators = { left = "", right = "" },
		disabled_filetypes = {
			statusline = {},
			winbar = {},
			tabline = {},
		},
		ignore_focus = {},
		always_divide_middle = true,
		globalstatus = true,
		refresh = {
			statusline = 1000,
			tabline = 1000,
			winbar = 1000,
		},
	},
	sections = {
		lualine_a = {
			{
				"mode",
				fmt = function(x)
					return x:sub(0, 2)
				end,
			},
		},
		lualine_b = {},
		lualine_c = {
			{
				"filename",
				path = 1,
				shorting_target = 120,
			},
		},
		lualine_x = { "diff", "branch" },
		lualine_y = { "diagnostics", "filetype", "encoding", "fileformat" },
		lualine_z = { "location" },
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = { "filename" },
		lualine_x = { "location" },
		lualine_y = {},
		lualine_z = {},
	},
	tabline = {
		lualine_a = { "buffers" },
		lualine_b = {},
		lualine_c = {},
		lualine_x = {},
		lualine_y = { "progress" },
		lualine_z = { { "tabs", mode = 2 } },
	},
	winbar = {},
	inactive_winbar = {},
	extensions = { "neo-tree", "aerial", "quickfix" },
})
