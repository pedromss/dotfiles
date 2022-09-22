local ls = require("luasnip")
local s = ls.snippet
-- local sn = ls.snippet_node
-- local isn = ls.indent_snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
-- local c = ls.choice_node
-- local d = ls.dynamic_node
-- local r = ls.restore_node
-- local events = require("luasnip.util.events")
-- local ai = require("luasnip.nodes.absolute_indexer")
-- local fmt = require("luasnip.extras.fmt").fmt
-- local extras = require("luasnip.extras")
-- local m = extras.m
-- local l = extras.l
-- local rep = extras.rep
local postfix = require("luasnip.extras.postfix").postfix
-- ls.snippets = {
-- 	lua = {
-- 		ls.parser.parse_snippet("lf", "-- Defined in $TM_MODULE\nlocal $1 = function($2)\n $0\nend"),
-- 	},
-- }
local function fn(
	args, -- text from i(2) in this example i.e. { { "456" } }
	parent, -- parent snippet or parent node
	user_args -- user_args from opts.user_args
)
	return "[" .. args[1][1] .. user_args .. "]"
end

return {
	postfix(".br", {
		f(function(_, parent)
			return "[" .. parent.snippet.env.POSTFIX_MATCH .. "]"
		end, {}),
	}),
}