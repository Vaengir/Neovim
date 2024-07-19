return {
  "lewis6991/gitsigns.nvim",
  event = { "BufReadPre", "BufNewFile", },
  opts = {
    signs = {
      add = { text = "▎", },
      change = { text = "▎", },
      delete = { text = "󰐊 ", },
      topdelete = { text = "󰐊 ", },
      changedelete = { text = "~ ", },
      untracked = { text = "┆ ", },
    },
    attach_to_untracked = true,
  },
  keys = {
    { "<leader>gh", "<cmd>Gitsigns preview_hunk<cr>",              desc = "Preview Git Hunk", },
    { "<leader>gr", "<cmd>Gitsigns refresh<cr>",                   desc = "Refresh Gitsigns", },
    { "<leader>gt", "<cmd>Gitsigns toggle_current_line_blame<cr>", desc = "Preview Git Hunk", },
  },
}
