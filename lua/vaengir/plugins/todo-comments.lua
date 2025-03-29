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
  keys = {
    { "<leader>tf", "<cmd>TodoTelescope<cr>",                            desc = "Show TODOs", },
    { "<leader>tn", "<cmd>lua require('todo-comments').jump_next()<cr>", desc = "Jump to next TODO", },
    { "<leader>tp", "<cmd>lua require('todo-comments').jump_prev()<cr>", desc = "Jump to previous TODO", },
    { "<leader>tq", "<cmd>TodoQuickFix<cr>",                             desc = "Send TODOs to Quickfix", },
  },
}
