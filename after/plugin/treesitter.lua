local status_ok, ts_configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
  return
end

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
    "php",
    "python",
    "rust",
    "typescript",
    "vim",
  },
  highlight = {
    enable = true, -- false will disable the whole extension
  },
  autopairs = {
    enable = true,
  },
  indent = { enable = true, disable = {}, },
  additional_vim_regex_highlighting = false,

  textobjects = {
    select = {
      enable = true,
      lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
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
      set_jumps = true, -- whether to set jumps in the jumplist
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
