local M = {}

local dark = "#282828"
local light = "#fbf1c7"

local colors = {
	dark = {
		-- { bg = "#282828", fg = "#8ec07c", extras = "", group = "SignColumn" },
		-- { bg = "#282828", fg = "#8ec07c", extras = "", group = "GitGutterChange" },
		-- { bg = "#282828", fg = "#8ec07c", extras = "", group = "GitGutterDelete" },
		-- { bg = "#282828", fg = "#8ec07c", extras = "", group = "GitGutterAdd" },
		-- { bg = "#282828", fg = "#8ec07c", extras = "", group = "GitGutterChangeDelete" },
	},
	light = {
		-- { bg = "#fbf1c7", fg = "#3a6c4d", extras = " cterm=bold gui=bold", group = "SignColumn" },
		-- { bg = "#fbf1c7", fg = "#3a6c4d", extras = " cterm=bold gui=bold", group = "GitGutterChange" },
		-- { bg = "#fbf1c7", fg = "#3a6c4d", extras = " cterm=bold gui=bold", group = "GitGutterDelete" },
		-- { bg = "#fbf1c7", fg = "#3a6c4d", extras = " cterm=bold gui=bold", group = "GitGutterAdd" },
		-- { bg = "#fbf1c7", fg = "#3a6c4d", extras = " cterm=bold gui=bold", group = "GitGutterChangeDelete" },
	},
}

function M.toggle_background()
	local bg = "dark"
	if vim.opt.background:get() == bg then
		bg = "light"
	end
	vim.cmd(":set background=" .. bg)
	for _, spec in ipairs(colors[bg]) do
		vim.cmd(":hi " .. spec.group .. " guibg=" .. spec.bg .. " guifg=" .. spec.fg .. spec.extras)
	end
end

function M.setup()
	vim.cmd("command! ToggleBackground lua require'user.colors'.toggle_background()")
end

return M
