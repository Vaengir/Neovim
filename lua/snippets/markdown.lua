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

local rec_tag
rec_tag = function()
  return sn(
    nil,
    c(1, {
      -- Order is important, sn(...) first would cause infinite loop of expansion.
      t(""),
      sn(nil, { t({ ", ", }), i(1, "Tag goes here..."), d(2, rec_tag, {}), }),
    })
  )
end

local rec_todo
rec_todo = function()
  return sn(
    nil,
    c(1, {
      -- Order is important, sn(...) first would cause infinite loop of expansion.
      t(""),
      sn(nil, { t({ "", "- [ ] ", }), i(1, "TODO goes here..."), d(2, rec_todo, {}), }),
    })
  )
end

return {
  s({ trig = "pm", name = "Privat Merken", dscr = "Tags for Private, Merken, Custom", },
    fmta(
      [[
        private, merken, <><>
      ]],
      {
        i(1, "Custom tags go here..."),
        d(2, rec_tag, {}),
      }
    )
  ),

  s({ trig = "pt", name = "Privat TODO", dscr = "Tags for Private, TODOs", },
    fmta(
      [[
        private, todos
      ]],
      {
      }
    )
  ),

  s({ trig = "wm", name = "Work Merken", dscr = "Tags for Work, Merken, Custom", },
    fmta(
      [[
        work, merken, <><>
      ]],
      {
        i(1, "Custom tags go here..."),
        d(2, rec_tag, {}),
      }
    )
  ),

  s({ trig = "wt", name = "Work TODO", dscr = "Tags for Work, TODOs", },
    fmta(
      [[
        work, todos
      ]],
      {
      }
    )
  ),

  s({ trig = "prog", name = "Programming", dscr = "Tags for Programming", },
    fmta(
      [[
        Programming, <><>
      ]],
      {
        i(1, "Custom tags go here..."),
        d(2, rec_tag, {}),
      }
    )
  ),

  s({ trig = "daily", name = "Daily Note", dscr = "Tags for Daily Notes", },
    fmta(
      [[
        daily, <>
      ]],
      {
        p(os.date, "%Y-%m-%d"),
      }
    )
  ),

  s({ trig = "tl", name = "TODO List", dscr = "Create a TODO List", },
    fmta(
      [[
        - [ ] <><>
      ]],
      {
        i(1, "TODO goes here..."),
        d(2, rec_todo, {}),
      }
    )
  ),

  s({ trig = "code", name = "Code block", dscr = "Create a code block", },
    fmta(
      [[
        ```<>
        <>
        ```
      ]],
      {
        i(1, "Language"),
        i(2, "Code goes here..."),
      }
    )
  ),
}
