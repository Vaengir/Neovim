return {
  "hedyhli/outline.nvim",
  lazy = true,
  cmd = { "Outline", "OutlineOpen", },
  opts = {
    outline_window = {
      position = "left",
      width = 33,
      relative_width = false,
    },
  },
  keys = {
    { "<leader>S", "<cmd>Outline!<CR>", desc = "Toggle outline", },
  },
}
