return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  dependencies = {
    "nvim-treesitter/nvim-treesitter-textobjects",
    "nvim-treesitter/nvim-treesitter-context",
  },
  event = { "BufReadPre", "BufNewFile", },
  config = function()
    local ts_configs = require("nvim-treesitter.configs")
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
