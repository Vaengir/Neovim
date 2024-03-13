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

local rec_enum
rec_enum = function()
  return sn(
    nil,
    c(1, {
      -- Order is important, sn(...) first would cause infinite loop of expansion.
      t(""),
      sn(nil, { t { "", "\t", }, i(1, "Variant()"), t { ",", }, d(2, rec_enum, {}), }),
    })
  )
end

local rec_match
rec_match = function()
  return sn(
    nil,
    c(1, {
      -- Order is important, sn(...) first would cause infinite loop of expansion.
      t(""),
      sn(nil, { t { "", "\t", }, i(1, "pattern"), t { " => ", }, i(2, "code"), t { ",", }, d(3, rec_match, {}), }),
    })
  )
end

return {
  s({ trig = "struct", name = "Struct", dscr = "Create a struct", },
    fmta(
      [[
        #[derive(Debug)]
        <>struct <> {
            <>,<>
        }
      ]],
      {
        c(1, { t { "", }, t { "pub ", }, }),
        i(2, "Name"),
        sn(3, { i(1, "field"), t { ": ", }, i(2, "field_type"), }),
        d(4, rec_struct, {}),
      }
    )
  ),

  s({ trig = "enum", name = "Enum", dscr = "Create a enum", },
    fmta(
      [[
        #[derive(Debug)]
        <>enum <> {
            <>,<>
        }
      ]],
      {
        c(1, { t { "", }, t { "pub ", }, }),
        i(2, "Name"),
        i(3, "Variant()"),
        d(4, rec_enum, {}),
      }
    )
  ),

  s({ trig = "trait", name = "Trait", dscr = "Create a trait", },
    fmta(
      [[
        <>trait <> {
            <>
        }
      ]],
      {
        c(1, { t { "", }, t { "pub ", }, }),
        i(2, "Name"),
        i(0, "Functions to implement..."),
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
        i(3),
        c(4, { t { "", }, sn(1, { t(" -> "), i(1, "return_type"), }), }),
        i(0, "todo!();"),
      }
    )
  ),

  s({ trig = "testing", name = "Testing", dscr = "Create a testing environment", },
    fmta(
      [[
        #[cfg(test)]
        mod tests {
            <>
        }
      ]],
      {
        i(0, "todo!();"),
      }
    )
  ),

  s({ trig = "test", name = "Test", dscr = "Create a test", },
    fmta(
      [[
        #[test]
        fn <>() {
            <>
        }
      ]],
      {
        i(1, "name"),
        i(0, "todo!();"),
      }
    )
  ),

  s({ trig = "main", name = "Main function", dscr = "Create the main function", },
    fmta(
      [[
        fn main() {
            <>
        }
      ]],
      {
        i(0, "todo!();"),
      }
    )
  ),

  s({ trig = "impl", name = "Implementation", dscr = "Create an implementation", },
    fmta(
      [[
        impl <><> {
            <>
        }
      ]],
      {
        c(2, { t { "", }, sn(1, { i(1, "Trait"), t { " for ", }, }), }),
        i(1, "Type"),
        i(3),
      }
    )
  ),

  s({ trig = "for", name = "For-Loop", dscr = "Create a new for loop", },
    fmta(
      [[
        for <> in <> {
            <>
        }
      ]],
      {
        i(1, "pattern"),
        i(2, "expression"),
        i(0, "todo!();"),
      }
    )
  ),

  s({ trig = "if", name = "If-condition", dscr = "Create a new if condition", },
    fmta(
      [[
        if <> {
            <>
        }
      ]],
      {
        i(1, "condition"),
        i(0, "todo!();"),
      }
    )
  ),

  s({ trig = "else", name = "Else statement", dscr = "Create a new else statement", },
    fmta(
      [[
        else {
            <>
        }
      ]],
      {
        i(0, "todo!();"),
      }
    )
  ),

  s({ trig = "match", name = "Match-expression", dscr = "Create a new match expression", },
    fmta(
      [[
        match <> {
            <> <> <>,<>
        }
      ]],
      {
        i(1, "expression"),
        i(2, "pattern"),
        t("=>"),
        i(3, "code"),
        d(4, rec_match, {}),
      }
    )
  ),

  s({ trig = "loop", name = "Loop", dscr = "Create a loop", },
    fmta(
      [[
        loop {
            <>
        }
      ]],
      {
        i(0, "todo!();"),
      }
    )
  ),

  s({ trig = "some", name = "Some", dscr = "Create a Some value", },
    fmta(
      [[
        Some(<>)
      ]],
      {
        i(1, "value"),
      }
    )
  ),

  s({ trig = "err", name = "Err", dscr = "Create a Err value", },
    fmta(
      [[
        Err(<>)
      ]],
      {
        i(1, "value"),
      }
    )
  ),

  s({ trig = "ok", name = "Ok", dscr = "Create an Ok value", },
    fmta(
      [[
        Ok(<>)
      ]],
      {
        i(1, "value"),
      }
    )
  ),

  s({ trig = "prl", name = "Println macro", dscr = "Print a line", },
    fmta(
      [[
      println!("<>")<>
    ]],
      {
        i(2),
        c(1, { t { "", }, t { ";", }, }),
      }
    )
  ),

  s({ trig = "as", name = "Assert macro", dscr = "Create an assert macro", },
    fmta(
      [[
        assert!(<>);
      ]],
      {
        i(1),
      }
    )
  ),

  s({ trig = "aseq", name = "Assert_eq macro", dscr = "Create an assert_eq macro", },
    fmta(
      [[
        assert_eq!(<>, <>);
      ]],
      {
        i(1),
        i(2),
      }
    )
  ),

  s({ trig = "asne", name = "Assert_ne macro", dscr = "Create an assert_ne macro", },
    fmta(
      [[
        assert_ne!(<>, <>);
      ]],
      {
        i(1),
        i(2),
      }
    )
  ),

  s({ trig = "vec", name = "Vec macro", dscr = "Create a vec macro", },
    fmta(
      [[
        vec![<>];
      ]],
      {
        i(1),
      }
    )
  ),

  s({ trig = "dbg", name = "Debug macro", dscr = "Create a debug macro", },
    fmta(
      [[
        dbg!(<>);
      ]],
      {
        i(1),
      }
    )
  ),

  s({ trig = "panic", name = "Panic macro", dscr = "Create a panic macro", },
    fmta(
      [[
        panic!("<>")<>
      ]],
      {
        i(2),
        c(1, { t { "", }, t { ";", }, }),
      }
    )
  ),

  s({ trig = "format", name = "Format macro", dscr = "Create a format macro", },
    fmta(
      [[
        format!("<>")<>
      ]],
      {
        i(2),
        c(1, { t { "", }, t { ";", }, }),
      }
    )
  ),

      }
    )
  ),

  s({ trig = "der", name = "Derive attribute", dscr = "Create a derive attribute", },
    fmta(
      [[
        #[derive(<>)]
      ]],
      {
        i(1, "Traits"),
      }
    )
  ),
}
