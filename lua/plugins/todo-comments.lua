return {
  "folke/todo-comments.nvim",
  dependencies = { "nvim-lua/plenary.nvim", },
  cmd = { "TodoTelescope", },
  event = "BufReadPost",
  opts = {
    keywords = {
      TEST = { icon = " ", color = "test", alt = { "TESTING", "PASSED", "FAILED", }, },
    },
  },
}
