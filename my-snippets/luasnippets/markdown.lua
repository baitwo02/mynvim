local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local isn = ls.indent_snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local events = require("luasnip.util.events")
local ai = require("luasnip.nodes.absolute_indexer")
local extras = require("luasnip.extras")
local l = extras.lambda
local rep = extras.rep
local p = extras.partial
local m = extras.match
local n = extras.nonempty
local dl = extras.dynamic_lambda
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local conds = require("luasnip.extras.expand_conditions")
local postfix = require("luasnip.extras.postfix").postfix
local types = require("luasnip.util.types")
local parse = require("luasnip.util.parser").parse_snippet
local ms = ls.multi_snippet
local k = require("luasnip.nodes.key_indexer").new_key

local function is_inline_math()
	local prev_flag = 0
	local next_flag = 0
	local line = vim.api.nvim_get_current_line()
	local cur_col = vim.fn.col(".")

	for pre = cur_col - 1, 1, -1 do
		local prev_char = line:sub(pre, pre)
		if prev_char == "$" then
			prev_flag = 1
			for aft = cur_col, #line, 1 do
				local next_char = line:sub(aft, aft)
				if next_char == "$" then
					next_flag = 1
					break
				end
			end
			break
		end
	end

	return not ((prev_flag and next_flag) == 0)
end

local function is_multiline_math()
	local lines = vim.fn.getbufline(".", 1, "$")
	local cursor_row = vim.fn.line(".")
	local prev_flag = 0
	local next_flag = 0

	for pre = cursor_row - 1, 1, -1 do
		local pre_line = lines[pre]
		local prev_char = pre_line:sub(1, 1)
		if #pre_line == 0 then
			return false
		elseif prev_char == "$" then
			prev_flag = 1
			for aft = cursor_row + 1, #lines, 1 do
				local next_line = lines[aft]
				local next_char = pre_line:sub(1, 1)
				if #next_line == 0 then
					return false
				elseif next_char == "$" then
					next_flag = 1
					break
				end
			end
			break
		end
	end

	return not ((prev_flag and next_flag) == 0)
end

local function in_math()
	return is_inline_math() or is_multiline_math()
end

local in_mathzone = function()
	return vim.fn["vimtex#syntax#in_mathzone"]() == 1
end

ls.add_snippets("all", {
	s({ trig = "sm", snippetType = "autosnippet" }, { t({ "$" }), i(1), t({ "$" }) }, {}),
	s({ trig = "mm", snippetType = "autosnippet" }, { t({ "$$" }), i(1), t({ "$$" }) }, {}),
	s({
		trig = [[//]],
		snippetType = [[autosnippet]],
		condition = in_math,
		show_condition = in_math,
	}, fmt([[\frac{<>}{<>}]], { i(1, "分子"), i(2, "分母") }, { delimiters = "<>" }), {}),
	s(
		{
			trig = [[(%a)(%d)]],
			regTrig = true,
			wordTrig = false,
			snippetType = "autosnippet",
			condition = in_math,
			show_condition = in_math,
		},
		fmt([[<>_{<>}]], {
			f(function(_, snip)
				return snip.captures[1]
			end),
			f(function(_, snip)
				return snip.captures[2]
			end),
		}, { delimiters = "<>" }),
		{}
	),
	s(
		{
			trig = [[(%a*)bb]],
			regTrig = true,
			wordTrig = false,
			snippetType = [[autosnippet]],
			condition = in_math,
			show_condition = in_math,
		},
		fmt([[<>_{<>}]], {
			f(function(_, snip)
				return snip.captures[1]
			end),
			i(1),
		}, { delimiters = "<>" }),
		{}
	),
	s(
		{
			trig = [[(%a*)pp]],
			regTrig = true,
			wordTrig = false,
			snippetType = [[autosnippet]],
			condition = in_math,
			show_condition = in_math,
		},
		fmt([[<>^{<>}]], {
			f(function(_, snip)
				return snip.captures[1]
			end),
			i(1),
		}, { delimiters = "<>" }),
		{}
	),
	s({
		trig = ";a",
		regTrig = true,
		wordTrig = false,
		snippetType = "autosnippet",
		condition = in_math,
		show_condition = in_math,
	}, fmt([[\alpha]], {}, { delimiters = "<>" }), {}),
	s({
		trig = ";b",
		regTrig = true,
		wordTrig = false,
		snippetType = "autosnippet",
		condition = in_math,
		show_condition = in_math,
	}, fmt([[\beta]], {}, { delimiters = "<>" }), {}),
	s({
		trig = ";g",
		regTrig = true,
		wordTrig = false,
		snippetType = "autosnippet",
		condition = in_math,
		show_condition = in_math,
	}, fmt([[\gamma]], {}, { delimiters = "<>" }), {}),
	s({
		trig = ";m",
		regTrig = true,
		wordTrig = false,
		snippetType = "autosnippet",
		condition = in_math,
		show_condition = in_math,
	}, fmt([[\mu]], {}, { delimiters = "<>" }), {}),
	s({
		trig = [[;1]],
		snippetType = [[autosnippet]],
	}, fmt([[# ]], {}, { delimiters = "<>" }), {}),
	s({
		trig = [[;2]],
		snippetType = [[autosnippet]],
	}, fmt([[## ]], {}, { delimiters = "<>" }), {}),
	s({
		trig = [[;3]],
		snippetType = [[autosnippet]],
	}, fmt([[### ]], {}, { delimiters = "<>" }), {}),
	s({
		trig = [[;4]],
		snippetType = [[autosnippet]],
	}, fmt([[#### ]], {}, { delimiters = "<>" }), {}),
	s({
		trig = [[;5]],
		snippetType = [[autosnippet]],
	}, fmt([[##### ]], {}, { delimiters = "<>" }), {}),
	s({
		trig = [[;6]],
		snippetType = [[autosnippet]],
	}, fmt([[###### ]], {}, { delimiters = "<>" }), {}),
	s(
		{
			trig = [[(%a*)bb]],
			regTrig = true,
			wordTrig = false,
		},
		fmt([[<><><><>]], {
			f(function(_, snip)
				return snip.captures[1]
			end),
			t([[<sub>]]),
			i(1),
			t([[</sub>]]),
		}, { delimiters = "<>" }),
		{}
	),
	s(
		{
			trig = [[(%a*)pp]],
			regTrig = true,
			wordTrig = false,
		},
		fmt([[<><><><>]], {
			f(function(_, snip)
				return snip.captures[1]
			end),
			t([[<sup>]]),
			i(1),
			t([[</sup>]]),
		}, { delimiters = "<>" }),
		{}
	),
})
