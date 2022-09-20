local ls = require("luasnip")
local s = ls.snippet
-- local sn = ls.snippet_node
-- local isn = ls.indent_snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
-- local d = ls.dynamic_node
-- local r = ls.restore_node
-- local events = require("luasnip.util.events")
-- local ai = require("luasnip.nodes.absolute_indexer")
-- local fmt = require("luasnip.extras.fmt").fmt
local extras = require("luasnip.extras")
-- local m = extras.m
-- local l = extras.l
-- local rep = extras.rep
local postfix = require("luasnip.extras.postfix").postfix

local defmodule = {
	t("defmodule "),
	i(1),
	t({ "", "  " }),
	i(0),
	t({ "", "end" }),
}

local func = {
	t("def "),
	i(1),
	t("("),
	i(2),
	t({ ") do", "" }),
	t("  "),
	i(0),
	t({ "", "end" }),
}

local lsp = ls.parser.parse_snippet({ trig = "lsp" }, "$1 is ${2|hard,easy,challenging|}")

return {
	s("mod", defmodule),
	s("fn", func),
	s("df", c(1, { defmodule, func })),
	lsp,
}
