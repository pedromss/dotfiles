local avail, p = pcall(require, "cmp")
local kind_avail, lspkind = pcall(require, "lspkind")
if not (avail and kind_avail) then
	return
end

print("configuring cmp")
p.setup({
	sources = p.config.sources({
		{ name = "nvim_lua" },
		{ name = "treesitter", keyword_length = 3 },
		{ name = "nvim_lsp", keyword_length = 3 },
		{ name = "luasnip" },
		{ name = "path" },
		{ name = "buffer", keyword_length = 5, max_item_count = 3 },
	}),
	formatting = {
		fields = { "abbr", "kind", "menu" },
		format = lspkind.cmp_format({
			with_text = true,
			mode = "text_symbol",
			menu = {
				nvim_lsp = "[LSP]",
				luasnip = "[snip]",
				path = "[path]",
				nvim_lua = "[api]",
				buffer = "[buf]",
			},
		}),
	},
	duplicates = {
		treesitter = 1,
		nvim_lsp = 1,
		luasnip = 1,
		cmp_tabnine = 1,
		buffer = 1,
		path = 1,
	},
})
