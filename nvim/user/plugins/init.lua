local coding_file_types = { "elixir", "rust", "go", "lua" }
return {
	["feline-nvim/feline.nvim"] = { disable = true },
	["declancm/cinnamon.nvim"] = { disable = true },
	["akinsho/bufferline.nvim"] = { disable = true },
	["hrsh7th/nvim-cmp"] = { tag = "v0.0.1" },
	{ "ellisonleao/gruvbox.nvim", tag = "1.0.0", config = require("user.plugins.gruvbox") },
	{ "EdenEast/nightfox.nvim" },
	{ "nvim-treesitter/nvim-treesitter-context" },
	{ "tpope/vim-surround", tag = "v2.2" },
	{ "folke/trouble.nvim", ft = coding_file_types, config = require("user.plugins.trouble") },
	{ "godlygeek/tabular" },
	{ "shaunsingh/nord.nvim", commit = "78f5f00" },
	{ "hrsh7th/cmp-nvim-lua", commit = "d276254" },
	{ "ray-x/cmp-treesitter" },
	{ "nvim-neotest/neotest", ft = coding_file_types },
	{ "phaazon/hop.nvim", branch = "v2", config = require("user.plugins.hop") },
	{ "sindrets/diffview.nvim", requires = "nvim-lua/plenary.nvim" },
	{
		"nvim-lualine/lualine.nvim",
		requires = { "kyazdani42/nvim-web-devicons", opt = true },
		config = require("user.plugins.lualine"),
	},
}
