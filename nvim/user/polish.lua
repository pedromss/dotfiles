return function()
	augroup("aerial_ext", { clear = true })
	cmd("BufAdd", {
		desc = "Set collapse level",
		group = "aerial_ext",
		pattern = { "*.aerial" },
		callback = function()
			vim.cmd(":AerialTreeSetCollapseLevel 1")
		end,
	})

	-- Set up custom filetypes
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

	require("user.autorequire").setup()
	require("hop").setup()
	require("user.folds").setup({
		{ fold_level = 0, pattern = "*.sh" },
		{ fold_level = 2, pattern = "*.lua" },
		{ fold_level = 1, pattern = { "*.ex", "*.exs" } },
		{ fold_level = 2, pattern = { "rust" } },
	})
	require("user.format").setup({ pattern = {
		"*.ex",
		"*.exs",
		"*.sh",
		"*.rs",
	} })
	require("user.opts").setup()
	require("user.colors").setup()
	require("user.autocmds").setup({
		aerial = {
			{ pattern = "*.md" },
		},
	})

	-- TODO confirm this is useful
	require("lspconfig").jsonls.setup({
		settings = {
			json = {
				schemas = require("schemastore").json.schemas(),
				validate = { enable = true },
			},
		},
	})
end
