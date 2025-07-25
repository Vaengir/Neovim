return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  branch = "main",
  dependencies = {
    {
      "nvim-treesitter/nvim-treesitter-textobjects",
      branch = "main",
    },
    "nvim-treesitter/nvim-treesitter-context",
    {
      "rayliwell/tree-sitter-rstml",
      build = ":TSUpdate",
      opts = {},
    },
    {
      "aaronik/treewalker.nvim",
      opts = {},
      keys = {
        { "<C-S-H>", "<cmd>Treewalker Left<cr>",  desc = "Treewalk left", },
        { "<C-S-J>", "<cmd>Treewalker Down<cr>",  desc = "Treewalk down", },
        { "<C-S-K>", "<cmd>Treewalker Up<cr>",    desc = "Treewalk up", },
        { "<C-S-L>", "<cmd>Treewalker Right<cr>", desc = "Treewalk right", },
      },
    },
  },
  event = { "BufReadPre", "BufNewFile", },
  config = function()
    local ts_configs = require("nvim-treesitter.config")
    ts_configs.setup({
      ensure_installed = {
        "bash",
        "bibtex",
        "css",
        "html",
        "java",
        "javascript",
        "kotlin",
        "lua",
        "latex",
        "markdown",
        "markdown_inline",
        "php",
        "python",
        "rust",
        "typescript",
        "vim",
      },
      auto_install = true,
      highlight = {
        enable = true,
        disable = function(_, buf)
          local max_filesize = 100 * 1024 -- 100KB
          local filename = vim.api.nvim_buf_get_name(buf)
          local ok, stats = pcall(vim.uv.fs_stat, filename)
          if ok and stats and stats.size > max_filesize then
            return true
          end
        end,
        additional_vim_regex_highlighting = false,
      },
      autopairs = {
        enable = true,
      },
      indent = { enable = true, disable = {}, },
      textobjects = {
        select = {
          enable = true,
          lookahead = true,
          keymaps = {
            ["a/"] = "@comment.outer",
            ["i/"] = "@comment.inner",
            ["aA"] = "@attribute.outer",
            ["iA"] = "@attribute.inner",
            ["aa"] = "@parameter.outer",
            ["ia"] = "@parameter.inner",
            ["ab"] = "@block.outer",
            ["ib"] = "@block.inner",
            ["ac"] = "@call.outer",
            ["ic"] = "@call.inner",
            ["aF"] = "@frame.outer",
            ["iF"] = "@frame.inner",
            ["af"] = "@function.outer",
            ["if"] = "@function.inner",
            ["ai"] = "@conditional.outer",
            ["ii"] = "@conditional.inner",
            ["al"] = "@loop.outer",
            ["il"] = "@loop.inner",
            ["as"] = "@statement.outer",
            ["is"] = "@scopename.inner",
            ["at"] = "@class.outer",
            ["it"] = "@class.inner",
          },
        },
        move = {
          enable = true,
          set_jumps = true,
          goto_next_start = {
            ["]m"] = "@function.outer",
            ["]["] = "@class.outer",
          },
          goto_next_end = {
            ["]M"] = "@function.outer",
            ["]]"] = "@class.outer",
          },
          goto_previous_start = {
            ["[m"] = "@function.outer",
            ["[["] = "@class.outer",
          },
          goto_previous_end = {
            ["[M"] = "@function.outer",
            ["[]"] = "@class.outer",
          },
        },
        swap = {
          enable = true,
          swap_next = {
            ["<leader>a"] = { query = "@parameter.inner", desc = "Swap with next parameter", },
          },
          swap_previous = {
            ["<leader>A"] = { query = "@parameter.inner", desc = "Swap with previous parameter", },
          },
        },
      },
    })
  end,
}
