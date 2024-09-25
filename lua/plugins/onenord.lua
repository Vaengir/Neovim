return {
  "rmehri01/onenord.nvim",
  lazy = false,
  opts = {
    disable = {
      float_background = true,
    },
    custom_highlights = {
      -- Override the background of the matching paren
      -- MatchParen = { fg = colors.yellow, bg = colors.light_gray, style = "bold" },
      MatchParen = { fg = "#EBCB8B", bg = "#6C7A96", style = "bold" },
    },
  },
}
