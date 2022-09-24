return {
	default_component_configs = {
		git_status = {
			symbols = {
				added = "",
				deleted = "",
				modified = "",
				renamed = "➜",
				untracked = "★",
				ignored = "◌",
				unstaged = "✗",
				staged = "✓",
				conflict = "",
			},
		},
		indent = {
			padding = 0,
			with_expanders = false,
		},
	},
	window = {
		width = 35,
	},
	event_handlers = {
		-- {
		-- 	event = "neo_tree_buffer_enter",
		-- 	handler = function()
		-- 		vim.wo.number = true
		-- 		vim.wo.relativenumber = true
		-- 		vim.opt_local.signcolumn = "auto"
		-- 	end,
		-- },
		-- {
		-- 	event = "neo_tree_buffer_leave",
		-- 	handler = function()
		-- 		local state = require("neo-tree.sources.manager").get_state("filesystem")
		-- 		local winid = state.winid
		-- 		if winid ~= nil then
		-- 			vim.api.nvim_win_set_option(winid, "number", false)
		-- 			vim.api.nvim_win_set_option(winid, "relativenumber", false)
		-- 		end
		-- 	end,
		-- },
	},
}
