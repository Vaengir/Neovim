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
    dependencies = {
      {
        "jecaro/fugitive-difftool.nvim",
        config = function()
          -- Jump to the first quickfix entry
          vim.api.nvim_create_user_command("Gcfir", require("fugitive-difftool").git_cfir, {})
          -- To the last
          vim.api.nvim_create_user_command("Gcla", require("fugitive-difftool").git_cla, {})
          -- To the next
          vim.api.nvim_create_user_command("Gcn", require("fugitive-difftool").git_cn, {})
          -- To the previous
          vim.api.nvim_create_user_command("Gcp", require("fugitive-difftool").git_cp, {})
          -- To the currently selected
          vim.api.nvim_create_user_command("Gcc", require("fugitive-difftool").git_cc, {})
        end,
      },
    },
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
