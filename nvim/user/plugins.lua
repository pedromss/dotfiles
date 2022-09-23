local coding_file_types = { "elixir", "rust", "go", "lua" }

return {
	init = {
		["feline-nvim/feline.nvim"] = { disable = true },
		["declancm/cinnamon.nvim"] = { disable = true },
		["hrsh7th/nvim-cmp"] = { tag = "v0.0.1" },
		{
			"ellisonleao/gruvbox.nvim",
			tag = "1.0.0",
			config = function()
				require("gruvbox").setup({
					overrides = {},
				})
			end,
		},

		{ "nvim-treesitter/nvim-treesitter-context" },
		{ "tpope/vim-surround", tag = "v2.2" },
		{ "folke/trouble.nvim", ft = coding_file_types },
		{ "godlygeek/tabular" },
		{ "hrsh7th/cmp-nvim-lua" },
		{ "ray-x/cmp-treesitter" },
		-- TODO waiting on neovim 0.8
		-- {
		-- 	"smjonas/inc-rename.nvim",
		-- 	config = function()
		-- 		require("inc_rename").setup()
		-- 	end,
		-- },
		{ "nvim-neotest/neotest", ft = coding_file_types },
		{
			"phaazon/hop.nvim",
			branch = "v2",
			config = function()
				-- you can configure Hop the way you like here; see :h hop-config
				require("hop").setup({
					keys = "asdhjklxcvbnmqweriop",
				})
			end,
		},
		{
			"sindrets/diffview.nvim",
			requires = "nvim-lua/plenary.nvim",
		},
		{
			"nvim-lualine/lualine.nvim",
			requires = { "kyazdani42/nvim-web-devicons", opt = true },
			config = function()
				require("lualine").setup({
					options = {
						icons_enabled = true,
						theme = "gruvbox",
						component_separators = { left = "", right = "" },
						section_separators = { left = "", right = "" },
						disabled_filetypes = {
							statusline = {},
							winbar = {},
						},
						ignore_focus = {},
						always_divide_middle = true,
						globalstatus = false,
						refresh = {
							statusline = 1000,
							tabline = 1000,
							winbar = 1000,
						},
					},
					sections = {
						lualine_a = { "mode" },
						lualine_b = { "branch", "diff", "diagnostics" },
						lualine_c = {
							{
								"filename",
								path = 1,
								shorting_target = 80,
							},
						},
						lualine_x = { "encoding", "fileformat", "filetype" },
						lualine_y = { "progress" },
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
					tabline = {},
					winbar = {},
					inactive_winbar = {},
					extensions = {},
				})
			end,
		},
	},
	notify = {
		stages = "fade_in_slide_out",
	},
	-- All other entries override the require("<key>").setup({...}) call for default plugins
	["null-ls"] = function(config) -- overrides `require("null-ls").setup(config)`
		-- config variable is the default configuration table for the setup functino call
		local null_ls = require("null-ls")
		-- Check supported formatters and linters
		-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
		-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
		config.sources = {
			-- Set a formatter
			null_ls.builtins.formatting.stylua,
			null_ls.builtins.formatting.prettier,
		}
		-- set up null-ls's on_attach function
		-- NOTE: You can remove this on attach function to disable format on save
		config.on_attach = function(client)
			if client.resolved_capabilities.document_formatting then
				vim.api.nvim_create_autocmd("BufWritePre", {
					desc = "Auto format before save",
					pattern = "<buffer>",
					callback = vim.lsp.buf.formatting_sync,
				})
			end
		end
		return config -- return final config table to use in require("null-ls").setup(config)
	end,
	telescope = {
		defaults = {
			layout_strategy = "vertical",
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
					preview_width = 0.7,
					results_width = 0.3,
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
	},
	["neo-tree"] = {
		event_handlers = {
			{
				event = "neo_tree_buffer_enter",
				handler = function()
					vim.wo.number = true
					vim.wo.relativenumber = true
					vim.opt.winwidth = 35
				end,
			},
			{
				event = "neo_tree_buffer_leave",
				handler = function()
					local state = require("neo-tree.sources.manager").get_state("filesystem")
					local winid = state.winid
					if winid ~= nil then
						vim.api.nvim_win_set_option(winid, "number", false)
						vim.api.nvim_win_set_option(winid, "relativenumber", false)
					end
				end,
			},
		},
	},
	treesitter = { -- overrides `require("treesitter").setup(...)`
		ensure_installed = { "lua" },
	},
	-- use mason-lspconfig to configure LSP installations
	["mason-lspconfig"] = { -- overrides `require("mason-lspconfig").setup(...)`
		ensure_installed = { "sumneko_lua" },
	},
	-- use mason-tool-installer to configure DAP/Formatters/Linter installation
	["mason-tool-installer"] = { -- overrides `require("mason-tool-installer").setup(...)`
		ensure_installed = { "prettier", "stylua" },
	},
	packer = { -- overrides `require("packer").setup(...)`
		compile_path = vim.fn.stdpath("data") .. "/packer_compiled.lua",
	},
}
