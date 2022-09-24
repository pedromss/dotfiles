local function hide_irrelevant_path_parts(_, path)
	return path:gsub(vim.env.HOME, "~")
		:gsub(".config/nvim", "~n")
		:gsub("dotfiles", "~d")
		:gsub("nvim/user", "~user")
		:gsub("repos/playground", "~p")
end
return {
	defaults = {
		layout_strategy = "horizontal",
		layout_config = {
			vertical = {
				width = 0.99,
				height = 0.99,
				previewer = true,
				preview_cutoff = 1,
				results_height = 0.4,
				preview_height = 0.6,
				prompt_location = "top",
			},
			horizontal = {
				width = 0.99,
				height = 0.99,
				preview_width = 0.5,
				results_width = 0.5,
				preview_cutoff = 1,
				results_height = 0.5,
				preview_height = 0.5,
			},
			flex = {
				height = 0.95,
				width = 0.95,
				prompt_location = "top",
				preview_cutoff = 1,
				results_height = 0.3,
				preview_height = 0.7,
			},
		},
	},
	pickers = {
		oldfiles = require("telescope.themes").get_dropdown({
			cwd_only = true,
			layout_config = { width = 0.5 },
			path_display = hide_irrelevant_path_parts,
		}),
		find_files = {
			cwd_only = true,
			path_display = hide_irrelevant_path_parts,
		},
	},
}
