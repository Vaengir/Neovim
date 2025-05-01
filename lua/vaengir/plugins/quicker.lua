return {
  "vaengir/quicker.nvim",
  branch = "main",
  event = "FileType qf",
  opts = {},
  keys = {
    {
      "<leader>bk",
      function()
        local height = math.floor(vim.o.lines / 3)
        require("quicker").toggle({ min_height = height, max_height = height, })
      end,
      desc = "Toggle Quickfix",
    },
  },
}
