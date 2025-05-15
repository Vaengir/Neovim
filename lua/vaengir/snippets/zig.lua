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

  s({ trig = "zon", name = "build.zig.zon", dscr = "Setup the minimal build.zig.zon", },
    fmta(
      [[
        .{
            .name = .<>,
            .version = "<>",<>
            .minimum_zig_version = "<>",
            .dependencies = .{},
            .paths = .{
                "build.zig",
                "build.zig.zon",
                "src",
                "LICENSE",
                "README.md",
            },
        }
      ]],
      {
        i(1, "name"),
        i(2, "0.0.0-beta"),
        c(3, {
          t({ "", }),
          sn(nil, {
            t({ "", "    .fingerprint = ", }),
            i(1, "(To get this value leave this line empty and run zig build)"),
            t({ ",", }),
          }),
        }),
        i(4, "0.14.0"),
      }
    )
  ),

}
