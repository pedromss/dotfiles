local coding_file_types = { "elixir", "rust", "go", "lua" }
return {
	["feline-nvim/feline.nvim"] = { disable = true },
	["declancm/cinnamon.nvim"] = { disable = true },
	["akinsho/bufferline.nvim"] = { disable = true },
	["hrsh7th/nvim-cmp"] = { tag = "v0.0.1" },
	{ "nvim-treesitter/nvim-treesitter-context" },
	{ "tpope/vim-surround", tag = "v2.2" },
	{ "folke/trouble.nvim", ft = coding_file_types, config = require("user.plugins.trouble") },
	{ "godlygeek/tabular" },
	{ "hrsh7th/cmp-nvim-lua", commit = "d276254" },
	{ "ray-x/cmp-treesitter" },
	{ "nvim-neotest/neotest", ft = coding_file_types },
	{ "phaazon/hop.nvim", branch = "v2", config = require("user.plugins.hop") },
	{ "sindrets/diffview.nvim", requires = "nvim-lua/plenary.nvim" },
	{ "mg979/vim-visual-multi", tag = "v0.5.8" },
	{
		"nvim-lualine/lualine.nvim",
		requires = { "kyazdani42/nvim-web-devicons", opt = true },
		config = require("user.plugins.lualine"),
	},
	-- Colorschemes
	{ "ellisonleao/gruvbox.nvim", tag = "1.0.0", config = require("user.plugins.gruvbox") },
	{ "shaunsingh/nord.nvim", commit = "78f5f00" },
	{ "Shatur/neovim-ayu", commit = "15f9563" },
	{ "savq/melange", tag = "v0.9.0" },
	{ "EdenEast/nightfox.nvim", commit = "83f6ee9" },
	{ "wuelnerdotexe/vim-enfocado", commit = "66a197b" },
	{ "NLKNguyen/papercolor-theme", tag = "v1.0" },
	{ "YorickPeterse/vim-paper", commit = "93e06e7" },
}
