return {
  {
    "tpope/vim-dispatch",
    cmd = { "Make", "Dispatch", },
    init = function()
      vim.g.dispatch_no_maps = 1
    end,
  },
  {
    "tpope/vim-fugitive",
    cmd = { "Git", "Ge", },
    keys = {
      { "<leader>gd", "<cmd>Git pull --rebase<cr>",             desc = "Pull remote Changes", },
      { "<leader>gg", "<cmd>Ge:<cr>",                           desc = "Open Fugitive", },
      { "<leader>gp", "<cmd>Git push<cr>",                      desc = "Push local Changes", },
      { "<leader>gs", "<cmd>Git submodule update --remote<cr>", desc = "Update submodules", },
    },
  },
  "tpope/vim-sleuth",
  "tpope/vim-surround",
}
