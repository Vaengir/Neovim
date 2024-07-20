return {
  dir = "~/vaengir/symbols-outline.nvim",
  cmd = { "SymbolsOutline", "SymbolsOutlineOpen", "SymbolsOutlineClose", },
  opts = {
    position = "left",
    relative_width = false,
    width = 45,
    show_relative_numbers = true,
    autofold_depth = 1,
  },
  keys = {
    { "<leader>s", "<cmd>SymbolsOutline<cr>", desc = "Toggle Symbol Sidebar", },
  },
}
