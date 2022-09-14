-- vim foldmethod=indent
local cmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

local function is_available(plugin)
	return packer_plugins ~= nil and packer_plugins[plugin] ~= nil
end

local config = {
	updater = {
		remote = "origin", -- remote to use
		channel = "nightly", -- "stable" or "nightly"
		version = "latest", -- "latest", tag name, or regex search like "v1.*" to only do updates before v2 (STABLE ONLY)
		branch = "main", -- branch name (NIGHTLY ONLY)
		commit = nil, -- commit hash (NIGHTLY ONLY)
		pin_plugins = nil, -- nil, true, false (nil will pin plugins on stable only)
		skip_prompts = false, -- skip prompts about breaking changes
		show_changelog = true, -- show the changelog after performing an update
		auto_reload = false, -- automatically reload and sync packer after a successful update
		auto_quit = false, -- automatically quit the current session after a successful update
		-- remotes = { -- easily add new remotes to track
		--   ["remote_name"] = "https://remote_url.come/repo.git", -- full remote url
		--   ["remote2"] = "github_user/repo", -- GitHub user/repo shortcut,
		--   ["remote3"] = "github_user", -- GitHub user assume AstroNvim fork
		-- },
	},

	-- Set colorscheme to use
	colorscheme = "gruvbox",

	-- Override highlight groups in any theme
	highlights = {
		-- duskfox = { -- a table of overrides/changes to the default
		--   Normal = { bg = "#000000" },
		-- },
		default_theme = function(highlights) -- or a function that returns a new table of colors to set
			local C = require("default_theme.colors")
			highlights.Normal = { fg = C.fg, bg = C.bg }
			return highlights
		end,
	},

	-- set vim options here (vim.<first_key>.<second_key> =  value)
	options = {
		opt = {
			background = "dark",
			relativenumber = true, -- sets vim.opt.relativenumber
		},
		g = {
			mapleader = ",", -- sets vim.g.mapleader
			localleader = "\\",
			laststatus = 3,
		},
	},
	-- If you need more control, you can use the function()...end notation
	-- options = function(local_vim)
	--   local_vim.opt.relativenumber = true
	--   local_vim.g.mapleader = " "
	--   local_vim.opt.whichwrap = vim.opt.whichwrap - { 'b', 's' } -- removing option from list
	--   local_vim.opt.shortmess = vim.opt.shortmess + { I = true } -- add to option list
	--
	--   return local_vim
	-- end,

	-- Set dashboard header
	header = {
		"    ███    ██ ██    ██ ██ ███    ███",
		"    ████   ██ ██    ██ ██ ████  ████",
		"    ██ ██  ██ ██    ██ ██ ██ ████ ██",
		"    ██  ██ ██  ██  ██  ██ ██  ██  ██",
		"    ██   ████   ████   ██ ██      ██",
	},

	-- Default theme configuration
	default_theme = {
		-- set the highlight style for diagnostic messages
		diagnostics_style = { italic = true },
		-- Modify the color palette for the default theme
		colors = {
			fg = "#abb2bf",
			bg = "#1e222a",
		},
		-- enable or disable highlighting for extra plugins
		plugins = {
			aerial = true,
			beacon = false,
			bufferline = true,
			dashboard = true,
			highlighturl = true,
			hop = false,
			indent_blankline = true,
			lightspeed = false,
			["neo-tree"] = true,
			notify = true,
			["nvim-tree"] = false,
			["nvim-web-devicons"] = true,
			rainbow = true,
			symbols_outline = false,
			telescope = true,
			vimwiki = false,
			["which-key"] = true,
		},
	},

	-- Diagnostics configuration (for vim.diagnostics.config({...}))
	diagnostics = {
		virtual_text = true,
		underline = true,
	},

	-- Extend LSP configuration
	lsp = {
		-- enable servers that you already have installed without mason
		servers = {
			-- "pyright"
		},
		-- easily add or disable built in mappings added during LSP attaching
		mappings = {
			n = {
				-- ["<leader>lf"] = false -- disable formatting keymap
			},
		},
		-- add to the global LSP on_attach function
		-- on_attach = function(client, bufnr)
		-- end,

		-- override the mason server-registration function
		-- server_registration = function(server, opts)
		--   require("lspconfig")[server].setup(opts)
		-- end,

		-- Add overrides for LSP server settings, the keys are the name of the server
		["server-settings"] = {
			-- example for addings schemas to yamlls
			-- yamlls = { -- override table for require("lspconfig").yamlls.setup({...})
			--   settings = {
			--     yaml = {
			--       schemas = {
			--         ["http://json.schemastore.org/github-workflow"] = ".github/workflows/*.{yml,yaml}",
			--         ["http://json.schemastore.org/github-action"] = ".github/action.{yml,yaml}",
			--         ["http://json.schemastore.org/ansible-stable-2.9"] = "roles/tasks/*.{yml,yaml}",
			--       },
			--     },
			--   },
			-- },
			-- Example disabling formatting for a specific language server
			-- gopls = { -- override table for require("lspconfig").gopls.setup({...})
			--   on_attach = function(client, bufnr)
			--     client.resolved_capabilities.document_formatting = false
			--   end
			-- }
		},
	},

	-- Mapping data with "desc" stored directly by vim.keymap.set().
	--
	-- Please use this mappings table to set keyboard mapping since this is the
	-- lower level configuration and more robust one. (which-key will
	-- automatically pick-up stored data by this setting.)
	mappings = {
		-- first key is the mode
		n = {
			["<localleader>aa"] = {
				":AerialToggle<cr>",
				desc = "Toggle Aerial and jump to it",
			},
			["<localleader>nf"] = { ":set nofoldenable!<cr>", desc = "toggle folds" },
			-- Substitute
			["<leader>r"] = { ':exe "%s/" . expand("<cword>") . "/', desc = "Substitute operator" },
			-- Telescope
			["<localleader>fw"] = { "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Find in current buffer" },
			["<localleader>fb"] = { "<cmd>Telescope builtin<cr>", desc = "Telescope builtin" },
			["<leader>fe"] = { "<cmd>Telescope oldfiles<cr>", desc = "Old files" },
			["<leader>fg"] = { "<cmd>Telescope live_grep<cr>", desc = "Old files" },
			-- mappings seen under group name "Buffer"
			["<leader>bb"] = { "<cmd>tabnew<cr>", desc = "New tab" },
			["<leader>bc"] = { "<cmd>BufferLinePickClose<cr>", desc = "Pick to close" },
			["<leader>bj"] = { "<cmd>BufferLinePick<cr>", desc = "Pick to jump" },
			["<leader>bt"] = { "<cmd>BufferLineSortByTabs<cr>", desc = "Sort by tabs" },
			["<leader>bp"] = { "<cmd>BufferLineTogglePin<cr>", desc = "Pin tab" },
			["T"] = { ":tabclose<cr> ", desc = "Close tab" },
			["<esc>"] = { ":noh<cr>:mat none<cr>", desc = "Clear searches and highlights and ESC" },
			-- Hop
			["<localleader>lw"] = { "<cmd>lua require'hop'.hint_words()<cr>", desc = "Hop Word in the current buffer" },
			["<localleader>lW"] = {
				"<cmd>lua require'hop'.hint_words({multi_windows = true})<cr>",
				desc = "Hop Word in the current buffer",
			},
			["<localleader>lp"] = {
				"<cmd>lua require'hop'.hint_patterns()<cr>",
				desc = "Hop pattern in current window",
			},
			["<localleader>lP"] = {
				"<cmd>lua require'hop'.hint_patterns({multi_windows = true})<cr>",
				desc = "Hop pattern in all windows",
			},
			["<localleader>ll"] = {
				"<cmd>lua require'hop'.hint_words({current_line_only = true})<cr>",
				desc = "Hop Word in the current line",
			},
			-- Config management
			["<localleader>ec"] = {
				":tabnew ~/.config/nvim/lua/user/init.lua<cr>",
				desc = "Edit config file in new tab",
			},
			["<localleader>si"] = {
				":source ~/.config/nvim/lua/user/init.lua<cr>",
				desc = "Edit config file in new tab",
			},
			-- tabs
			["<localleader>tt"] = { ":tabn", desc = "Go to tab" },
			-- Avoiding CTRL mappings
			-- Wrist and stuff
			["<localleader>nn"] = { ":file!<cr>", desc = "Show current file name" },
			["<localleader>fn"] = { ":Format<cr>", desc = "Format the current file" },
		},
		t = {
			-- setting a mapping to false will disable it
			-- ["<esc>"] = false,
		},
		i = {
			-- motion
			["jI"] = { "<esc>^i", desc = "Move to beginning of line in insert mode" },
			["jA"] = { "<esc>g_a", desc = "Move to end of line in insert mode" },
			["jW"] = { "<esc>wa", desc = "Perform a 'w' motion in insert" },
			["jE"] = { "<esc>ea", desc = "Perform a 'e' motion in insert" },
			["jn"] = { "<esc>o", desc = "In insert mode, move to a new line below" },
			["jO"] = { "<esc>O", desc = "In insert mode, move to a new line above" },
			["jK"] = { "<esc>:m-2<cr>i", desc = "Move the current line up, stay in insert" },
			["jJ"] = { "<esc>:m+1<cr>i", desc = "Move the current line down, stay in insert" },
			["jU"] = { "<esc>ui", desc = "Undo, stay in insert" },
			["jk"] = { "<esc>l", desc = "Quit insert, stay on the same position" },
			["jF)"] = { "<esc>f)i", desc = "Move to the next ')'" },
			["jF}"] = { "<esc>f}i", desc = "Move to the next '}'" },
			["jF,"] = { "<esc>f,i", desc = "Move to the next ','" },
			["jB("] = { "<esc>F(i", desc = "Move to the previous '('" },
			["jB}"] = { "<esc>F}i", desc = "Move to the previous '}'" },
			["jB,"] = { "<esc>F,i", desc = "Move to the previous ','" },
			-- folding
			["<localleader>nf"] = { ":set nofoldenable!<cr>", desc = "disable folds" },
			["<localleader>fi"] = { ":set foldmethod=indent<cr>", desc = "Fold on indent" },
			["<localleader>fm"] = { ":set foldmethod=manual<cr>", desc = "Fold manually" },
			["<localleader>fs"] = { ":set foldmethod=syntax<cr>", desc = "Fold on syntax" },
			-- pasting
			["jp"] = { "<esc>pa", desc = "Paste and remain in insert mode" },
			["jP"] = { "<esc>Pa", desc = "Paste backwards and remain in insert mode" },
		},
	},

	-- Configure plugins
	plugins = {
		init = {
			["feline-nvim/feline.nvim"] = { disable = true },
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
			{ "godlygeek/tabular" },
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
			{ "sindrets/diffview.nvim", requires = "nvim-lua/plenary.nvim" },
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
						width = 0.9,
						previewer = true,
						preview_cutoff = 1,
						results_height = 0.4,
						preview_height = 0.6,
						prompt_location = "top",
					},
					horizontal = {
						width = 0.9,
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
	},

	-- LuaSnip Options
	luasnip = {
		-- Add paths for including more VS Code style snippets in luasnip
		vscode_snippet_paths = "~/dotfiles/nvim/snippets",
		-- Extend filetypes
		filetype_extend = {
			javascript = { "javascriptreact" },
		},
	},

	-- CMP Source Priorities
	-- modify here the priorities of default cmp sources
	-- higher value == higher priority
	-- The value can also be set to a boolean for disabling default sources:
	-- false == disabled
	-- true == 1000
	cmp = {
		source_priority = {
			nvim_lsp = 1000,
			luasnip = 750,
			buffer = 500,
			path = 250,
		},
	},

	-- Modify which-key registration (Use this with mappings table in the above.)
	["which-key"] = {
		-- Add bindings which show up as group name
		register_mappings = {
			-- first key is the mode, n == normal mode
			n = {
				-- second key is the prefix, <leader> prefixes
				["<leader>"] = {
					-- third key is the key to bring up next level and its displayed
					-- group name in which-key top level menu
					["b"] = { name = "Buffer" },
				},
			},
		},
	},

	-- This function is run last and is a good place to configuring
	-- augroups/autocommands and custom filetypes also this just pure lua so
	-- anything that doesn't fit in the normal config locations above can go here
	polish = function()
		-- Set key binding
		-- Set autocommands
		augroup("packer_conf", { clear = true })
		cmd("BufWritePost", {
			desc = "Sync packer after modifying plugins.lua",
			group = "packer_conf",
			pattern = "plugins.lua",
			command = "source <afile> | PackerSync",
		})
		-- augroup("all", { clear = true })
		-- cmd("BufEnter", {
		-- 	desc = "Aerial collapse level",
		-- 	group = "all",
		-- 	pattern = { "*" },
		-- 	callback = "AerialTreeSetCollapseLevel 1",
		-- })

		augroup("elixir_ext", { clear = true })
		cmd("BufWritePre", {
			desc = "Format on save",
			group = "elixir_ext",
			pattern = { "*.ex", "*.exs" },
			callback = function()
				vim.cmd(":Format")
			end,
		})
		cmd("BufAdd", {
			desc = "Set foldmethod",
			group = "elixir_ext",
			pattern = { "*.ex", "*.exs" },
			callback = function()
				vim.cmd(":set fdm=indent")
				vim.cmd(":set foldlevel=1")
				vim.cmd(":set wrap")
			end,
		})

		augroup("aerial_ext", { clear = true })
		cmd("BufAdd", {
			desc = "Set collapse level",
			group = "aerial_ext",
			pattern = { "*.aerial" },
			callback = function()
				vim.cmd(":AerialTreeSetCollapseLevel 1")
			end,
		})

		vim.api.nvim_create_user_command("Scratch", require("user/scratch").makeScratch, {})
		require("lualine").setup({
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
		require("hop").setup()
	end,
}

return config
