-- Shorthands
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

---@return table comment_strings
local get_cstring = function()
  local ft = vim.bo.filetype
  local cstring = vim.filetype.get_option(ft, "commentstring")
  local left, right = string.match(cstring, "(.*)%%s(.*)")
  return { left, right, }
end

local marks = {
  date = function()
    return fmt("{}<{}>", { t { " ", }, i(1, os.date "%Y-%m-%d"), })
  end,
  empty = function()
    return t { "", }
  end,
}

local todo_snippet_nodes = function(aliases, opts)
  local aliases_nodes = vim.tbl_map(function(alias)
    return i(nil, alias)
  end, aliases)
  local mark_nodes = {}
  for _, mark in pairs(marks) do
    table.insert(mark_nodes, mark())
  end
  local comment_node = fmta("<> <>: <><><>", {
    f(function()
      return get_cstring()[1]
    end),
    c(1, aliases_nodes),
    i(2),
    c(3, mark_nodes),
    f(function()
      return get_cstring()[2]
    end),
  })
  return comment_node
end

---@param context table merged with the generated context table `trig` must be specified
---@param aliases string[]|string of aliases for the todo comment (ex.: {FIX, ISSUE, FIXIT, BUG})
---@param opts table merged with the snippet opts table
local todo_snippet = function(context, aliases, opts)
  opts = opts or {}
  aliases = type(aliases) == "string" and { aliases, } or aliases
  context = context or {}
  if not context.trig then
    return error("context doesn't include a `trig` key which is mandatory", 2)
  end
  opts.ctype = opts.ctype or 1
  local alias_string = table.concat(aliases, "|")
  context.name = context.name or (alias_string .. " comment")
  context.dscr = context.dscr or (alias_string .. " comment with a signature-mark")
  context.docstring = context.docstring or (" {1:" .. alias_string .. "}: {3} <{2:mark}>{0} ")
  local comment_node = todo_snippet_nodes(aliases, opts)
  return s(context, comment_node, opts)
end

local todo_snippet_specs = {
  { { trig = "todo", },  "TODO", },
  { { trig = "fix", },   { "FIX", "BUG", "ISSUE", "FIXIT", }, },
  { { trig = "hack", },  "HACK", },
  { { trig = "warn", },  { "WARN", "WARNING", "XXX", }, },
  { { trig = "perf", },  { "PERF", "PERFORMANCE", "OPTIM", "OPTIMIZE", }, },
  { { trig = "note", },  { "NOTE", "INFO", }, },
  { { trig = "test", },  { "TEST", "TESTING", "PASSED", "FAILED", }, },
  -- Block commented todo-comments
  { { trig = "todob", }, "TODO",                                          { ctype = 2, }, },
  { { trig = "fixb", },  { "FIX", "BUG", "ISSUE", "FIXIT", },             { ctype = 2, }, },
  { { trig = "hackb", }, "HACK",                                          { ctype = 2, }, },
  { { trig = "warnb", }, { "WARN", "WARNING", "XXX", },                   { ctype = 2, }, },
  { { trig = "perfb", }, { "PERF", "PERFORMANCE", "OPTIM", "OPTIMIZE", }, { ctype = 2, }, },
  { { trig = "noteb", }, { "NOTE", "INFO", },                             { ctype = 2, }, },
  { { trig = "testb", }, { "TEST", "TESTING", "PASSED", "FAILED", },      { ctype = 2, }, },
}

local todo_comment_snippets = {}
for _, v in ipairs(todo_snippet_specs) do
  table.insert(todo_comment_snippets, todo_snippet(v[1], v[2], v[3]))
end

ls.add_snippets("all", todo_comment_snippets, { type = "snippets", key = "todo_comments", })

return {
}
