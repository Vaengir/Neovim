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

local rec_struct
rec_struct = function()
  return sn(
    nil,
    c(1, {
      -- Order is important, sn(...) first would cause infinite loop of expansion.
      t(""),
      sn(nil, { t { "", "\t", }, i(1, "field"), t { ": ", }, i(2, "field_type"), t { ",", }, d(3, rec_struct, {}), }),
    })
  )
end

ls.add_snippets("rust", {

  s({ trig = "struct", name = "Struct", dscr = "Create a struct", },
    fmta(
      [[
        <>struct <> {
          <>,<>
        }
      ]],
      {
        c(1, { t { "", }, t { "pub ", }, }),
        i(2, "Name"),
        sn(3, { i(1, "field"), t { ": ", }, i(2, "field_type"), }),
        d(4, rec_struct),
      }
    )
  ),

  s({ trig = "fn", name = "Function", dscr = "Create a new function", },
    fmta(
      [[
        <>fn <>(<>)<> {
          <>
        }
      ]],
      {
        c(1, { t { "", }, t { "pub ", }, }),
        i(2, "name"),
        c(3, { t { "", }, i(1, "parameter: type"), }),
        c(4, { t { "", }, sn(1, { t(" -> "), i(1, "return_type"), }), }),
        i(0, "Body of the function goes here..."),
      }
    )
  ),

  s({ trig = "prl", name = "println!", dscr = "Print a line", },
    fmta(
      [[
      println!("<>")<>
    ]],
      {
        i(1),
        c(2, { t { "", }, t { ";", }, }),
      }
    )
  ),

})
