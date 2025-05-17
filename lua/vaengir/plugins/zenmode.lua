return {
  "folke/zen-mode.nvim",
  cmd = { "ZenMode", },
  opts = {
    window = {
      width = 120,
      height = 0.9,
      options = {
        scrolloff = 999,
      },
    },
    plugins = {
      options = {
        enabled = true,
      },
      gitsigns = { enabled = false, },
    },
    on_open = function()
      vim.wo.wrap = true
    end,
    on_close = function()
      vim.wo.wrap = false
    end,
  },
  keys = {
    { "<leader>z", "<cmd>ZenMode<cr>", desc = "ZenMode", },
  },
}
