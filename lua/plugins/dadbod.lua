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
  config = function()
    local keymap = vim.keymap.set
    local opts = { noremap = true, silent = true, }
    vim.g.db_ui_use_nerd_fonts = 1
    keymap({ "n", "o", "x", }, "<S-h>", "^", opts)
  end,
}
