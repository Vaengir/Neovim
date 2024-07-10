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
  },
  "tpope/vim-sleuth",
  "tpope/vim-surround",
}
