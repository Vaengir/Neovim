local status_ok, luasnip = pcall(require, "luasnip")
if not status_ok then
  return
end

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

-- Options
ls.setup({
  history = true,
  -- Update more often, :h events for more info.
  update_events = "TextChanged,TextChangedI",
  -- Snippets aren't automatically removed if their text is deleted.
  -- `delete_check_events` determines on which events (:h events) a check for
  -- deleted snippets is performed.
  -- This can be especially useful when `history` is enabled.
  delete_check_events = "TextChanged",
  ext_opts = {
    [types.choiceNode] = {
      active = {
        virt_text = { { "choiceNode", "Comment", }, },
      },
    },
  },
  -- treesitter-hl has 100, use something higher (default is 200).
  ext_base_prio = 300,
  -- minimal increase in priority.
  ext_prio_increase = 1,
  enable_autosnippets = true,
  -- mapping for cutting selected text so it's usable as SELECT_DEDENT,
  -- SELECT_RAW or TM_SELECTED_TEXT (mapped via xmap).
  store_selection_keys = "<Tab>",
  -- luasnip uses this function to get the currently active filetype. This
  -- is the (rather uninteresting) default, but it's possible to use
  -- eg. treesitter for getting the current filetype by setting ft_func to
  -- require("luasnip.extras.filetype_functions").from_cursor (requires
  -- `nvim-treesitter/nvim-treesitter`). This allows correctly resolving
  -- the current filetype in eg. a markdown-code block or `vim.cmd()`.
  ft_func = function()
    return vim.split(vim.bo.filetype, ".", true)
  end,
})

-- Snippets
-- For all files
ls.add_snippets("all", {
})

-- End all files

-- for lua files

ls.add_snippets("lua", {

  s({ trig = "snip", name = "snippet", dscr = "create a new snippet", },
    fmta(
      [[
        s({ trig = "<>", name = "<>", dscr = "<>", },
          fmta(
            <>
              <>
            <>
            {
              <>
            }
          )
        ),
      ]],
      {
        i(1),
        i(2),
        i(3),
        t("[["),
        i(4),
        t("]],"),
        i(5),
      }
    )
  ),

})

-- end lua files

-- For Tex files
ls.add_snippets("tex", {

  s({ trig = "fig", name = "Figure", dscr = "Create figure template", },
    fmta(
      [[
        \begin{figure}[htb]
          \centering
          \includesgraphics[<><>]{<>}
          \caption[<>]{<> \footnotemark}
          \label{abb: <>}
        \end{figure}
        \footnotetext{<> \cite{<>}}
      ]],
      {
        c(1, { t { "width=", }, t { "height=", }, }),
        i(2),
        i(3),
        i(4),
        rep(4),
        i(5),
        c(6, { t { "Enthalten in: ", }, t { "Mit Änderungen entnommen aus: ", }, }),
        i(7),
      }
    )
  ),

  s({ trig = "fc", name = "Footcite", dscr = "Snippet to cite with footnote in one", },
    fmta(
      [[
        \footcite[<>][<>]{<>}
      ]],
      {
        c(1, { t { "", }, t { "Vgl. ", }, }),
        c(2, { t { "", }, sn(nil,
          fmta("S. <><>",
            {
              i(1),
              c(2, { t { "", }, t { " auch im Folgenden", }, }),
            }
          )
        ),
        }),
        i(3),
      }
    )
  ),

  s({ trig = "al", name = "Anführungszeichen links", dscr = "Deutsche Anführungszeichen links für Zitate beispielsweise", },
    {
      t({ "\\glqq ", }),
    }
  ),

  s({ trig = "ar", name = "Anführungszeichen rechts", dscr = "Deutsche Anführungszeichen rechts für Zitate beispielsweise", },
    {
      c(1, { t { "\\grqq ", }, t { "\\grqq{} ", }, }),
    }
  ),

})

-- End Tex files

-- HTML files

ls.add_snippets("html", {

  s({ trig = "gprop", name = "JSPgetProperty", dscr = "Inserts the jsp getProperty tag", },
    fmt(
      [[
        <jsp:getProperty name='form' property='{}' />
      ]],
      {
        i(1),
      }
    )
  ),

})

-- End HTML files

-- Svelte files

ls.add_snippets("svelte", {

  s("script", {
    t({ "<script lang='ts'>", "  ", }),
    i(0),
    t({ "", "</script>", }),
  }),

})

-- End Svelte files

-- Keymaps
vim.keymap.set({ "i", "s", }, "<c-k>", function()
  if ls.expand_or_jumpable() then
    ls.expand_or_jump()
  end
end, { silent = true, })

vim.keymap.set({ "i", "s", }, "<c-j>", function()
  if ls.jumpable(-1) then
    ls.jump(-1)
  end
end, { silent = true, })

vim.keymap.set("i", "<c-l>", function()
  if ls.choice_active() then
    ls.change_choice(1)
  end
end)
