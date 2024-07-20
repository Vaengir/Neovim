return {
  "kristijanhusak/vim-dadbod-ui",
  cmd = {
    "DBUI",
    "DBUIToggle",
    "DBUIAddConnection",
    "DBUIFindBuffer",
  },
  dependencies = {
    { "tpope/vim-dadbod", lazy = true, },
  },
  init = function()
    vim.g.db_ui_use_nerd_fonts = 1
  end,
  keys = {
    { "<leader>D", "<cmd>DBUIToggle<cr>", desc = "Toggle Dadbod-UI", },
  },
}
