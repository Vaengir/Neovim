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

ls.add_snippets("tex", {

  s({ trig = "fig", name = "Figure", dscr = "Create figure template", },
    fmta(
      [[
        \begin{figure}[htb]
          \centering
          \includegraphics[<><>]{<>}
          \caption[<>]{<> \footnotemark}
          \label{abb:<>}
        \end{figure}
        \footnotetext{<>\cite{<>}}
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

  s({ trig = "tab", name = "Table", dscr = "Create table template", },
    fmta(
      [[
        \begin{table}[htb]
          \centering
          \begin{tabular}{<>}
            <>
          \end{tabular}
        \caption{<>}
        \label{tab:<>}
        \end{table}
      ]],
      {
        i(1),
        i(2),
        i(3),
        i(4),
      }
    )
  ),

  s({ trig = "lst", name = "Listing", dscr = "Create listing template", },
    fmta(
      [[
        \begin{lstlisting}[language=<>, caption=<>, label=lst:<>]
          <>
        \end{lstlisting}
      ]],
      {
        i(1),
        i(2),
        rep(2),
        i(3, "Code goes here"),
      }
    )
  ),

  s({ trig = "abb:ref", name = "Reference for a figure", dscr = "Create a reference to a figure", },
    fmta(
      [[
        Abbildung~\ref{abb:<>}
      ]],
      {
        i(1),
      }
    )
  ),

  s({ trig = "fc", name = "Footcite", dscr = "Snippet to cite with footnote in one", },
    fmta(
      [[
        \footcite[<>][<>]{<>}
      ]],
      {
        c(1, { t { "", }, t { "Vgl.", }, }),
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

  s({ trig = "acro", name = "New acronym", dscr = "Create new acronym", },
    fmta(
      [[
        \acro{<>}{<>}
      ]],
      {
        i(1, "Acronym"),
        i(2, "Long form"),
      }
    )
  ),

  s({ trig = "ac", name = "Text acronym", dscr = "Add acronym to text", },
    fmta(
      [[
        \ac{<>}
      ]],
      {
        i(1, "Acronym"),
      }
    )
  ),

  s({ trig = "acl", name = "Long text acronym", dscr = "Add long version of acronym to text", },
    fmta(
      [[
        \acl{<>}
      ]],
      {
        i(1, "Acronym"),
      }
    )
  ),

  s({ trig = "cha", name = "Chapter", dscr = "Create a new Chapter", },
    fmta(
      [[
        \chapter{<>}
        \label{chap:<>}

        <>

        % End Chapter: <>

      ]],
      {
        i(1),
        rep(1),
        i(0, "Insert Text here..."),
        rep(1),
      }
    )
  ),

  s({ trig = "cha:ref", name = "Chapter reference", dscr = "Create a reference to a chapter", },
    fmta(
      [[
        Kapitel~\ref{cha:<>}
      ]],
      {
        i(1),
      }
    )
  ),

  s({ trig = "sec", name = "Section", dscr = "Create a new Section", },
    fmta(
      [[
        \section{<>}
        \label{sec:<>}

        <>

        % End Section: <>

      ]],
      {
        i(1),
        rep(1),
        i(0, "Insert Text here..."),
        rep(1),
      }
    )
  ),

  s({ trig = "sub", name = "Subsection", dscr = "Create a new Subsection", },
    fmta(
      [[
        \subsection{<>}
        \label{sub:<>}

        <>

        % End Subsection: <>

      ]],
      {
        i(1),
        rep(1),
        i(0, "Insert Text here..."),
        rep(1),
      }
    )
  ),

  s({ trig = "subs", name = "Subsubsection", dscr = "Create a new Subsubsection", },
    fmta(
      [[
        \subsubsection{<>}
        \label{subs:<>}

        <>

        % End Subsubsection: <>

      ]],
      {
        i(1),
        rep(1),
        i(0, "Insert Text here..."),
        rep(1),
      }
    )
  ),

  s({ trig = "par", name = "Paragraph", dscr = "Create a new Paragraph", },
    fmta(
      [[
        \paragraph{<>}
        \label{par:<>}

        <>

        % End Paragraph: <>

      ]],
      {
        i(1),
        rep(1),
        i(0, "Insert Text here..."),
        rep(1),
      }
    )
  ),

})
