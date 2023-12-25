return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  dependencies = { "nvim-treesitter/nvim-treesitter-textobjects", },
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
      highlight = {
        enable = true,
      },
      autopairs = {
        enable = true,
      },
      indent = { enable = true, disable = {}, },
      additional_vim_regex_highlighting = false,
      textobjects = {
        select = {
          enable = true,
          lookahead = true,
          keymaps = {
            ['aa'] = '@parameter.outer',
            ['ia'] = '@parameter.inner',
            ['af'] = '@function.outer',
            ['if'] = '@function.inner',
            ['ac'] = '@class.outer',
            ['ic'] = '@class.inner',
          },
        },
        move = {
          enable = true,
          set_jumps = true,
          goto_next_start = {
            [']m'] = '@function.outer',
            [']['] = '@class.outer',
          },
          goto_next_end = {
            [']M'] = '@function.outer',
            [']]'] = '@class.outer',
          },
          goto_previous_start = {
            ['[m'] = '@function.outer',
            ['[['] = '@class.outer',
          },
          goto_previous_end = {
            ['[M'] = '@function.outer',
            ['[]'] = '@class.outer',
          },
        },
        swap = {
          enable = true,
          swap_next = {
            ['<leader>a'] = { query = '@parameter.inner', desc = "Swap with next parameter", },
          },
          swap_previous = {
            ['<leader>A'] = { query = '@parameter.inner', desc = "Swap with previous parameter", },
          },
        },
      },
    })
  end,
}
