local avail, p = pcall(require, "cmp")
local kind_avail, lspkind = pcall(require, "lspkind")
if not (avail and kind_avail) then
	return
end

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
	mapping = {
		["<Up>"] = p.mapping.select_prev_item(),
		["<Down>"] = p.mapping.select_next_item(),
		["<C-p>"] = p.mapping.select_prev_item(),
		["<C-n>"] = p.mapping.select_next_item(),
		["<C-k>"] = p.mapping.select_prev_item(),
		["<C-j>"] = p.mapping.select_next_item(),
		["<C-d>"] = p.mapping(p.mapping.scroll_docs(-1), { "i", "c" }),
		["<C-f>"] = p.mapping(p.mapping.scroll_docs(1), { "i", "c" }),
		["<C-Space>"] = p.mapping(p.mapping.complete(), { "i", "c" }),
		["<C-y>"] = p.config.disable,
		["<C-e>"] = p.mapping({
			i = p.mapping.abort(),
			c = p.mapping.close(),
		}),
		["<CR>"] = p.mapping.confirm({ select = false }),
		["<Tab>"] = p.mapping(function(fallback)
			if p.visible() then
				p.select_next_item()
			elseif luasnip.expandable() then
				luasnip.expand()
			elseif luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			elseif has_words_before() then
				p.complete()
			else
				fallback()
			end
		end, {
			"i",
			"s",
		}),
		["<S-Tab>"] = p.mapping(function(fallback)
			if p.visible() then
				p.select_prev_item()
			elseif luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, {
			"i",
			"s",
		}),
	},
})
