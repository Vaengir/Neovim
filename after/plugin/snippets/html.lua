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

ls.add_snippets("html", {

  s({ trig = "doc", name = "Doctype", dscr = "Create DOCTYPE statement", }, {
    t("<!DOCTYPE html>"),
  }),

  s({ trig = "html", name = "HTML", dscr = "Create minimal HTML document", },
    fmt(
      [[
        <!DOCTYPE html>
        <html lang='{}'>

        <head>
          <title>{}</title>
          <meta charset='utf-8'>
        </head>

        <body>
          {}
        </body>

        </html>
      ]],
      {
        i(1, "de"),
        i(2, "Title"),
        i(0, "Body goes here..."),
      }
    )
  ),

  s({ trig = "h1", name = "Heading 1", dscr = "Create a heading 1", },
    fmt(
      [[
        <h1>{}</h1>
      ]],
      {
        i(1, "Heading goes here..."),
      }
    )
  ),

})
