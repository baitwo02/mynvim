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

ls.add_snippets("typst", {
  -- 创造数学环境
	s({ trig = "mm", snippetType = "autosnippet" }, { t({ "$" }), i(1), t({ "$" }) }, {}),
  -- 分数 // -> ()/()
	s({
		trig = [[//]],
		snippetType = [[autosnippet]],
		condition = in_math,
		show_condition = in_math,
	}, fmt([[(<>)/(<>)]], { i(1), i(2) }, { delimiters = "<>" }), {}),
  -- 变量自动下标 a1 -> a_(1)
	s(
		{
			trig = [[(%a)(%d)]],
			regTrig = true,
			wordTrig = false,
			snippetType = "autosnippet",
			condition = in_math,
			show_condition = in_math,
		},
		fmt([[<>_(<>)]], {
			f(function(_, snip)
				return snip.captures[1]
			end),
			f(function(_, snip)
				return snip.captures[2]
			end),
		}, { delimiters = "<>" }),
		{}
	),
  -- 下标 abb -> a_()
	s(
		{
			trig = [[(%a*)bb]],
			regTrig = true,
			wordTrig = false,
			snippetType = [[autosnippet]],
			condition = in_math,
			show_condition = in_math,
		},
		fmt([[<>_<>]], {
			f(function(_, snip)
				return snip.captures[1]
			end),
			i(1),
		}, { delimiters = "<>" }),
		{}
	),
  -- 上标 app -> a^()
	s(
		{
			trig = [[(%a*)pp]],
			regTrig = true,
			wordTrig = false,
			snippetType = [[autosnippet]],
			condition = in_math,
			show_condition = in_math,
		},
		fmt([[<>^<>]], {
			f(function(_, snip)
				return snip.captures[1]
			end),
			i(1),
		}, { delimiters = "<>" }),
		{}
	),
  -- alpha
	s({
		trig = ";a",
		regTrig = true,
		wordTrig = false,
		snippetType = "autosnippet",
		condition = in_math,
		show_condition = in_math,
	}, fmt([[alpha]], {}, { delimiters = "<>" }), {}),
  -- beta
	s({
		trig = ";b",
		regTrig = true,
		wordTrig = false,
		snippetType = "autosnippet",
		condition = in_math,
		show_condition = in_math,
	}, fmt([[beta]], {}, { delimiters = "<>" }), {}),
  -- gamma
	s({
		trig = ";g",
		regTrig = true,
		wordTrig = false,
		snippetType = "autosnippet",
		condition = in_math,
		show_condition = in_math,
	}, fmt([[gamma]], {}, { delimiters = "<>" }), {}),
  -- mu
	s({
		trig = ";m",
		regTrig = true,
		wordTrig = false,
		snippetType = "autosnippet",
		condition = in_math,
		show_condition = in_math,
	}, fmt([[mu]], {}, { delimiters = "<>" }), {}),
  -- delta
	s({
		trig = ";d",
		regTrig = true,
		wordTrig = false,
		snippetType = "autosnippet",
		condition = in_math,
		show_condition = in_math,
	}, fmt([[delta]], {}, { delimiters = "<>" }), {}),
  -- Delta
	s({
		trig = ";D",
		regTrig = true,
		wordTrig = false,
		snippetType = "autosnippet",
		condition = in_math,
		show_condition = in_math,
	}, fmt([[Delta]], {}, { delimiters = "<>" }), {}),
  -- 括号 ;s -> ()
	s({
		trig = ";s",
		regTrig = true,
		wordTrig = false,
		snippetType = "autosnippet",
		condition = in_math,
		show_condition = in_math,
	}, fmt([[(<>)<>]], {i(1), i(0)}, { delimiters = "<>" }), {}),
  -- 箭头 to -> ->
  s(
    {
      trig = [[to]],
      snippetType = [[autosnippet]],
      condition = in_math,
      show_condition = in_math,
    },
    fmt(
      [[->]],
      {},
      { delimiters = [[{}]] }
    ),
    {}
  ),
  -- 双箭头 to -> ->
  s(
    {
      trig = [[tto]],
      snippetType = [[autosnippet]],
      condition = in_math,
      show_condition = in_math,
    },
    fmt(
      [[=>]],
      {},
      { delimiters = [[{}]] }
    ),
    {}
  ),
  -- 一级标题 ;1 -> = 
	s({
		trig = [[;1]],
		snippetType = [[autosnippet]],
	}, fmt([[= ]], {}, { delimiters = "<>" }), {}),
  -- 二级标题 ;2 -> == 
	s({
		trig = [[;2]],
		snippetType = [[autosnippet]],
	}, fmt([[== ]], {}, { delimiters = "<>" }), {}),
  -- 三级标题 ;3 -> === 
	s({
		trig = [[;3]],
		snippetType = [[autosnippet]],
	}, fmt([[=== ]], {}, { delimiters = "<>" }), {}),
  -- 四级标题 ;4 -> ==== 
	s({
		trig = [[;4]],
		snippetType = [[autosnippet]],
	}, fmt([[==== ]], {}, { delimiters = "<>" }), {}),
  -- 五级标题 ;5 -> ===== 
	s({
		trig = [[;5]],
		snippetType = [[autosnippet]],
	}, fmt([[===== ]], {}, { delimiters = "<>" }), {}),
  -- 六级标题 ;6 -> ====== 
	s({
		trig = [[;6]],
		snippetType = [[autosnippet]],
	}, fmt([[====== ]], {}, { delimiters = "<>" }), {}),
})
