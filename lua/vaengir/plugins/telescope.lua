return {
  "nvim-telescope/telescope.nvim",
  version = "*",
  cmd = { "Telescope", },
  dependencies = {
    "nvim-lua/plenary.nvim",
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
      cond = function()
        return vim.fn.executable "make" == 1
      end,
    },
  },
  config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")
    telescope.setup {
      defaults = {
        prompt_prefix = " ",
        selection_caret = " ",
        path_display = { "smart", },
        mappings = {
          i = {
            ["<C-n>"] = actions.cycle_history_next,
            ["<C-p>"] = actions.cycle_history_prev,
            ["<C-j>"] = actions.move_selection_next,
            ["<C-k>"] = actions.move_selection_previous,
            ["jk"] = actions.close,
          },
        },
      },
    }
  end,
  keys = {
    { "<leader>fb", "<cmd>Telescope buffers<cr>",                desc = "Show Buffers", },
    { "<leader>fd", "<cmd>Telescope git_status<cr>",             desc = "Show Git Diff", },
    { "<leader>fh", "<cmd>Telescope find_files hidden=true<cr>", desc = "Find Hidden Files", },
    { "<leader>fj", "<cmd>Telescope jumplist<cr>",               desc = "Jumplist", },
    { "<leader>fk", "<cmd>Telescope lsp_document_symbols<cr>",   desc = "Find LSP elements in file", },
    { "<leader>fq", "<cmd>Telescope quickfix<cr>",               desc = "Quickfixlist", },
    { "<leader>fr", "<cmd>Telescope lsp_references<cr>",         desc = "References", },
    { "<leader>fs", "<cmd>Telescope live_grep<cr>",              desc = "Find Strings", },
    { "<leader>ft", "<cmd>Telescope builtin<cr>",                desc = "Select Telescope mode", },
    { "<leader>fv", "<cmd>Telescope help_tags<cr>",              desc = "Find Help Entries", },
    {
      "<leader>fw",
      function()
        local word = vim.fn.expand("<cword>")
        require("telescope.builtin").grep_string({ search = word, })
      end,
      desc = "Find word",
    },
    {
      "<leader>fW",
      function()
        local word = vim.fn.expand("<cWORD>")
        require("telescope.builtin").grep_string({ search = word, })
      end,
      desc = "Find WORD",
    },
  },
}
