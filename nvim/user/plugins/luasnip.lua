local luasnip_avail, ls = pcall(require, "luasnip")
local vscode_loader_avail, vscode_loader = pcall(require, "luasnip/loaders/from_vscode")
local lua_loader_avail, lua_loader = pcall(require, "luasnip/loaders/from_lua")
if not (luasnip_avail and vscode_loader_avail and lua_loader_avail) then
	return
end

ls.filetype_extend("javascript", { "javascriptreact" })
ls.config.set_config({
	history = true,
	updateevents = "TextChanged,TextChangedI",
	enable_autosnippets = true,
})
lua_loader.lazy_load({ paths = "./lua/user/snippets" })
vscode_loader.lazy_load({ paths = "./lua/user/snippets" })

-- vim.api.nvim_set_keymap("i", "<C-n>", "<Plug>luasnip-next-choice", {})
-- vim.api.nvim_set_keymap("s", "<C-n>", "<Plug>luasnip-next-choice", {})
-- vim.api.nvim_set_keymap("i", "<C-p>", "<Plug>luasnip-prev-choice", {})
-- vim.api.nvim_set_keymap("s", "<C-p>", "<Plug>luasnip-prev-choice", {})
vim.api.nvim_set_keymap(
	"i",
	"<c-u>",
	"<cmd>lua require('luasnip.extras.select_choice')()<cr>",
	{ desc = "Popup to select through choices in luasnip snippets" }
)
