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

return {
  s({ trig = "fe", name = "feat", dscr = "A new feature", },
    fmta(
      [[
        feat: <>

        <>
      ]],
      {
        i(1, "Title"),
        i(0, "Description"),
      }
    )
  ),

  s({ trig = "fi", name = "fix", dscr = "A bug fix", },
    fmta(
      [[
      fix: <>

      <>
    ]],
      {
        i(1, "Title"),
        i(0, "Description"),
      }
    )
  ),

  s({ trig = "do", name = "docs", dscr = "Documentation only changes", },
    fmta(
      [[
      docs: <>

      <>
    ]],
      {
        i(1, "Title"),
        i(0, "Description"),
      }
    )
  ),

  s({ trig = "st", name = "style", dscr = "Changes that do not affect the meaning of the code", },
    fmta(
      [[
        style: <>

        <>
      ]],
      {
        i(1, "Title"),
        i(0, "Description"),
      }
    )
  ),

  s({ trig = "re", name = "refactor", dscr = "A code change that neither fixes a bug nor adds a feature", },
    fmta(
      [[
        refactor: <>

        <>
      ]],
      {
        i(1, "Title"),
        i(0, "Description"),
      }
    )
  ),

  s({ trig = "pe", name = "perf", dscr = "A code change that improves performace", },
    fmta(
      [[
        perf: <>

        <>
      ]],
      {
        i(1, "Title"),
        i(0, "Description"),
      }
    )
  ),

  s({ trig = "te", name = "test", dscr = "Adding missing tests", },
    fmta(
      [[
        test: <>

        <>
      ]],
      {
        i(1, "Title"),
        i(0, "Description"),
      }
    )
  ),

  s({ trig = "ch", name = "chore", dscr = "Changes to the build process or auxiliary tools and libraries such as documentation", },
    fmta(
      [[
        chore: <>

        <>
      ]],
      {
        i(1, "Title"),
        i(0, "Description"),
      }
    )
  ),

  s({ trig = "nvim", name = "Neovim Update", dscr = "The Neovim submodule was updated", },
    t "Neovim update"
  ),

  s({ trig = "plug", name = "Plugin Update", dscr = "The Neovim lazy-lock.json was updated", },
    t "Plugin update"
  ),

  s({ trig = "awe", name = "AwesomeWM Update", dscr = "The AwesomeWM submodule was updated", },
    t "AwesomeWM update"
  ),
}
