return {
	n = {
		["<leader>bg"] = { ":ToggleBackground<cr>", desc = "Toggle background color" },
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
		["<leader><leader>e"] = {
			":tabnew ~/.config/nvim/lua/user/init.lua<cr>",
			desc = "Edit config file in new tab",
		},
		["<leader><leader>i"] = {
			":source ~/.config/nvim/lua/user/init.lua<cr>",
			desc = "Reload the configuration",
		},
		["<leader><leader>l"] = {
			":source ~/.config/nvim/lua/user/plugins/luasnip.lua<cr>",
			desc = "Reload snippets",
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
}
