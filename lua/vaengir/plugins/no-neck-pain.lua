return {
  "shortcuts/no-neck-pain.nvim",
  dependencies = {},
  version = "*",
  config = function()
    require("no-neck-pain").setup({
      width = 100,
      buffers = {
        --- Options applied to the `left` buffer, options defined here overrides the `buffers` ones.
        ---@see NoNeckPain.bufferOptions `:h NoNeckPain.bufferOptions`
        left = NoNeckPain.bufferOptions,
        --- Options applied to the `right` buffer, options defined here overrides the `buffers` ones.
        ---@see NoNeckPain.bufferOptions `:h NoNeckPain.bufferOptions`
        right = { enabled = false, },
      },
    })
  end,
  keys = {
    { "<leader>N", "<cmd>NoNeckPain<cr>", desc = "Toggle Sidebuffers", },
  },
}
