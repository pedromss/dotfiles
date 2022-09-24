return {
	n = {
		["K"] = { vim.lsp.buf.hover, desc = "LSP Hover symbol details" },
		["<leader>la"] = { vim.lsp.buf.code_action, desc = "LSP code action" },
		["<leader>lf"] = { vim.lsp.buf.formatting_sync, desc = "LSP Format code" },
		["<leader>lh"] = { vim.lsp.buf.signature_help, desc = "LSP Signature help" },
		["<leader>lr"] = { vim.lsp.buf.rename, desc = "LSP Rename current symbol" },
		["gD"] = { vim.lsp.buf.declaration, desc = "LSP Declaration of current symbol" },
		["gT"] = { vim.lsp.buf.type_definition, desc = "LSP Definition of current type" },
		["gI"] = { vim.lsp.buf.implementation, desc = "LSP Implementation of current symbol" },
		["gd"] = { vim.lsp.buf.definition, desc = "LSP Show the definition of current symbol" },
		["gr"] = { vim.lsp.buf.references, desc = "LSP References of current symbol" },
		["<leader>ld"] = { vim.diagnostic.open_float, desc = "LSP Hover diagnostics" },
		["[d"] = { vim.diagnostic.goto_prev, desc = "LSP Previous diagnostic" },
		["]d"] = { vim.diagnostic.goto_next, desc = "LSP Next diagnostic" },
		["gl"] = { vim.diagnostic.open_float, desc = "LSP Hover diagnostics" },
	},
	v = {
		["<leader>la"] = { vim.lsp.buf.range_code_action, desc = "LSP Range code action" },
		["<leader>lf"] = {
			function()
				vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, true, true), "n", false)
				vim.lsp.buf.range_formatting()
			end,
			desc = "LSP Range format code",
		},
	},
}
