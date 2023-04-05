local status_ok, luasnip = pcall(require, "luasnip")
if not status_ok then
  return
end

-- Shorthands
local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local l = require("luasnip.extras").lambda
local rep = require("luasnip.extras").rep
local p = require("luasnip.extras").partial
local m = require("luasnip.extras").match
local n = require("luasnip.extras").nonempty
local dl = require("luasnip.extras").dynamic_lambda
local fmt = require("luasnip.extras").fmt
local fmta = require("luasnip.extras").fmta
local types = require("luasnip.util.types")
local conds = require("luasnip.extras.conditions")
local conds_expand = require("luasnip.extras.conditions.expand")

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

-- For Tex files
ls.add_snippets("tex", {

  s("fig",
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

  s("fc",
    fmta(
      [[
        \footcite[<>][<>]{<>}
      ]],
      {
        c(1, { t { "", }, t { "Vgl. ", }, }),
        c(2, { t { "", }, t { "S. ", }, }),
        i(3),
        i(4),
      }
    )
  ),

  s("al", {
    t({ "\\glqq ", }),
  }),

  s("ar", {
    c(1, { t { "\\grqq ", }, t { "\\grqq{} ", }, }),
  }),

})

-- End Tex files

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
  if ls.jumpable( -1) then
    ls.jump( -1)
  end
end, { silent = true, })

vim.keymap.set("i", "<c-l>", function()
  if ls.choice_active() then
    ls.change_choice(1)
  end
end)
