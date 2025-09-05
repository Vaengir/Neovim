return {
  "mbbill/undotree",
  cmd = "UndotreeToggle",
  init = function()
    vim.g.undotree_SplitWidth = 33
    vim.g.undotree_WindowLayout = 2
    vim.g.undotree_SetFocusWhenToggle = 1
  end,
  keys = {
    { "<leader>u", "<cmd>UndotreeToggle<cr>", desc = "UndoTree", },
  },
}
