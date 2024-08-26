return {
  "stevearc/quicker.nvim",
  event = "FileType qf",
  config = function()
    require("quicker").setup({})
  end,
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
