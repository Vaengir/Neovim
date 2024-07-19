return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    delay = 300,
    plugins = {
      marks = false,
      registers = true,
      spelling = {
        enabled = false,
        suggestions = 20,
      },
      presets = {
        operators = false,
        motions = true,
        text_objects = true,
        windows = true,
        nav = true,
        z = true,
        g = true,
      },
    },
    win = {
      border = "single",
      padding = { 2, 2, },
    },
    layout = {
      width = { min = 20, max = 50, },
      spacing = 3,
    },
    icons = {
      mappings = false,
    },
    disable = {
      buftypes = {},
      filetypes = { "TelescopePrompt", },
    },
    spec = {
      { "<leader>b", group = "Build", icon = "󱁤 ", },
      { "<leader>f", group = "Telescope", icon = " ", },
      { "<leader>g", group = "Git", icon = "󰊢 ", },
      { "<leader>h", group = "Harpoon", icon = "󱡀 ", },
      { "<leader>k", group = "Lsp", icon = " ", },
      { "<leader>l", group = "VimTeX", icon = " ", },
      { "<leader>o", group = "Obsidian", icon = "󰇈 ", },
      { "<leader>t", group = "TODOs", icon = " ", },
    },
  },
  keys = {
    { "<leader>c", "<cmd>bd<cr>", desc = "Close Buffer", },
    { "<leader>d", "\"_d",        desc = "Delete to void register",     mode = { "n", "x", }, },
    { "<leader>q", "<cmd>q!<cr>", desc = "Quit",                        mode = { "n", "x", }, },
    { "<leader>w", "<cmd>w!<cr>", desc = "Save",                        mode = { "n", "x", }, },
    { "<leader>y", "\"+y",        desc = "Yank to system clipboard",    mode = { "n", "x", }, },
    { "<leader>p", "\"+p",        desc = "Paste from system clipboard", mode = { "n", "x", }, },
  },
}
