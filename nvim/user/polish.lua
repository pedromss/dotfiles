return function()
	require("user.extensions").setup()
	require("user.colors").setup()
	require("user.scratch").setup()
	require("user.reload").setup()
	require("user.autocmds").setup({
		aerial = {
			{ pattern = "*.md" },
		},
		folds = {
			{ fold_level = 0, pattern = "*.sh" },
			{ fold_level = 4, pattern = "*.lua" },
			{ fold_level = 1, pattern = { "*.ex", "*.exs" } },
			{ fold_level = 2, pattern = { "rust" } },
		},
		format = {
			pattern = {
				-- "*.ex",
				-- "*.exs",
				"*.sh",
				"*.rs",
			},
		},
	})

	vim.cmd(":iabbre adn and")
end
