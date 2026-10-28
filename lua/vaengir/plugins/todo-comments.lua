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
    { "<leader>tf", "<cmd>TodoTelescope<cr>",                                                      desc = "Show TODOs", },
    { "<leader>tq", "<cmd>TodoQuickFix<cr>",                                                       desc = "Send TODOs to Quickfix", },
    { "<leader>tt", "<cmd>Telescope tatr<cr>",                                                     desc = "Show tatr tasks", },
    { "<leader>tc", function() require("telescope").extensions.tatr.tatr({ query = "-c", }) end,   desc = "Show closed tatr tasks", },
    { "<leader>tb", function() require("telescope").extensions.tatr.tatr({ query = ":bug", }) end, desc = "Show tatr bugs", },
  },
}
